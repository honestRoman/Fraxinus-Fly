import '../modules/bottom_bar/model/customer_model.dart';
import '../modules/bottom_bar/model/get_branch_list_model.dart';
import '../modules/bottom_bar/model/get_gst_model.dart';
import '../modules/bottom_bar/model/get_item_list.dart';

class Constants {
  static String baseUrl = 'https://fraxinuswebapis.azurewebsites.net/api/';
  static String apiKey = '';
  static String dashboardElements = 'Dashboard/DashboardElements';
  static String todaysTotalsale = 'Dashboard/TodaysTotalsale';
  static String monthlyTotalsale = 'Dashboard/MonthlyTotalsale';
  static String todaysTotalpurchase = 'Dashboard/TodaysTotalpurchase';
  static String monthlyTotalpurchase = 'Dashboard/MonthlyTotalpurchase';
  static String sendOTP = 'User/SendOTP';
  static String getCustomerList = 'Master/GetCustomerList';
  static String getGstTaxList = 'Master/GetGstTaxList';
  static String getItemList = 'Master/GetItemList';
  static String getBranchList = 'Master/GetBranchList';
  static String quotationList = 'Quotation/QuotationList';
  static String nextSerialNo = 'Quotation/NextSerialNo';
  static String salesNextSerialNo = 'SaleInvoice/NextSerialNo';
  static String quotationData = 'Quotation/QuotationData';
  static String quotationPDFurl = 'Quotation/QuotationPDFurl';
  static String getUserPermissions = 'Master/GetUserPermissions';
  static String saveQuotation = 'Quotation/SaveQuotation';
  static String saveSaleInvoice = 'SaleInvoice/SaveSaleInvoice';
  static String getSalesPersonList = 'Master/GetSalesPersonList';
  static String updateQuotation = 'Quotation/UpdateQuotation';
  static String saleOrderList = 'SaleOrder/SaleOrderList';
  static String saveSaleOrder = 'SaleOrder/SaveSaleOrder';
  static String saleInvoiceList = 'SaleInvoice/SaleInvoiceList';
  static String nextOrderNo = 'SaleOrder/NextOrderNo';
  static String getBrandList = 'Master/GetBrandList';
  static String getCategoryList = 'Master/GetCategoryList';
  static String getSupplierList = 'Master/GetSupplierList';
  static String itemListApi = 'Reports/ItemList';
  static String ledgerStatement = 'Reports/LedgerStatement';
  static String saleRegister = 'Reports/SaleRegister';
  static String outstandingReceivables = 'Reports/OutstandingReceivables';
  static String purchaseRegister = 'Reports/PurchaseRegister';
  static String outstandingPayables = 'Reports/OutstandingPayables';
  static String getGlaccountList = 'Master/GetGlaccountList';
  static String YYYY_MM_DD_HH_MM_SS_24 = 'YYYY_MM_DD_HH_MM_SS_24';
  static String login = 'https://fraxinuswebapis.azurewebsites.net/api/User/UserLogin';

  static List<CustomerData> customerList = [];
  static List<GetGstData> gstList = [];
  static List<ItemData> itemList = [];
  static List<BranchData> branchList = [];

  static bool isAddAllowed = false;
}

List<ItemData> filteredItems = [];
List<CustomerData> filteredCustomer = [];
List<GetGstData> filteredGst = [];
List<BranchData> filteredBranch = [];


