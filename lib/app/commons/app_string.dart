import 'package:fraxinusfly/app/commons/all.dart';

class AppString {
  static String appName = "Fraxinus";

  // Company code
  static String enterYouClientCode = "Enter Your Client Code";
  static String selectCompany = "Select Company";
  static String next = "NEXT";
  static String loadCompanyList = "Load Company List";

  // LOG IN
  static String welcomeBack = "Welcome back!";
  static String pleaseLoginToContinue = "Please Login to Continue";
  static String userName = "User Name";
  static String password = "Password";
  static String enterPassword = "Enter your password";
  static String enterUserName = "Enter your UserName";
  static String login = "Login";

  //Home
  static String main = "Main";
  static String hiWelcomeBack = "Hi, welcome back!";
  static String salesAndPurchase = "Sales and Purchase monitoring dashboard.";
  static String transaction = "Transaction";
  static String reports = "Reports";

  //Main
  static String todayTotal = "Today's Total Sales:";
  static String monthlyTotal = "Monthly Total Sales:";
  static String todayPurchase = "Today's Total Purchase:";
  static String monthlyPurchase = "Monthly Total Purchase:";

  //Transaction
  static String quotation = "Quotation";
  static String salesOrder = "Sales Order";
  static String salesInvoice = "Sales Invoice";

  //Reports
  static String itemList = "Item List";
  static String ledgerStatement = "Ledger Statement";
  static String saleRegister = "Sale Register";
  static String purchaseRegister = "Purchase Register";
  static String outstandingReceivable = "Outstanding Receivable";
  static String outstandingPayables = "Outstanding Payables";

  //Ledger Statement
  static String fromDate = "From Date";
  static String toDate = "To Date";
  static String ledger = "Ledger";
  static String showReport = "Show Report";
  static String downloadPdf = "Download PDF";

  //Sale Register
  static String customer = "Customer";
  static String branch = "Branch";
  static String supplier = "Supplier";

  //Outstanding
  static String asPerDate = "AsPer Date";
  static String city = "City";

  static String itemName = "Item Name";
  static String brand = "Brand";
  static String category = "Category";

  //Quotation
  static String startDate = "Start Date";
  static String endDate = "End Date";
  static String date = "Date";
  static String textMode = "Tex Mode";
  static String invoiceType = "Invoice Type";
  static String invoiceSerialNo = "Invoice Serial No.";
  static String customerName = "Customer Name";
  static String contactNumber = "Contact Number";
  static String shippingAddress = "Shipping Address";
  static String CreditType = "Credit Type";
  static String gstIn = "GSTIN";
  static String remark = "Remark";
  static String gstType = "GST Type";
  static String gstTax = "GST Tax";
  static String addItem = "Add Item";
  static String save = "Save";
  static String itemDec = "Item Desc";
  static String unit = "Unit";
  static String qty = "Qty";
  static String price = "Price";
  static String discountPer = "Discount(%)";
  static String totalDiscount = "Total Discount";
  static String taxableAmount = "Taxable Amount";
  static String netPrice = "NetPrice(Inc Tax.)";
  static String netAmount = "Net Amount";
  static String grossAmount = "Gross Amount";
  static String discount = "Discount";
  static String CGSTPer = "CGSTPer";
  static String CGSTAmt = "CGSTAmt";
  static String SGSTPer = "SGSTPer";
  static String SGSTAmt = "SGSTAmt";
  static String IGSTPer = "IGSTPer";
  static String IGSTAmt = "IGSTAmt";
  static String deliveryDate = "Delivery Date";
  static String poDate = "PO Date";
  static String poNumber = "PO Number";
  static String transport = "Transport Name";
  static String status = "Status";
  static String remarks = "Remarks";
  static String salesPerson= "Sales Person";
  static String refDocChallanNo= "Ref Doc/Challan No.";

  static  pleaseEnter (String value) {
    return Utils().showSnackBar(context: Get.context!, message: "Please enter $value");
  }
}