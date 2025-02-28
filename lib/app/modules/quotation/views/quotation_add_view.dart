import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:fraxinusfly/app/commons/all.dart';
import 'package:fraxinusfly/app/commons/get_storage_data.dart';
import 'package:fraxinusfly/app/data/common_widget/common_button.dart';
import 'package:fraxinusfly/app/modules/bottom_bar/model/get_item_list.dart';
import 'package:fraxinusfly/app/modules/quotation/controllers/quotation_controller.dart';
import 'package:fraxinusfly/app/modules/quotation/model/quotation_model.dart';
import 'package:gap/gap.dart';

import '../../../data/common_widget/common_textfeild.dart';
import '../../item_list/controllers/item_list_controller.dart';

class QuotationAddView extends GetView<QuotationController> {
  const QuotationAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuotationController>(
      builder: (controller) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            CommonTextField(
              borderRadius: 12,
              controller: controller.addDateController,
              title: AppString.date,
              isTitle: true,
              maxLength: 10,
              inputFormatters: [
                DateInputFormatter(),
              ],
              suffix: GestureDetector(
                onTap: () {
                  controller.selectDate(context, "add");
                },
                child: Icon(Icons.calendar_month),
              ),
            ),
            Gap(12),
            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    borderRadius: 12,
                    controller: TextEditingController(text: "GST"),
                    title: AppString.textMode,
                    isTitle: true,
                    readOnly: true,
                    showCursor: false,
                  ),
                ),
                Gap(15),
                Expanded(
                  child: CommonTextField(
                    borderRadius: 12,
                    controller: controller.addSerialController,
                    title: AppString.invoiceSerialNo,
                    isTitle: true,
                    readOnly: true,
                    showCursor: false,
                  ),
                ),
              ],
            ),
            Gap(12),
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
                    color:
                        controller.isOpen.value ? Colors.blue : Colors.black38),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Theme(
                data: ThemeData(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.zero,
                  dense: true,
                  key: Key(controller.key.toString()),
                  onExpansionChanged: (value) {
                    controller.isOpen.value = value;
                    controller.update();
                  },
                  title: Text(
                    controller.addInvoiceTypeController.text,
                  ),
                  children: List.generate(
                    controller.invoiceList.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          controller.addInvoiceTypeController.text =
                              controller.invoiceList[index];
                          controller.nextSerialNoApi();
                          controller.collapse();
                          controller.isOpen.value = false;
                          controller.update();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            controller.invoiceList[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.customerController,
              title: AppString.customerName,
              isTitle: true,
              maxLength: 10,
              hintText: "Please Select...",
              showCursor: false,
              readOnly: true,
              onTap: () {
                controller.selectCustomer();
              },
              suffix: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  )),
            ),
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addCustomerNumberController,
              title: AppString.contactNumber,
              isTitle: true,
              maxLength: 12,
              textInputType: TextInputType.number,
            ),
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addShippingAddressController,
              title: AppString.shippingAddress,
              isTitle: true,
              maxLine: 2,
              textInputType: TextInputType.number,
            ),
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addCreditDaysController,
              title: AppString.CreditType,
              isTitle: true,
              textInputType: TextInputType.number,
            ),
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addGSTinController,
              title: AppString.gstIn,
              isTitle: true,
              textInputType: TextInputType.number,
            ),
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addRemarkController,
              title: AppString.remark,
              isTitle: true,
            ),
            Gap(12),
            if (controller.addInvoiceTypeController.text == controller.invoiceList[1])
              Text(
                AppString.gstType,
                style: TextStyle(
                  fontFamily: FontFamily.medium,
                  fontSize: FontSize.s16,
                  color: Colors.black38,
                ),
              ),
            if (controller.addInvoiceTypeController.text == controller.invoiceList[1])
              Gap(8),
            if (controller.addInvoiceTypeController.text == controller.invoiceList[1])
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.isOpen.value ? Colors.blue : Colors.black38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    dense: true,
                    key: Key(controller.key.toString()),
                    onExpansionChanged: (value) {
                      controller.isOpen.value = value;
                      controller.update();
                    },
                    title: Text(
                      controller.addGstTypeController.text,
                    ),
                    children: List.generate(
                      controller.gstTYpe.length,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.addGstTypeController.text =
                            controller.gstTYpe[index];
                            controller.collapse();
                            controller.isOpen.value = false;
                            controller.update();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              controller.gstTYpe[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            if (controller.invoiceController.text == controller.invoiceList[1])
              Gap(12),
            if (controller.itemList.isNotEmpty) Gap(20),
            if (controller.itemList.isNotEmpty) itemData(controller),
            Gap(21),
            CommonButton(
              btnName: AppString.addItem,
              onTap: () {
                selectItemSheet();
              },
            ),
            Gap(30),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    commonTableText(title: "Total"),
                    commonTableText(title: controller.total, isEnd: true),
                  ],
                ),
                TableRow(
                  children: [
                    commonTableText(title: "(-)DiscountTotal"),
                    commonTableText(
                        title: controller.discountTotal,
                        isLight: true,
                        isEnd: true),
                  ],
                ),
                if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")...[
                  TableRow(
                    children: [
                      commonTableText(title: "(+)CGSTTotal"),
                      commonTableText(
                          title: controller.cGstTotal,
                          isLight: true,
                          isEnd: true),
                    ],
                  ),
                ],
                if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")...[
                  TableRow(
                    children: [
                      commonTableText(title: "(+)SGSTTotal"),
                      commonTableText(
                          title: controller.sGstTotal,
                          isLight: true,
                          isEnd: true),
                    ],
                  ),
                ],
                if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text != "CGST_SGST")...[
                  TableRow(
                    children: [
                      commonTableText(title: "(+)IGSTTotal"),
                      commonTableText(
                          title: controller.iGstTotal,
                          isLight: true,
                          isEnd: true),
                    ],
                  ),
                ],
                TableRow(
                  children: [
                    commonTableText(title: "TotalItem"),
                    commonTableText(
                        title: controller.totalItem,
                        isLight: true,
                        isEnd: true),
                  ],
                ),
                TableRow(
                  children: [
                    commonTableText(title: "NetTotal"),
                    commonTableText(
                        title: controller.netTotal, isLight: true, isEnd: true),
                  ],
                ),
              ],
            ),
            Gap(10),
            CommonButton(
              btnName: AppString.save,
              onTap: () {
                controller.isAdd.value = false;
                if (controller.isUpdate) {
                  controller.updateQuotationApi(controller.QuoteId);
                }
                else
                  {
                controller.createQuotationApi();
                  }
                controller.isUpdate = false;
                controller.update();
              },
            ),
            Gap(Platform.isIOS ? 25 : 20),
          ],
        );
      },
    );
  }

  // Widget itemData(QuotationController controller) {
  //   return SingleChildScrollView(
  //     padding: EdgeInsets.zero,
  //     scrollDirection: Axis.horizontal,
  //     dragStartBehavior: DragStartBehavior.start,
  //     child: DataTable(
  //       border: TableBorder.all(),
  //       columns: <DataColumn>[
  //         DataColumn(label: Text('ACTION')),
  //         DataColumn(label: Text('Name')),
  //         DataColumn(label: Text('UNIT')),
  //         DataColumn(label: Text('QTY')),
  //         DataColumn(label: Text('PRICE')),
  //         DataColumn(label: Text('DISCOUNT(%)')),
  //         DataColumn(label: Text('DISCOUNT')),
  //         DataColumn(label: Text('TOTAL DISCOUNT')),
  //         if(controller.addInvoiceTypeController.text != "Bill of Supply")...[DataColumn(label: Text('GST TEX')),],
  //
  //         DataColumn(label: Text('NETPRICE\n(INC. TEX)')),
  //         if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")...[DataColumn(label: Text('CGSTPER')),],
  //         if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")...[DataColumn(label: Text('CGSTAMT')),],
  //         if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")...[DataColumn(label: Text('SGSTPER')),],
  //         if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")...[DataColumn(label: Text('SGSTAMT')),],
  //         if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text != "CGST_SGST")...[DataColumn(label: Text('IGSTPER')),],
  //         if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text != "CGST_SGST")...[DataColumn(label: Text('IGSTAMT')),],
  //
  //         DataColumn(label: Text('TEXABLE\nAMOUNT')),
  //       ],
  //       rows: List.generate(
  //         controller.itemList.length,
  //         (index) {
  //           QuotationDetails data = controller.itemList[index];
  //           return DataRow(
  //             cells: <DataCell>[
  //               DataCell(Icon(Icons.delete)),
  //               DataCell(Text(
  //                 data.itemName ?? "",
  //                 maxLines: 2,
  //               )),
  //               DataCell(Text(data.unit ?? "")),
  //               DataCell(Text(data.qty.toString())),
  //               DataCell(Text(data.price.toString())),
  //               DataCell(Text(data.discountPer.toString())),
  //               DataCell(Text(data.discount.toString())),
  //               DataCell(Text(data.totalDiscount.toString())),
  //               DataCell(Text(data.gstcodeId.toString())),
  //               DataCell(Text(data.netPriceINCTax.toString())),
  //               if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")...[DataCell(Text(data.cgstPer.toString())),],
  //               if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")...[DataCell(Text(data.cgstAmount.toString())),],
  //               if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")...[DataCell(Text(data.sgstPer.toString())),],
  //               if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")...[DataCell(Text(data.sgstAmount.toString())),],
  //               if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text != "CGST_SGST")...[DataCell(Text(data.igstPer.toString())),],
  //               if(controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text != "CGST_SGST")...[DataCell(Text(data.igstAmount.toString())),],
  //               DataCell(Text(data.taxableAmount.toString())),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget itemData(QuotationController controller) {
    // Define column list
    List<DataColumn> columns = [
      DataColumn(label: Text('ACTION')),
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('UNIT')),
      DataColumn(label: Text('QTY')),
      DataColumn(label: Text('PRICE')),
      DataColumn(label: Text('DISCOUNT(%)')),
      DataColumn(label: Text('DISCOUNT')),
      DataColumn(label: Text('TOTAL DISCOUNT')),
      if (controller.addInvoiceTypeController.text != "Bill of Supply")
        DataColumn(label: Text('GST TEX')),
      DataColumn(label: Text('NETPRICE\n(INC. TEX)')),
      if (controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")
        ...[
          DataColumn(label: Text('CGSTPER')),
          DataColumn(label: Text('CGSTAMT')),
          DataColumn(label: Text('SGSTPER')),
          DataColumn(label: Text('SGSTAMT')),
        ],
      if (controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text != "CGST_SGST")
        ...[
          DataColumn(label: Text('IGSTPER')),
          DataColumn(label: Text('IGSTAMT')),
        ],
      DataColumn(label: Text('TAXABLE AMOUNT')),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      child: DataTable(
        border: TableBorder.all(),
        columns: columns,
        rows: controller.itemList.map((data) {
          List<DataCell> cells = [
            DataCell(Icon(Icons.delete)),
            DataCell(Text(data.itemName ?? "", maxLines: 2)),
            DataCell(Text(data.unit ?? "")),
            DataCell(Text(data.qty.toString())),
            DataCell(Text(data.price.toString())),
            DataCell(Text(data.discountPer.toString())),
            DataCell(Text(data.discount.toString())),
            DataCell(Text(data.totalDiscount.toString())),
            if (controller.addInvoiceTypeController.text != "Bill of Supply")
              DataCell(Text(data.gstcodeId.toString())),
            DataCell(Text(data.netPriceINCTax.toString())),
            if (controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text == "CGST_SGST")
              ...[
                DataCell(Text(data.cgstPer.toString())),
                DataCell(Text(data.cgstAmount.toString())),
                DataCell(Text(data.sgstPer.toString())),
                DataCell(Text(data.sgstAmount.toString())),
              ],
            if (controller.addInvoiceTypeController.text != "Bill of Supply" && controller.addGstTypeController.text != "CGST_SGST")
              ...[
                DataCell(Text(data.igstPer.toString())),
                DataCell(Text(data.igstAmount.toString())),
              ],
            DataCell(Text(data.taxableAmount.toString())),
          ];

          return DataRow(cells: cells);
        }).toList(),
      ),
    );
  }


  selectItemSheet() {
    filteredItems = Constants.itemList;
    Get.bottomSheet(
      isScrollControlled: true,
      GetBuilder<QuotationController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.only(top: AppBar().preferredSize.height),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(10),
                  Text(
                    "Select Item",
                    style: TextStyle(
                      fontSize: FontSize.s22,
                      color: Colors.black,
                      fontFamily: FontFamily.semiBold,
                    ),
                  ),
                  Gap(10),
                  Divider(
                    color: Colors.black,
                  ),
                  Gap(10),
                  CommonTextField(
                    controller: controller.searchFieldController,
                    borderRadius: 12,
                    prefix: Icon(Icons.search),
                    onChanged: (p0) {
                      filterItems(p0);
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              controller.itemNetPriceController.text = filteredItems[index].price.toString();
                              addItemSheet(filteredItems[index]);
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12)),
                              child: commonTableText(
                                  title: filteredItems[index].itemName ?? ""),
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

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredItems = Constants.itemList;
    } else {
      filteredItems = Constants.itemList
          .where((item) =>
          item.itemName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    controller.update();
  }


  addItemSheet(ItemData filteredItem) {
    controller.itemUnitController.text = filteredItem.unitCode ?? "";
    controller.itemQtyController.text = "1";
    controller.itemDiscountPerController.text = "0";
    controller.itemDiscountController.text = "0";
    controller.itemTotalDiscountController.text = "0";
    controller.itemPriceController.text = filteredItem.price.toString();
    controller.itemGrossAmountController.text = filteredItem.price.toString();
    for(int i = 0;i< Constants.gstList.length; i++) {
      if (Constants.gstList[i].gstCodeId == filteredItem.gstCodeId)
      {
        controller.addGstController.text = Constants.gstList[i].gstTaxName ?? "";
        controller.gstId = Constants.gstList[i].gstCodeId ?? 0;
      }
    }
    Get.bottomSheet(
      GetBuilder<QuotationController>(
        builder: (controller) {
          return DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(12),
                Text(
                  filteredItem.itemName ?? "",
                  style: TextStyle(
                    fontSize: FontSize.s20,
                    color: Colors.black,
                    fontFamily: FontFamily.medium,
                  ),
                ),
                Gap(10),
                Divider(
                  color: Colors.black,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemDesController,
                        title: AppString.itemDec,
                        isTitle: true,
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemUnitController,
                        title: AppString.unit,
                        isTitle: true,
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemQtyController,
                        title: AppString.qty,
                        isTitle: true,
                        onChanged: (p0) {
                          controller.calculateGstAndDiscount();
                        },
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemPriceController,
                        title: AppString.price,
                        isTitle: true,
                        onChanged: (p0) {
                          controller.calculateGstAndDiscount();
                        },
                      ),
                      if(controller.addGstTypeController.text.isNotEmpty)
                      Gap(10),
                      if(controller.addGstTypeController.text.isNotEmpty)
                      Text(
                        AppString.gstTax,
                        style: TextStyle(
                          fontFamily: FontFamily.medium,
                          fontSize: FontSize.s16,
                          color: Colors.black38,
                        ),
                      ),
                      if(controller.addGstTypeController.text.isNotEmpty)
                      Gap(8),
                      if(controller.addGstTypeController.text.isNotEmpty)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: controller.isOpen.value
                                  ? Colors.blue
                                  : Colors.black38),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Theme(
                          data: ThemeData(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.zero,
                            dense: true,
                            key: Key(controller.key.toString()),
                            onExpansionChanged: (value) {
                              controller.isOpen.value = value;
                              controller.update();
                            },
                            title: Text(
                              controller.addGstController.text,
                            ),
                            children: List.generate(
                              Constants.gstList.length,
                                  (index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.addGstController.text =
                                        Constants.gstList[index].gstTaxName ?? "";
                                    controller.gstId = Constants.gstList[index].gstCodeId ?? 0;
                                    controller.calculateGstAndDiscount();
                                    // controller.calculateDiscount();
                                    controller.collapse();
                                    controller.isOpen.value = false;
                                    controller.update();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      Constants.gstList[index].gstTaxName ?? "",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemDiscountPerController,
                              title: AppString.discountPer,
                              isTitle: true,
                              onChanged: (p0) {
                                controller.calculateGstAndDiscount();
                              },
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemDiscountController,
                              title: AppString.discount,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller:
                                  controller.itemTotalDiscountController,
                              title: AppString.totalDiscount,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemNetPriceController,
                              title: AppString.netPrice,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      if(controller.addGstTypeController.text.isNotEmpty)
                        if(controller.addGstTypeController.text != 'IGST')
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemCGstPerController,
                              title: AppString.CGSTPer,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemCGstAmtController,
                              title: AppString.CGSTAmt,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                        ],
                      ),
                      if(controller.addGstTypeController.text.isNotEmpty)
                        if(controller.addGstTypeController.text != 'IGST')
                      Gap(10),
                      if(controller.addGstTypeController.text.isNotEmpty)
                        if(controller.addGstTypeController.text != 'IGST')
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemSGstPerController,
                              title: AppString.SGSTPer,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemSGstAmtController,
                              title: AppString.SGSTAmt,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                        ],
                      ),
                      if(controller.addGstTypeController.text.isNotEmpty)
                      if(controller.addGstTypeController.text == 'IGST')
                      Gap(10),
                      if(controller.addGstTypeController.text.isNotEmpty)
                      if(controller.addGstTypeController.text == 'IGST')
                      if(controller.addGstTypeController.text == 'IGST')
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemIGstPerController,
                              title: AppString.IGSTPer,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemIGstAmtController,
                              title: AppString.IGSTAmt,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemTaxablePriceController,
                        title: AppString.taxableAmount,
                        isTitle: true,
                        readOnly: true,
                        showCursor: false,
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemNetAmountController,
                              title: AppString.netAmount,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemGrossAmountController,
                              title: AppString.grossAmount,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                        ],
                      ),
                      Gap(25),
                      CommonButton(
                        btnName: AppString.save,
                        onTap: () {
                          controller.itemList.add(QuotationDetails(
                            itemId: filteredItem.itemid,
                            itemName: filteredItem.itemName,
                            itemDescription: controller.itemDesController.text,
                            unit: controller.itemUnitController.text,
                            qty: double.parse(controller.itemQtyController.text),
                            price: double.parse(controller.itemPriceController.text),
                            discountPer: double.parse(controller.itemDiscountPerController.text),
                            discount: double.parse(controller.itemDiscountController.text),
                            totalDiscount: double.parse(controller.itemTotalDiscountController.text),
                            gstcodeId: 0,
                            netPriceINCTax: controller.addInvoiceTypeController.text == "Bill of Supply" ? 0.0 : double.parse(controller.itemNetPriceController.text),
                            cgstPer: controller.addInvoiceTypeController.text != "Bill of Supply" ? controller.addGstTypeController.text == "CGST_SGST" ? double.parse(controller.itemCGstPerController.text) : 0.0 : 0.0,
                            cgstAmount: controller.addInvoiceTypeController.text != "Bill of Supply" ? controller.addGstTypeController.text == "CGST_SGST" ? double.parse(controller.itemCGstAmtController.text) : 0.0 : 0.0,
                            sgstPer: controller.addInvoiceTypeController.text != "Bill of Supply" ? controller.addGstTypeController.text == "CGST_SGST" ? double.parse(controller.itemSGstPerController.text) : 0.0 : 0.0,
                            sgstAmount: controller.addInvoiceTypeController.text != "Bill of Supply" ? controller.addGstTypeController.text == "CGST_SGST" ? double.parse(controller.itemSGstAmtController.text) : 0.0 : 0.0,
                            igstPer: controller.addInvoiceTypeController.text != "Bill of Supply" ? controller.addGstTypeController.text == "IGST" ? double.parse(controller.itemIGstPerController.text) : 0.0 : 0.0,
                            igstAmount: controller.addInvoiceTypeController.text != "Bill of Supply" ? controller.addGstTypeController.text == "IGST" ? double.parse(controller.itemIGstAmtController.text) : 0.0 : 0.0,
                            taxableAmount: controller.addInvoiceTypeController.text == "Bill of Supply" ? 0.0 : double.parse(controller.itemTaxablePriceController.text),
                            netAmount: controller.isUpdate == true
                                ? ((double.tryParse(controller.itemNetAmountController.text) ?? 0) +
                                (double.tryParse(controller.netTotal) ?? 0))
                                : (double.tryParse(controller.itemNetAmountController.text) ?? 0),
                            grossAmount: double.parse(controller.itemGrossAmountController.text),
                          ));


                          controller.calculateGstAndDiscount();
                          // controller.calculateTotals();

                          Get.back();

                          // controller.total =
                          //     (int.parse(controller.itemQtyController.text) *
                          //             double.parse(
                          //                 controller.itemPriceController.text))
                          //         .toStringAsFixed(2)
                          //         .toString();
                          // controller.discountTotal =
                          //     controller.itemTotalDiscountController.text;
                          // controller.sGstTotal =
                          //     controller.itemSGstAmtController.text;
                          // controller.cGstTotal =
                          //     controller.itemCGstAmtController.text;
                          // controller.iGstTotal =
                          //     controller.itemIGstAmtController.text;
                          // controller.iGstTotal =
                          //     controller.itemIGstAmtController.text;
                          // controller.totalItem = (controller.itemList.length + 1).toString();
                          // controller.netTotal =
                          //     controller.itemNetAmountController.text;
                          // controller.itemList.add(QuotationDetails(
                          //   itemId: filteredItem.itemid,
                          //   itemName: filteredItem.itemName,
                          //   itemDescription: controller.itemDesController.text,
                          //   unit: controller.itemUnitController.text,
                          //   qty: double.parse(controller.itemQtyController.text),
                          //   price: double.parse(
                          //       controller.itemPriceController.text),
                          //   discountPer: double.parse(
                          //       controller.itemDiscountPerController.text),
                          //   discount: double.parse(
                          //       controller.itemDiscountController.text),
                          //   totalDiscount: double.parse(
                          //       controller.itemTotalDiscountController.text),
                          //   gstcodeId: 0,
                          //   netPriceINCTax: double.parse(
                          //       controller.itemNetPriceController.text),
                          //   cgstPer: double.parse(
                          //       controller.itemCGstPerController.text),
                          //   cgstAmount: double.parse(
                          //       controller.itemCGstAmtController.text),
                          //   sgstPer: double.parse(
                          //       controller.itemSGstPerController.text),
                          //   sgstAmount: double.parse(
                          //       controller.itemSGstAmtController.text),
                          //   igstPer: double.parse(
                          //       controller.itemIGstPerController.text),
                          //   igstAmount: double.parse(
                          //       controller.itemIGstAmtController.text),
                          //   taxableAmount: double.parse(
                          //       controller.itemTaxablePriceController.text),
                          //   netAmount: double.parse(
                          //       controller.itemNetAmountController.text),
                          //   grossAmount: double.parse(
                          //       controller.itemGrossAmountController.text),
                          // ));
                          // controller.update();
                          // Get.back();
                        },
                      ),
                    ],
                  ),
                ),
                Gap(30),
              ],
            ),
          );
        },
      ),
    );
  }
}
