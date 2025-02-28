import 'package:fraxinusfly/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../item_list/controllers/item_list_controller.dart';
import '../model/purchase_register_model.dart';
import '../model/purchase_register_model_data.dart';

class PurchaseRegisterController extends GetxController {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController ledgerController = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  String fromDateV = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String todoDateV = DateFormat('MM/dd/yyyy').format(DateTime.now());
  int supplierId = 0;
  int branchId = 0;

  Future<void> selectDate(BuildContext context, String fromDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      final date = DateFormat("MM/dd/yyyy").format(picked).toString();
      if (fromDate == "from") {
        fromDateV = date;
        fromDateController.text = date;
      } else {
        todoDateV = date;
        toDateController.text = date;
      }
      await purchaseRegisterListApi();
      update();
    }
  }

  List<PurchaseData> filteredItems = [];
  String searchText = "";

  void filterItems(String query) {
    searchText = query;
    if (query.isEmpty) {
      filteredItems = supplierList;
    } else {
      filteredItems = supplierList
          .where((item) =>
              item.supplierName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void selectLedger() {
    filteredCustomer = Constants.customerList;
    Get.bottomSheet(
      GetBuilder<PurchaseRegisterController>(
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
                              ledgerController.text = controller
                                      .filteredItems[index].supplierName ??
                                  "";
                              supplierId =
                                  controller.filteredItems[index].supplierID ??
                                      0;
                              purchaseRegisterListApi();
                              Get.back();
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: commonTableText(
                                  title: controller
                                      .filteredItems[index].supplierName),
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
      GetBuilder<PurchaseRegisterController>(
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
                              purchaseRegisterListApi();
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
    purchaseRegisterListApi();
    super.onInit();
  }

  List<PurchaseData> supplierList = [];
  List<Data> registerData = [];

  Future<void> purchaseRegisterListApi() async {
    String url =
        "${Constants.purchaseRegister}?FromDate=$fromDateV&ToDate=$todoDateV";

    if (supplierId != 0) {
      url = url + "&" + "SupplierID=$supplierId";
    }
    if (branchId != 0) {
      url = url + "&" + "BranchID=$branchId";
    }

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    PurchaseRegisterApiModel model = PurchaseRegisterApiModel.fromJson(data);
    if (model.statusCode == 200) {
      registerData = model.data ?? [];
      update();
    }
  }

  void genaratePDFApi() async {
    String url =
        "Reports/PurchaseRegisterPDFurl?FromDate=$fromDateV&ToDate=$todoDateV";

    if (supplierId != 0) {
      url = url + "&" + "SupplierID=$supplierId";
    }
    if (branchId != 0) {
      url = url + "&" + "BranchID=$branchId";
    }
    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    Get.toNamed(Routes.PDF_VIEW, arguments: data);
  }
}
