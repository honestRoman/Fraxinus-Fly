import 'package:fraxinusfly/app/commons/all.dart';
import 'package:fraxinusfly/app/data/common_widget/common_button.dart';
import 'package:gap/gap.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../controllers/item_list_controller.dart';
import '../model/get_item_list_model.dart';

class ItemListView extends GetView<ItemListController> {
  const ItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemListController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.itemList,
          actions: [
            controller.itemId != 0 ||
                    controller.brandId != 0 ||
                    controller.categoryId != 0
                ? GestureDetector(
                    onTap: () {
                      controller.itemId = 0;
                      controller.itemNameController.clear();
                      controller.brandId = 0;
                      controller.brandController.clear();
                      controller.categoryId = 0;
                      controller.categoryController.clear();
                      controller.itemListApi();
                    },
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: FontSize.s14,
                        color: Colors.redAccent,
                        fontFamily: FontFamily.medium,
                      ),
                    ),
                  )
                : SizedBox(),
            Gap(20),
          ],
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            children: [
              CommonTextField(
                borderRadius: 12,
                controller: controller.itemNameController,
                title: AppString.itemList,
                isTitle: true,
                maxLength: 10,
                hintText: "Please Select...",
                showCursor: false,
                readOnly: true,
                onTap: () {
                  controller.selectItemName();
                },
                suffix: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )),
              ),
              Gap(10),
              CommonTextField(
                borderRadius: 12,
                controller: controller.brandController,
                title: AppString.brand,
                isTitle: true,
                maxLength: 10,
                hintText: "Please Select...",
                showCursor: false,
                readOnly: true,
                onTap: () {
                  controller.selectBrand();
                },
                suffix: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )),
              ),
              Gap(10),
              CommonTextField(
                borderRadius: 12,
                controller: controller.categoryController,
                title: AppString.category,
                isTitle: true,
                maxLength: 10,
                hintText: "Please Select...",
                showCursor: false,
                readOnly: true,
                onTap: () {
                  controller.selectCategory();
                },
                suffix: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )),
              ),
              if (controller.itemList.isNotEmpty) Gap(20),
              if (controller.itemList.isNotEmpty)
                CommonButton(
                  btnName: AppString.downloadPdf,
                  onTap: () {
                    controller.genaratePDFApi();
                  },
                ),
              Gap(20),
              tableView(),
            ],
          ),
        );
      },
    );
  }

  Widget tableView() {
    return GetBuilder<ItemListController>(
      builder: (controller) {
        return ListView.builder(
          key: Key('builder ${controller.selected.toString()}'),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.itemList.length,
          itemBuilder: (context, index) {
            ItemListData model = controller.itemList[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    dense: true,
                    key: Key(index.toString()),
                    initiallyExpanded: index == controller.selected,
                    onExpansionChanged: (value) {
                      if (value) {
                        Duration(seconds: 20000);
                        controller.selected = index;
                      } else
                        controller.selected = -1;
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.itemName ?? "",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.s18,
                            fontFamily: FontFamily.medium,
                          ),
                        ),
                        Text(
                          model.finalCost.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.s16,
                            fontFamily: FontFamily.medium,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Table(
                        border: TableBorder.all(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12))),
                        children: [
                          TableRow(
                            children: [
                              commonTableText(title: "Item Name"),
                              commonTableText(
                                  title: model.itemName, isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Item Code"),
                              commonTableText(
                                  title: model.itemCode, isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Unit Code"),
                              commonTableText(
                                  title: model.unitCode, isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Basic price"),
                              commonTableText(
                                  title: model.finalCost.toString(),
                                  isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Purchase Price"),
                              commonTableText(
                                  title: model.purchasePrice.toString(),
                                  isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Purchase Vat AMT"),
                              commonTableText(
                                  title: model.purchaseVATamt.toString(),
                                  isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Discount"),
                              commonTableText(
                                  title: model.discount.toString(),
                                  isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Item Value"),
                              commonTableText(
                                  title: model.price.toString(), isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Stock Qty."),
                              commonTableText(
                                  title: model.stockQty.toString(),
                                  isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Brand name"),
                              commonTableText(
                                  title: model.brandName, isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Category"),
                              commonTableText(title: model.name, isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "SubCatgeory Name"),
                              commonTableText(
                                  title: model.subCategory, isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Barcode No."),
                              commonTableText(
                                  title: model.defaultBarcodeNo, isEnd: true),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
