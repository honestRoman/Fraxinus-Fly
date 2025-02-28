import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fraxinusfly/app/data/common_widget/common_textfeild.dart';
import 'package:fraxinusfly/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../../item_list/controllers/item_list_controller.dart';
import '../model/gl_account_model.dart';
import '../model/ledger_statement_model.dart';

class LedgerStatementController extends GetxController {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController ledgerController = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();
  String fromDateV = "${DateFormat('yyyy-MM').format(DateTime.now())}-01";
  String todoDateV = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<GlAccountData> filteredItems = [];
  List<GlAccountData> glAccountList = [];
  List<ledgerData> ledgerList = [];
  String searchText = "";
  int ledgerId = 10;

  Future<void> selectDate(BuildContext context, String fromDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      final date = DateFormat("dd/MM/yyyy").format(picked).toString();
      if (fromDate == "from") {
        fromDateV = DateFormat("yyyy-MM-dd").format(picked).toString();
        fromDateController.text = date;
      } else {
        todoDateV = DateFormat("yyyy-MM-dd").format(picked).toString();
        toDateController.text = date;
      }
    }
  }

  void filterItems(String query) {
    searchText = query;
    if (query.isEmpty) {
      filteredItems = glAccountList;
    } else {
      filteredItems = glAccountList
          .where((item) =>
              item.glAccountName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void selectLedger() {
    Get.bottomSheet(
      GetBuilder<LedgerStatementController>(
        builder: (controller) {
          return DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  CommonTextField(
                    controller: searchFieldController,
                    borderRadius: 12,
                    prefix: Icon(Icons.search),
                    onChanged: (p0) {
                      filterItems(p0);
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: GestureDetector(
                            onTap: () {
                              ledgerController.text =
                                  filteredItems[index].glAccountName ?? "";
                              ledgerId =
                                  filteredItems[index].glAccountNumber ?? 0;
                              ledgerListApi();
                              Get.back();
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12)),
                              child: commonTableText(
                                  title: controller
                                      .filteredItems[index].glAccountName),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void onInit() {
    apiCallSupplier();
    ledgerListApi();
    super.onInit();
  }

  Future<void> ledgerListApi() async {
    String url =
        "${Constants.ledgerStatement}?GLAccountNumber=$ledgerId&FromDate=$fromDateV&ToDate=$todoDateV";

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    GetLedgerStatementModel model = GetLedgerStatementModel.fromJson(data);
    if (model.statusCode == 200) {
      ledgerList = model.data ?? [];
      update();
    }
  }

  void genaratePDFApi() async {
    String url =
        "Reports/LedgerStatementPDFurl?GLAccountNumber=$ledgerId&FromDate=$fromDateV&ToDate=$todoDateV";

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    Get.toNamed(Routes.PDF_VIEW, arguments: data);
    update();
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

    } catch (err) {
    }
  }

  Future<void> apiCallSupplier() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getGlaccountList,
      context: Get.context!,
      params: formData,
    );

    GlAccountModel model = GlAccountModel.fromJson(data);
    if (model.statusCode == 200) {
      glAccountList = model.data ?? [];
      filteredItems = model.data ?? [];
      update();
    }
  }
}
