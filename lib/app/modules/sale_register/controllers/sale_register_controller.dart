import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fraxinusfly/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../item_list/controllers/item_list_controller.dart';
import '../model/sale_register_model.dart';

class SaleRegisterController extends GetxController {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();

  String fromDateV = "${DateFormat('yyyy-MM').format(DateTime.now())}-01";
  String todoDateV = DateFormat('yyyy-MM-dd').format(DateTime.now());
  int branchId = 0;
  int customerId = 0;

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

  String searchText = "";

  void filterItems(String query) {
    searchText = query;
    if (query.isEmpty) {
      filteredCustomer = Constants.customerList;
    } else {
      filteredCustomer = Constants.customerList
          .where((item) =>
              item.customerName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void selectCustomer() {
    filteredCustomer = Constants.customerList;
    Get.bottomSheet(
      GetBuilder<SaleRegisterController>(
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
                      itemCount: filteredCustomer.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: GestureDetector(
                            onTap: () {
                              customerController.text =
                                  filteredCustomer[index].customerName ?? "";
                              customerId = filteredCustomer[index].customerID ?? 0;
                              saleRegisterListApi();
                              Get.back();
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12)),
                              child: commonTableText(
                                  title: filteredCustomer[index].customerName ??
                                      ""),
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

  void filterBranch(String query) {
    searchText = query;
    if (query.isEmpty) {
      filteredBranch = Constants.branchList;
    } else {
      filteredBranch = Constants.branchList
          .where((item) =>
              item.branchName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void selectBranch() {
    filteredBranch = Constants.branchList;
    Get.bottomSheet(
      GetBuilder<SaleRegisterController>(
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
                      filterBranch(p0);
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredBranch.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: GestureDetector(
                            onTap: () {
                              branchController.text =
                                  filteredBranch[index].branchName ?? "";
                              branchId = filteredBranch[index].branchID ?? 0;
                              saleRegisterListApi();
                              Get.back();
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12)),
                              child: commonTableText(
                                  title:
                                      filteredBranch[index].branchName ?? ""),
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
    saleRegisterListApi();
    super.onInit();
  }

  List<SaleRegisterData> saleRegisterList = [];

  Future<void> saleRegisterListApi() async {
    String url =
        "${Constants.saleRegister}?FromDate=$fromDateV&ToDate=$todoDateV";

    if (customerId != 0) {
      url = url + "&" + "CustomerID=$customerId";
    }
    if (branchId != 0) {
      url = url + "&" + "BranchID=$branchId";
    }

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    GetSaleRegisterModel model = GetSaleRegisterModel.fromJson(data);
    if (model.statusCode == 200) {
      saleRegisterList = model.data ?? [];
      update();
    }
  }

  void genaratePDFApi() async {
    String url =
        "Reports/SaleRegisterPDFurl?FromDate=$fromDateV&ToDate=$todoDateV";

    if (customerId != 0) {
      url = url + "&" + "CustomerID=$customerId";
    }
    if (branchId != 0) {
      url = url + "&" + "BranchID=$branchId";
    }

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    Get.toNamed(Routes.PDF_VIEW, arguments: data);
    downloadFile(data!.downloadurl!.split("/").last, data);

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
