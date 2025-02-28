import 'dart:io';
import 'package:get/get.dart';
import 'package:html_to_pdf/html_to_pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewController extends GetxController {
  String pdfContent = "";
  String generatedPdfFilePath = '';
  String urlPath = '';
  bool isShow = false;

  @override
  void onInit() async {
    super.onInit();
    await requestStoragePermission();
    if (Get.arguments != null) {
      pdfContent = Get.arguments;
      isShow = false;
      if (pdfContent.startsWith("http")) {
        isShow = true;
        downloadFile(pdfContent.split("/").last, pdfContent);
      } else {
        generatePdfFromHtml();
      }
    }
  }

  Future<void> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
      } else if (await Permission.manageExternalStorage.request().isGranted) {
      } else {
        openAppSettings();
      }
    }
  }

  Future<void> downloadFile(String fileName, String documentUrl) async {
    try {
      final directory = await getExternalStorageDirectory();
      final dirPath = directory?.path ?? "/storage/emulated/0/Download";
      final filePath = '$dirPath/$fileName';

      if (await File(filePath).exists()) {
        urlPath = filePath;
        isShow = true;
        update();
        return;
      }

      final request = await HttpClient().getUrl(Uri.parse(documentUrl));
      final response = await request.close();

      if (response.statusCode == 200) {
        final file = File(filePath);
        await response.pipe(file.openWrite());
        urlPath = file.path;
        isShow = true;
        update();
      } else {
      }
    } catch (err) {
    }
  }

  Future<void> generatePdfFromHtml() async {
    final directory = await getExternalStorageDirectory();
    final targetPath = directory?.path ?? "/storage/emulated/0/Download/";
    final targetFileName = 'output_${DateTime.now().millisecondsSinceEpoch}';

    final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
      htmlContent: pdfContent,
      printPdfConfiguration: PrintPdfConfiguration(
        targetDirectory: targetPath,
        targetName: targetFileName,
        printSize: PrintSize.A1,
        printOrientation: PrintOrientation.Portrait,
      ),
    );

    generatedPdfFilePath = generatedPdfFile.path;

    isShow = true;
    update();
  }
}
