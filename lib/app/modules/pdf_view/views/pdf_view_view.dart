import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controllers/pdf_view_controller.dart';

class PdfViewView extends GetView<PdfViewController> {
  const PdfViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfViewController>(
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.share),
            onPressed: () {
              if (controller.pdfContent.startsWith("http")) {
                Share.shareXFiles([XFile(controller.urlPath)]);
              } else {
                Share.shareXFiles([XFile(controller.generatedPdfFilePath)]);
              }
            },
          ),
          appBar: AppBar(
            title: const Text('PdfView'),
            centerTitle: true,
          ),
          body: controller.isShow
              ? controller.pdfContent.startsWith("http")
                  ? SfPdfViewer.network(
                      controller.pdfContent,
                      pageLayoutMode: PdfPageLayoutMode.continuous,
                      interactionMode: PdfInteractionMode.pan,
                    )
                  : (File(controller.generatedPdfFilePath).existsSync()
                      ? SfPdfViewer.file(
                          File(
                            controller.generatedPdfFilePath,
                          ),
                          pageLayoutMode: PdfPageLayoutMode.continuous,
                        )
                      : Center(child: Text("File not found!")))
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
