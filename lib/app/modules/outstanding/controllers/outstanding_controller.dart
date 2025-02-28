import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fraxinusfly/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../model/outstanding_model.dart';
import '../model/outstanding_payables_model.dart';

class OutstandingController extends GetxController {
  String title = "";
  TextEditingController asPerDateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String dateValue = DateTime.now().toString();

  @override
  void onInit() {
    if (Get.arguments != null) {
      title = Get.arguments;
    }
    if(title == AppString.outstandingReceivable)
      {
    outStandingListApi();
      }
    else
      {
        outStandingPayableListApi();
      }
    super.onInit();
  }

  Future<void> selectDate(BuildContext context, String fromDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      final date = DateFormat("dd/MM/yyyy").format(picked).toString();
      dateValue = DateFormat("MM/dd/yyyy").format(picked).toString();
      asPerDateController.text = date;
      if(title == AppString.outstandingReceivable)
        {
          outStandingListApi();
        }
      else
        {
          outStandingPayableListApi();
        }
    }
  }

  List<OutStandingData> outStandingList = [];
  List<PayableData> outStandingPayableList = [];

  Future<void> outStandingListApi() async {
    String url = "${Constants.outstandingReceivables}?AsPerDate=$dateValue";

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    GetOutstandingReceivablesModel model = GetOutstandingReceivablesModel.fromJson(data);
    if(model.statusCode == 200)
    {
      outStandingList = model.data ?? [];
      update();
    }
  }

  Future<void> outStandingPayableListApi() async {
    String url = "${Constants.outstandingPayables}?AsOnDate=$dateValue";

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    GetOutstandingPayablesModel model = GetOutstandingPayablesModel.fromJson(data);
    if(model.statusCode == 200)
    {
      outStandingPayableList = model.data ?? [];
      update();
    }
  }


  void genarateRecivePDFApi() async {
    String url = "Reports/OutstandingReceivablesPDFurl?AsPer_Date=$dateValue";
    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    Get.toNamed(Routes.PDF_VIEW, arguments: data);
    update();

  }

  void genaratePDFApi() async {
    String url = "Reports/OutstandingPayablesPDFurl?AsOnDate=$dateValue";
    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );
    Get.toNamed(Routes.PDF_VIEW, arguments: data);
  }

  downloadFile(var filePath, var documentUrl) async {
    try {
      final filename = filePath;
      String dir = "/storage/emulated/0/Download";
      if (await File('$dir/$filename').exists()) return File('$dir/$filename');

      String url = documentUrl;
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
    }
    catch (err) {
    }
  }
}
