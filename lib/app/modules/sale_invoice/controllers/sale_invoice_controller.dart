import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../api_common/api_function.dart';
import '../../../api_common/loading.dart';
import '../../../commons/all.dart';
import '../../../commons/get_storage_data.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../../routes/app_pages.dart';
import '../../item_list/controllers/item_list_controller.dart';
import '../../quotation/model/new_serial_model.dart';
import '../../quotation/model/quotation_pdf_model.dart';
import '../../quotation/model/save_quotation_model.dart';
import '../model/sales_invoice_detail_model.dart';
import '../model/sales_invoice_model.dart';
import '../model/sales_person_list_model.dart';

class SaleInvoiceController extends GetxController {
  RxBool isAdd = false.obs;
  int? selectedItemId;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController addDateController = TextEditingController();
  TextEditingController addInvoiceTypeController =
      TextEditingController(text: "Bill of Supply");
  TextEditingController addCustomerNameController = TextEditingController();
  TextEditingController addCustomerNumberController = TextEditingController();
  TextEditingController addShippingAddressController = TextEditingController();
  TextEditingController addCreditDaysController =
      TextEditingController(text: "0");
  TextEditingController addGSTinController = TextEditingController();
  TextEditingController addSalesNameController = TextEditingController();
  TextEditingController addSerialController = TextEditingController();
  TextEditingController addRemarkController = TextEditingController();
  TextEditingController addGstTypeController = TextEditingController();
  TextEditingController addRefController = TextEditingController();
  TextEditingController itemDesController = TextEditingController();
  TextEditingController itemUnitController = TextEditingController();
  TextEditingController itemQtyController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemDiscountController = TextEditingController();

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController itemTaxablePriceController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController itemNetPriceController = TextEditingController();
  TextEditingController addGstController = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();
  TextEditingController itemDiscountPerController = TextEditingController();
  TextEditingController itemTotalDiscountController = TextEditingController();
  TextEditingController itemGrossAmountController = TextEditingController();
  TextEditingController itemCGstPerController = TextEditingController();
  TextEditingController itemSGstPerController = TextEditingController();
  TextEditingController itemIGstPerController = TextEditingController();
  TextEditingController itemCGstAmtController = TextEditingController();
  TextEditingController itemSGstAmtController = TextEditingController();
  TextEditingController itemIGstAmtController = TextEditingController();
  TextEditingController itemNetAmountController = TextEditingController();
  RxBool isOpen = false.obs;
  bool isUpdate = false;
  int key = 0;
  int QuoteId = 0;
  String startDate = "";
  String poDate = "";
  String deliveryDate = "";
  int gstId = 0;
  String endDate = "";
  int customerId = 0;
  String total = "";
  String discountTotal = "";
  String cGstTotal = "";
  String sGstTotal = "";
  String iGstTotal = "";
  String totalItem = "";
  String netTotal = "";
  int salesPersonId = 0;

  List invoiceList = [
    'Bill of Supply',
    'Tax',
  ];

  List gstTYpe = [
    'CGST_SGST',
    'IGST',
  ];

  List<SaleDetails> itemList = [];

  List<SalesInvoiceData> quotationList = [];

  List<SalesPersonData> salesList = [];

  void filterSheet(BuildContext context) {
    Get.bottomSheet(isScrollControlled: true, GetBuilder<SaleInvoiceController>(
      builder: (controller) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(20),
              Text(
                "Search Quotation",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s24,
                ),
              ),
              Gap(10),
              Divider(
                color: Colors.black38,
                thickness: 1,
              ),
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                children: [
                  CommonTextField(
                    borderRadius: 12,
                    controller: startDateController,
                    title: AppString.startDate,
                    isTitle: true,
                    maxLength: 10,
                    inputFormatters: [
                      DateInputFormatter(),
                    ],
                    suffix: GestureDetector(
                      onTap: () {
                        selectDate(context, "from");
                      },
                      child: Icon(Icons.calendar_month),
                    ),
                  ),
                  Gap(10),
                  CommonTextField(
                    borderRadius: 12,
                    controller: endDateController,
                    title: AppString.endDate,
                    isTitle: true,
                    maxLength: 10,
                    inputFormatters: [
                      DateInputFormatter(),
                    ],
                    suffix: GestureDetector(
                      onTap: () {
                        selectDate(context, "to");
                      },
                      child: Icon(Icons.calendar_month),
                    ),
                  ),
                  Gap(10),
                  Text(
                    AppString.selectCompany,
                    style: TextStyle(
                      fontFamily: FontFamily.medium,
                      fontSize: FontSize.s16,
                      color: Colors.black38,
                    ),
                  ),
                  Gap(8),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isOpen.value ? Colors.blue : Colors.black38),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Theme(
                      data: ThemeData(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.zero,
                        dense: true,
                        key: Key(key.toString()),
                        onExpansionChanged: (value) {
                          isOpen.value = value;
                          update();
                        },
                        title: Text(
                          invoiceController.text,
                        ),
                        children: List.generate(
                          invoiceList.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                invoiceController.text = invoiceList[index];
                                collapse();
                                update();
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  invoiceList[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  CommonTextField(
                    borderRadius: 12,
                    controller: customerController,
                    title: AppString.supplier,
                    isTitle: true,
                    maxLength: 10,
                    hintText: "Please Select...",
                    showCursor: false,
                    readOnly: true,
                    onTap: () {
                      selectLedger();
                    },
                    suffix: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )),
                  ),
                  Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          btnName: "Search",
                          onTap: () {
                            salesInvoiceListApi();
                            Get.back();
                          },
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: CommonButton(
                          btnName: "Reset",
                          btnColor: Colors.deepPurple,
                          onTap: () {
                            Get.back();
                          },
                        ),
                      )
                    ],
                  ),
                  Gap(20),
                ],
              ),
            ],
          ),
        );
      },
    ));
  }

  List<String> filteredItems = [];
  List<String> customerName = [
    '3 STAR ADVERTISING',
    'A.JITENDERKUMAR & CO.',
    'AADARSH ASSOCIATES',
  ];

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredCustomer = Constants.customerList;
    } else {
      filteredCustomer = Constants.customerList
          .where((customer) => customer.customerName!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void selectLedger() {
    filteredItems = customerName;
    Get.bottomSheet(
      GetBuilder<SaleInvoiceController>(
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
                    controller: searchController,
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
                        return GestureDetector(
                            onTap: () {
                              customerController.text = filteredItems[index];
                              controller.update();
                              Get.back();
                            },
                            child: Text(filteredItems[index]));
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

  collapse() {
    int newKey = 0;
    do {
      key = new Random().nextInt(10000);
    } while (newKey == key);
  }

  Future<void> selectDate(BuildContext context, String fromDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      final date = DateFormat("dd/MM/yyyy").format(picked).toString();
      if (fromDate == "from") {
        startDate = picked.toIso8601String();
        startDateController.text = date;
      } else if (fromDate.toLowerCase() == "add") {
        addDateController.text = date;
      } else {
        endDate = picked.toIso8601String();
        endDateController.text = date;
      }
    }
  }

  void filterCustomer(String query) {
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

  void selectCustomerFromList(int index) {
    customerController.text = filteredCustomer[index].customerName ?? "";
    customerId = filteredCustomer[index].customerID ?? 0;
    addCustomerNumberController.text = filteredCustomer[index].contactNo ?? "";
    addGSTinController.text = filteredCustomer[index].gstinNumber ?? "";

    if (addInvoiceTypeController.text != "Bill of Supply") {
      addGstTypeController.text = filteredCustomer[index].gstType ?? "";
    }

    Get.back();
    update();
  }

  void selectCustomer() {
    filteredCustomer = Constants.customerList;
    Get.bottomSheet(
      GetBuilder<SaleInvoiceController>(
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
                    controller: searchController,
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
                              controller.selectCustomerFromList(index);
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

  void updateTotals() {
    double totalAmount = 0.0;
    double totalDiscount = 0.0;
    double totalCGST = 0.0;
    double totalSGST = 0.0;
    double totalIGST = 0.0;

    for (var item in itemList) {
      double itemTotal = item.qty! * item.price!.toDouble();
      totalAmount += itemTotal;
      totalDiscount += item.totalDiscount!.toDouble();
      totalCGST += item.cgstAmount!.toDouble();
      totalSGST += item.sgstAmount!.toDouble();
      totalIGST += item.igstAmount!.toDouble();
    }

    double gstTotal = totalCGST + totalSGST + totalIGST;
    double netTotalAmount = (totalAmount - totalDiscount) + gstTotal;

    total = totalAmount.toStringAsFixed(2);
    discountTotal = totalDiscount.toStringAsFixed(2);
    cGstTotal = totalCGST.toStringAsFixed(2);
    sGstTotal = totalSGST.toStringAsFixed(2);
    iGstTotal = totalIGST.toStringAsFixed(2);
    netTotal = netTotalAmount.toStringAsFixed(2);
    totalItem = itemList.length.toString();

    update();
  }

  void calculateGstAndDiscount() {
    double discountPercent =
        double.tryParse(itemDiscountPerController.text) ?? 0;
    double totalGstPercent =
        double.tryParse(addGstController.text.replaceAll("%", "")) ?? 0;
    double discountAmount = discountPercent /
        100 *
        (double.tryParse(itemPriceController.text) ?? 0);

    itemDiscountController.text = discountAmount.toStringAsFixed(3);
    itemTotalDiscountController.text =
        ((int.tryParse(itemQtyController.text) ?? 0) * discountAmount)
            .toStringAsFixed(3);

    itemNetPriceController.text =
        ((double.tryParse(itemPriceController.text) ?? 0) - discountAmount)
            .toString();

    double cgstPercent = totalGstPercent / 2;
    double cgstAmount =
        (double.tryParse(itemNetPriceController.text) ?? 0) * cgstPercent / 100;
    double sgstAmount =
        (double.tryParse(itemNetPriceController.text) ?? 0) * cgstPercent / 100;
    double igstAmount = (double.tryParse(itemNetPriceController.text) ?? 0) *
        totalGstPercent /
        100;

    itemCGstPerController.text = cgstPercent.toStringAsFixed(2);
    itemSGstPerController.text = cgstPercent.toStringAsFixed(2);
    itemIGstPerController.text = igstAmount.toStringAsFixed(2);

    itemCGstAmtController.text =
        ((int.tryParse(itemQtyController.text) ?? 0) * cgstAmount)
            .toStringAsFixed(2);

    itemSGstAmtController.text =
        ((int.tryParse(itemQtyController.text) ?? 0) * sgstAmount)
            .toStringAsFixed(2);

    itemIGstAmtController.text =
        ((int.tryParse(itemQtyController.text) ?? 0) * igstAmount)
            .toStringAsFixed(2);

    itemGrossAmountController.text =
        ((int.tryParse(itemQtyController.text) ?? 0) *
                (double.tryParse(itemPriceController.text) ?? 0))
            .toStringAsFixed(3);

    itemNetAmountController.text =
        (((double.tryParse(itemNetPriceController.text) ?? 0) *
                    (double.tryParse(itemQtyController.text) ?? 0)) +
                (double.tryParse(itemCGstAmtController.text) ?? 0) +
                (double.tryParse(itemSGstAmtController.text) ?? 0))
            .toStringAsFixed(2);

    itemTaxablePriceController.text =
        ((double.tryParse(itemGrossAmountController.text) ?? 0) -
                discountAmount)
            .toStringAsFixed(3);

    int index = itemList.indexWhere((item) => item.itemId == selectedItemId);
    if (index != -1) {
      itemList[index] = SaleDetails(
        itemId: selectedItemId,
        itemName: itemNameController.text,
        itemDescription: itemDesController.text,
        unit: itemUnitController.text,
        qty: double.tryParse(itemQtyController.text) ?? 0,
        price: double.tryParse(itemPriceController.text) ?? 0,
        discountPer: discountPercent,
        discount: discountAmount,
        totalDiscount: double.tryParse(itemTotalDiscountController.text) ?? 0,
        gstcodeId: 0,
        netPriceINCTax: double.tryParse(itemNetPriceController.text) ?? 0,
        cgstPer: cgstPercent,
        cgstAmount: cgstAmount * (double.tryParse(itemQtyController.text) ?? 0),
        sgstPer: cgstPercent,
        sgstAmount: sgstAmount * (double.tryParse(itemQtyController.text) ?? 0),
        igstPer: totalGstPercent,
        igstAmount: igstAmount * (double.tryParse(itemQtyController.text) ?? 0),
        taxableAmount: double.tryParse(itemTaxablePriceController.text) ?? 0,
        netAmount: double.tryParse(itemNetAmountController.text) ?? 0,
        grossAmount: double.tryParse(itemGrossAmountController.text) ?? 0,
      );
    }

    updateTotals();
    update();
  }

  bool isData = false;

  Future<void> salesInvoiceListApi() async {
    isData = false;
    String dataRaw = jsonEncode({
      "startDate":
          startDate.isNotEmpty ? startDate : DateTime.now().toIso8601String(),
      "endDate":
          endDate.isNotEmpty ? endDate : DateTime.now().toIso8601String(),
      "invoiceType":
          invoiceController.text.isNotEmpty ? invoiceController.text : "",
      "customerId": customerId
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.saleInvoiceList,
      context: Get.context!,
      rawData: dataRaw,
    );

    SalesInvoiceModel model = SalesInvoiceModel.fromJson(data);
    if (model.statusCode == 200) {
      isData = true;
      quotationList.clear();
      quotationList.addAll(model.data ?? []);
      update();
    }
  }

  void quotationDataApi(int id) async {
    final data = await GetAPIFunction().apiCall(
      apiName: "SaleInvoice/SaleInvoiceData/${id}",
      context: Get.context!,
    );

    SaleInvoiceModel model = SaleInvoiceModel.fromJson(data);
    if (model.statusCode == 200) {
      model.data!.forEach(
        (element) {
          addDateController.text = DateFormat("dd/MM/yyyy")
              .format(DateTime.parse(element.date ?? ""))
              .toString();
          addSerialController.text = element.serialNo.toString();
          addInvoiceTypeController.text = element.invoiceType ?? "";
          customerController.text = element.customerName ?? "";
          customerId = element.customerId ?? 0;
          addCustomerNumberController.text = element.contactNumber ?? "";
          addShippingAddressController.text = element.shippingAddress ?? "";
          addGSTinController.text = element.gstiNumber ?? "";
          addRemarkController.text = element.remarks ?? "";
          addGstTypeController.text = element.gstType ?? "";
          total = element.total.toString();
          discountTotal = element.discountTotal.toString();
          cGstTotal = element.cgstTotal.toString();
          sGstTotal = element.sgstTotal.toString();
          iGstTotal = element.igstTotal.toString();
          totalItem = (element.saleDetails!.length + 1).toString();
          netTotal = element.netTotal.toString();
          itemList = element.saleDetails ?? [];
        },
      );
      update();
    }
  }

  void nextSerialNoApi() async {
    final data = await GetAPIFunction().apiCall(
      apiName:
          "${Constants.salesNextSerialNo}/${addInvoiceTypeController.text}",
      context: Get.context!,
    );

    NextSerialNoModel model = NextSerialNoModel.fromJson(data);
    if (model.statusCode == 200) {
      addSerialController.text = model.data!.serialNumber.toString();
      update();
    }
  }

  Future<void> createQuotationApi() async {
    updateTotals();

    var dataRaw = json.encode({
      "date": DateTime.now().toIso8601String(),
      "taxMode": "GST",
      "invoiceType": addInvoiceTypeController.text,
      "serialNo": int.parse(addSerialController.text),
      "customerId": customerId,
      "customerName": customerController.text,
      "contactNumber": addCustomerNumberController.text,
      "shippingAddress": addShippingAddressController.text,
      "creditDays": int.parse(addCreditDaysController.text),
      "gstiNumber": addGSTinController.text,
      "salesPersonId": salesPersonId,
      "remarks": addRemarkController.text,
      "gstType": addGstTypeController.text,
      "total": double.parse(total),
      "discountTotal": double.parse(discountTotal),
      "cgstTotal": double.parse(cGstTotal),
      "sgstTotal": double.parse(sGstTotal),
      "igstTotal": double.parse(iGstTotal),
      "netTotal": double.parse(netTotal),
      "saleDetails": itemList
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.saveSaleInvoice,
      context: Get.context!,
      rawData: dataRaw,
    );

    SaveInvoiceModel model = SaveInvoiceModel.fromJson(data);
    if (model.statusCode == 200) {
      isAdd.value = false;

      quotationList.insert(
          0,
          SalesInvoiceData(
            billId: model.data!.quoteId ?? 0,
            invoiceSerialNo: addSerialController.text,
            date: DateTime.now().toIso8601String(),
            customerName: customerController.text,
            contactNumber: addCustomerNumberController.text,
            invoiceType: addInvoiceTypeController.text,
            netPayableAmount: double.parse(netTotal),
            allowEditEntry: true,
            allowDeleteEntry: true,
          ));

      update();
    }
  }

  Future<void> updateQuotationApi(int billId) async {
    updateTotals();

    var dataRaw = json.encode({
      "date": DateTime.now().toIso8601String(),
      "taxMode": "GST",
      "invoiceType": addInvoiceTypeController.text,
      "serialNo": int.parse(addSerialController.text),
      "customerId": int.parse(customerId.toString()),
      "customerName": customerController.text,
      "contactNumber": addCustomerNumberController.text,
      "shippingAddress": addShippingAddressController.text,
      "creditDays": int.parse(addCreditDaysController.text),
      "gstiNumber": addGSTinController.text,
      "remarks": addRemarkController.text,
      "gstType": addGstTypeController.text,
      "total": double.parse(total),
      "discountTotal": double.parse(discountTotal),
      "cgstTotal": double.parse(cGstTotal),
      "sgstTotal": double.parse(sGstTotal),
      "igstTotal": double.parse(iGstTotal),
      "netTotal": double.parse(netTotal),
      "saleDetails": itemList
    });

    final data = await APIFunction().apiCall(
      apiName:
          "https://fraxinuswebapis.azurewebsites.net/api/SaleInvoice/UpdateSaleInvoice/$billId",
      context: Get.context!,
      rawData: dataRaw,
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(data);

    if (model.statusCode == 200) {
      int index =
          quotationList.indexWhere((invoice) => invoice.billId == billId);

      if (index != -1) {
        quotationList[index] = SalesInvoiceData(
          billId: billId,
          invoiceSerialNo: addSerialController.text,
          date: DateTime.now().toIso8601String(),
          customerName: customerController.text,
          contactNumber: addCustomerNumberController.text,
          invoiceType: addInvoiceTypeController.text,
          netPayableAmount: double.parse(netTotal),
          allowEditEntry: true,
          allowDeleteEntry: true,
        );
      } else {
        quotationList.add(SalesInvoiceData(
          billId: billId,
          invoiceSerialNo: addSerialController.text,
          date: DateTime.now().toIso8601String(),
          customerName: customerController.text,
          contactNumber: addCustomerNumberController.text,
          invoiceType: addInvoiceTypeController.text,
          netPayableAmount: double.parse(netTotal),
          allowEditEntry: true,
          allowDeleteEntry: true,
        ));
      }
      update();
    }
  }

  Future<void> getSalesPersonListAPI() async {
    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getSalesPersonList,
      context: Get.context!,
    );

    SalesPersonModel model = SalesPersonModel.fromJson(data);
    if (model.statusCode == 200) {
      salesList = model.data ?? [];
      update();
    }
  }

  @override
  void onInit() {
    salesInvoiceListApi();
    getSalesPersonListAPI();
    startDateController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    endDateController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    super.onInit();
  }

  Future<void> deleteInvoiceApi(id) async {
    Loading.show();
    var headers = {
      'accept': '*/*',
      'Authorization':
          'Bearer ${GetStorageData.readString(GetStorageData.token)}'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://fraxinuswebapis.azurewebsites.net/api/SaleInvoice/DeleteSaleInvoice/$id',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(response.data);
    if (model.statusCode == 200) {
      await salesInvoiceListApi();
      Loading.dismiss();
    } else {
    }
  }

  Future<void> downloadPath() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
      }
    }
  }

  void quotationPDFApi(int id) async {
    final data = await GetAPIFunction().apiCall(
      apiName: "SaleInvoice/SaleInvoicePDFurl/${id}",
      context: Get.context!,
    );

    QuotationModel model = QuotationModel.fromJson(data);
    if (model.statusCode == 200) {
      Get.toNamed(Routes.PDF_VIEW, arguments: model.data!.downloadurl);
      update();
    }
  }

  Future<void> downloadFile(var filePath, var documentUrl) async {
    try {
      final filename = filePath;
      String dir = "/storage/emulated/0/Download";

      if (await File('$dir/$filename').exists()) {
        return;
      }

      String url = documentUrl;
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();

      if (response.statusCode == 200) {
        File file = File('$dir/$filename');
        var fileSink = file.openWrite();

        await for (var chunk in response) {
          fileSink.add(chunk);
        }

        await fileSink.close();
        Utils().showToast(
            message: "File downloaded successfully to ${file.path}",
            context: Get.context!);
      } else {
        Utils().showToast(
            message: "Failed to download file",
            context: Get.context!);
      }
    } catch (err) {
      Utils().showToast(
          message: "Failed to download file",
          context: Get.context!);
    }
  }
}
