import 'package:dio/dio.dart';
import 'package:fraxinusfly/app/api_common/api_function.dart';
import 'package:fraxinusfly/app/modules/bottom_bar/views/main_home_view.dart';
import 'package:fraxinusfly/app/modules/bottom_bar/views/report_view.dart';
import 'package:fraxinusfly/app/modules/bottom_bar/views/transaction_view.dart';
import '../../../commons/all.dart';
import '../model/customer_model.dart';
import '../model/dashboard_model.dart';
import '../model/get_branch_list_model.dart';
import '../model/get_gst_model.dart';
import '../model/get_item_list.dart';
import '../model/get_permission_model.dart';

class BottomBarController extends GetxController {
  RxInt indexCount = 0.obs;
  List<DashboardData> dashBoardList = [];
  String todaySale = "";
  String monthSale = "";
  String todayPurchase = "";
  String monthPurchase = "";

  List<Widget> screen = [
    MainHomeView(),
    TransactionView(),
    ReportView(),
  ];

  List<CommonModel> transactionTab = [
    CommonModel(image: AppImages.quotation, name: AppString.quotation),
    CommonModel(image: AppImages.salesOrder, name: AppString.salesOrder),
    CommonModel(image: AppImages.invoice, name: AppString.salesInvoice)
  ];

  List<CommonModel> reportList = [
    CommonModel(image: AppImages.itemList, name: AppString.itemList),
    CommonModel(
        image: AppImages.ledgerStatement, name: AppString.ledgerStatement),
    CommonModel(image: AppImages.saleReister, name: AppString.saleRegister),
    CommonModel(
        image: AppImages.purchaseRegister, name: AppString.purchaseRegister),
    CommonModel(
        image: AppImages.receivable, name: AppString.outstandingReceivable),
    CommonModel(image: AppImages.payable, name: AppString.outstandingPayables),
  ];

  Future<void> apiCallDashboard() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.dashboardElements,
      context: Get.context!,
      params: formData,
    );

    DashboardModel model = DashboardModel.fromJson(data);
    if (model.statusCode == 200) {
      model.data!.forEach(
        (element) {
          if (element.elementTitle == "Today's Total Sale") {
            todaySale = element.value ?? "0.00";
          } else if (element.elementTitle == "Monthly Total Sale") {
            monthSale = element.value ?? "0.00";
          } else if (element.elementTitle == "Today's Total Purchase") {
            todayPurchase = element.value ?? "0.00";
          } else if (element.elementTitle == "Monthly Total Purchase") {
            monthPurchase = element.value ?? "0.00";
          }
        },
      );
      update();
    }
  }

  Future<void> apiCallCustomer() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getCustomerList,
      context: Get.context!,
      params: formData,
    );

    CustomerModel model = CustomerModel.fromJson(data);
    if (model.statusCode == 200) {
      Constants.customerList = model.data ?? [];
      update();
    }
  }

  Future<void> apiCallGetPermission() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getUserPermissions,
      context: Get.context!,
      params: formData,
    );

    GetUserPermissionsModel model = GetUserPermissionsModel.fromJson(data);

    if (model.statusCode == 200) {
      model.data!.forEach(
        (element) {
          Constants.isAddAllowed = element.allowAddEntry ?? false;
        },
      );
      update();
    }
  }

  Future<void> apiCallGetGst() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getGstTaxList,
      context: Get.context!,
      params: formData,
    );

    GetGstTaxListModel model = GetGstTaxListModel.fromJson(data);
    if (model.statusCode == 200) {
      Constants.gstList = model.data ?? [];
      update();
    }
  }

  Future<void> apiCallGetItem() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getItemList,
      context: Get.context!,
      params: formData,
    );

    GetItemListModel model = GetItemListModel.fromJson(data);
    if (model.statusCode == 200) {
      Constants.itemList = model.data ?? [];
      update();
    }
  }

  Future<void> apiCallBranch() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getBranchList,
      context: Get.context!,
      params: formData,
    );

    GetBranchListModel model = GetBranchListModel.fromJson(data);
    if (model.statusCode == 200) {
      Constants.branchList = model.data ?? [];
      update();
    }
  }

  @override
  void onInit() {
    apiCallDashboard();
    apiCallGetPermission();
    apiCallGetGst();
    apiCallCustomer();
    apiCallBranch();
    apiCallGetItem();
    super.onInit();
  }
}

class CommonModel {
  final String? image;
  final String? name;

  CommonModel({
    this.image,
    this.name,
  });
}
