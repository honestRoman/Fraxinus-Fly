import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:fraxinusfly/app/api_common/api_function.dart';
import 'package:fraxinusfly/app/api_common/loading.dart';
import 'package:fraxinusfly/app/data/common_widget/common_button.dart';
import 'package:fraxinusfly/app/modules/quotation/model/new_serial_model.dart';
import 'package:fraxinusfly/app/routes/app_pages.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../commons/all.dart';
import '../../../commons/get_storage_data.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../item_list/controllers/item_list_controller.dart';
import '../model/quoation_list_model.dart';
import '../model/quotation_model.dart';
import '../model/quotation_pdf_model.dart';
import '../model/save_quotation_model.dart';

class QuotationController extends GetxController {
  RxBool isAdd = false.obs;
  int? selectedItemId;

  TextEditingController itemNameController = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();
  TextEditingController addDateController = TextEditingController();
  TextEditingController addSerialController = TextEditingController();
  TextEditingController addInvoiceTypeController =
      TextEditingController(text: "Bill of Supply");
  TextEditingController addGstController = TextEditingController();
  TextEditingController addCustomerNumberController = TextEditingController();
  TextEditingController addShippingAddressController = TextEditingController();
  TextEditingController addGstTypeController = TextEditingController();
  TextEditingController addCreditDaysController =
      TextEditingController(text: "0");
  TextEditingController addGSTinController = TextEditingController();
  TextEditingController addRemarkController = TextEditingController();
  TextEditingController itemDesController = TextEditingController();
  TextEditingController itemUnitController = TextEditingController();
  TextEditingController itemQtyController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemDiscountPerController = TextEditingController();
  TextEditingController itemDiscountController = TextEditingController();
  TextEditingController itemTotalDiscountController = TextEditingController();
  TextEditingController itemNetPriceController = TextEditingController();
  TextEditingController itemCGstPerController = TextEditingController();
  TextEditingController itemCGstAmtController = TextEditingController();
  TextEditingController itemSGstPerController = TextEditingController();
  TextEditingController itemSGstAmtController = TextEditingController();
  TextEditingController itemIGstPerController = TextEditingController();
  TextEditingController itemIGstAmtController = TextEditingController();
  TextEditingController itemTaxablePriceController = TextEditingController();
  TextEditingController itemNetAmountController = TextEditingController();
  TextEditingController itemGrossAmountController = TextEditingController();

  //👆Add Screen
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxBool isOpen = false.obs;
  int key = 0;
  bool isUpdate = true;
  String quId = "";
  int QuoteId = 0;
  int gstId = 0;
  String startDate = "";
  String endDate = "";
  int customerId = 0;
  String total = "";
  String discountTotal = "";
  String cGstTotal = "";
  String sGstTotal = "";
  String iGstTotal = "";
  String totalItem = "";
  String netTotal = "";

  List<QuotationDetails> itemList = [];

  int? expandedIndex;

  List invoiceList = [
    'Bill of Supply',
    'Tax',
  ];

  List gstTYpe = [
    'CGST_SGST',
    'IGST',
  ];

  List gstList = [
    '1%',
    '5%',
    '12%',
    '18%',
    '28%',
    'Exempted',
    '3%',
  ];

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredCustomer = Constants.customerList;
    } else {
      filteredCustomer = Constants.customerList
          .where((customer) => customer.customerName!.toLowerCase()
          .contains(query.toLowerCase()))
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


  List<QuotationData> quotationList = [];

  void filterSheet(BuildContext context) {
    Get.bottomSheet(isScrollControlled: true, GetBuilder<QuotationController>(
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
                    AppString.invoiceType,
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
                    title: AppString.customer,
                    isTitle: true,
                    maxLength: 10,
                    hintText: "Please Select...",
                    showCursor: false,
                    readOnly: true,
                    onTap: () {
                      selectCustomer();
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
                            quotationListApi();
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
        endDateController.text = date;
        endDate = picked.toIso8601String();
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

  void selectCustomer() {
    filteredCustomer = Constants.customerList;
    Get.bottomSheet(
      GetBuilder<QuotationController>(
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
                      filterCustomer(p0);
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

  Future<void> quotationListApi() async {
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
      apiName: Constants.quotationList,
      context: Get.context!,
      rawData: dataRaw,
    );

    QuotationListModel model = QuotationListModel.fromJson(data);
    if (model.statusCode == 200) {
      quotationList.clear();
      quotationList = model.data ?? [];
      update();
    }
  }

  void nextSerialNoApi() async {
    final data = await GetAPIFunction().apiCall(
      apiName: "${Constants.nextSerialNo}/${addInvoiceTypeController.text}",
      context: Get.context!,
    );

    NextSerialNoModel model = NextSerialNoModel.fromJson(data);
    if (model.statusCode == 200) {
      addSerialController.text = model.data!.serialNumber.toString();
      update();
    }
  }

  void quotationDataApi(int id) async {
    final data = await GetAPIFunction().apiCall(
      apiName: "${Constants.quotationData}/${id}",
      context: Get.context!,
    );

    QuotationDataModel model = QuotationDataModel.fromJson(data);
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
          addCreditDaysController.text = element.creditDays.toString();
          addGSTinController.text = element.gstiNumber ?? "";
          addRemarkController.text = element.remarks ?? "";
          addGstTypeController.text = element.gstType ?? "";
          total = element.total.toString();
          discountTotal = element.discountTotal.toString();
          cGstTotal = element.cgstTotal.toString();
          sGstTotal = element.sgstTotal.toString();
          iGstTotal = element.igstTotal.toString();
          totalItem = (element.quotationDetails!.length).toString();
          netTotal = element.netTotal.toString();
          itemList = element.quotationDetails ?? [];
        },
      );
      update();
    }
  }

  void quotationPDFApi(int id) async {
    final data = await GetAPIFunction().apiCall(
      apiName: "${Constants.quotationPDFurl}/${id}",
      context: Get.context!,
    );

    QuotationModel model = QuotationModel.fromJson(data);
    if (model.statusCode == 200) {
      Get.toNamed(Routes.PDF_VIEW, arguments: model.data!.downloadurl);
      update();
    }
  }

  @override
  void onInit() {
    quotationListApi();
    startDateController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    endDateController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    super.onInit();
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
      itemList[index] = QuotationDetails(
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
      "remarks": addRemarkController.text,
      "gstType": addGstTypeController.text,
      "total": double.parse(total),
      "discountTotal": double.parse(discountTotal),
      "cgstTotal": double.parse(cGstTotal),
      "sgstTotal": double.parse(sGstTotal),
      "igstTotal": double.parse(iGstTotal),
      "netTotal": double.parse(netTotal),
      "quotationDetails": itemList
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.saveQuotation,
      context: Get.context!,
      rawData: dataRaw,
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(data);
    if (model.statusCode == 200) {
      quotationList.add(
        QuotationData(
          quoteId: model.data!.quoteId ?? 0,
          serialNo: addSerialController.text,
          date: DateTime.now().toIso8601String(),
          customerName: customerController.text,
          contactNumber: addCustomerNumberController.text,
          invoiceType: addInvoiceTypeController.text,
          netPayableAmount: double.parse(netTotal),
          allowEditEntry: true,
          allowDeleteEntry: true,
        ),
      );
      update();
    }
  }

  Future<void> updateQuotationApi(int quoteId) async {
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
      "quotationDetails": itemList
    });

    final data = await APIFunction().apiCall(
      apiName: "https://fraxinuswebapis.azurewebsites.net/api/Quotation/UpdateQuotation/$quoteId",
      context: Get.context!,
      rawData: dataRaw,
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(data);

    if (model.statusCode == 200) {
      int index = quotationList.indexWhere((quote) => quote.quoteId == quoteId);

      if (index != -1) {
        quotationList[index] = QuotationData(
          quoteId: quoteId,
          serialNo: addSerialController.text,
          date: DateTime.now().toIso8601String(),
          customerName: customerController.text,
          contactNumber: addCustomerNumberController.text,
          invoiceType: addInvoiceTypeController.text,
          netPayableAmount: double.parse(netTotal),
          allowEditEntry: true,
          allowDeleteEntry: true,
        );
      } else {
        quotationList.add(QuotationData(
          quoteId: quoteId,
          serialNo: addSerialController.text,
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

  Future<void> deleteQuotationApi(id) async {
    Loading.show();
    String token = "";
    if (GetStorageData.containKey(GetStorageData.token)) {
      token = GetStorageData.readString(GetStorageData.token);
    }
    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Cookie':
          'ARRAffinity=3adacca6c2f81875efead5591d2a8d02faa6e8843c1dd1a10e8da178ce234c0c; ARRAffinitySameSite=3adacca6c2f81875efead5591d2a8d02faa6e8843c1dd1a10e8da178ce234c0c'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://fraxinuswebapis.azurewebsites.net/api/Quotation/DeleteQuotation/$id',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(response.data);
    if (model.statusCode == 200) {
      await quotationListApi();
      Loading.dismiss();
    } else {
    }
  }
}

class commonModel {
  final String? itemName;
  final String? itemCode;
  final String? unitCode;
  final String? basicPrice;
  final String? subBrand;
  final String? purchasePrice;
  final String? purchaseVatAmt;
  final String? stockQty;
  final String? category;
  final String? discount;
  final String? branchName;
  final String? subcategory;
  final String? barCodeNo;
  final String? itemValue;
  final String? action;
  final String? invoiceSerial;
  final String? date;
  final String? customerName;
  final String? contactNumber;
  final String? invoiceType;
  final String? netAmount;
  final String? gstIn;

  commonModel({
    this.itemName,
    this.itemCode,
    this.barCodeNo,
    this.unitCode,
    this.purchasePrice,
    this.subcategory,
    this.category,
    this.subBrand,
    this.discount,
    this.itemValue,
    this.basicPrice,
    this.branchName,
    this.stockQty,
    this.purchaseVatAmt,
    this.action,
    this.invoiceSerial,
    this.date,
    this.customerName,
    this.contactNumber,
    this.invoiceType,
    this.netAmount,
    this.gstIn,
  });
}
