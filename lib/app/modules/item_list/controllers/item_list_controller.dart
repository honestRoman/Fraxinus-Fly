import 'package:fraxinusfly/app/api_common/api_function.dart';
import 'package:fraxinusfly/app/api_common/loading.dart';
import '../../../commons/all.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../../routes/app_pages.dart';
import '../../quotation/controllers/quotation_controller.dart';
import '../model/get_brand_list_model.dart';
import '../model/get_item_list_model.dart';

class ItemListController extends GetxController {
  TextEditingController searchFieldController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void onInit() {
    getBrandListApi(Get.context!);
    getCategoryListApi(Get.context!);
    itemListApi();
    super.onInit();
  }

  int selected = 0;
  int itemId = 0;
  int brandId = 0;
  int categoryId = 0;
  List<commonModel> quotationList = [
    commonModel(
        itemName: "Item 1",
        itemCode: "001",
        unitCode: "pcs",
        basicPrice: "100.0",
        purchasePrice: "90.0",
        purchaseVatAmt: "10.0",
        discount: "5%",
        itemValue: "85.0",
        stockQty: "50",
        branchName: "Brand A",
        subBrand: "SubBrand A",
        category: "Category A",
        subcategory: "SubCategory A",
        barCodeNo: "12345678908"),
    commonModel(
        itemName: "Item 1",
        itemCode: "001",
        unitCode: "pcs",
        basicPrice: "100.0",
        purchasePrice: "90.0",
        purchaseVatAmt: "10.0",
        discount: "5%",
        itemValue: "85.0",
        stockQty: "50",
        branchName: "Brand A",
        subBrand: "SubBrand A",
        category: "Category A",
        subcategory: "SubCategory A",
        barCodeNo: "12345678908"),
  ];

  void filterItems(String query) {
    filteredItems = Constants.itemList;
    if (query.isEmpty) {
      filteredItems = Constants.itemList;
    } else {
      filteredItems = Constants.itemList
          .where((item) =>
              item.itemName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void selectItemName() {
    filteredItems = Constants.itemList;
    searchFieldController.clear();
    Get.bottomSheet(
      GetBuilder<ItemListController>(
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
                              itemNameController.text =
                                  filteredItems[index].itemName ?? "";
                              itemId = filteredItems[index].itemid ?? 0;
                              itemListApi();
                              update();
                              Get.back();
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

  void selectBrand() {
    filteredItems = Constants.itemList;
    searchFieldController.clear();
    Get.bottomSheet(
      GetBuilder<ItemListController>(
        builder: (controller) {
          return DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ListView.builder(
                itemCount: brandList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: GestureDetector(
                      onTap: () {
                        brandController.text = brandList[index].brandName ?? "";
                        brandId = brandList[index].brandID ?? 0;
                        controller.update();
                        itemListApi();
                        Get.back();
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12)),
                        child: commonTableText(
                            title: brandList[index].brandName ?? ""),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void selectCategory() {
    Get.bottomSheet(
      GetBuilder<ItemListController>(
        builder: (controller) {
          return DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 25),
              child: ListView.builder(
                itemCount: categoryList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: GestureDetector(
                      onTap: () {
                        categoryController.text =
                            categoryList[index].categoryName ?? "";
                        categoryId = categoryList[index].categoryID ?? 0;
                        controller.update();
                        itemListApi();
                        Get.back();
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12)),
                        child: commonTableText(
                            title: categoryList[index].categoryName ?? ""),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  List<BrandData> brandList = [];

  Future<void> getBrandListApi(BuildContext context) async {
    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getBrandList,
      context: context,
    );

    GetBrandListModel model = GetBrandListModel.fromJson(data);
    if (model.statusCode == 200) {
      brandList = model.data ?? [];
      update();
    }
  }

  List<BrandData> categoryList = [];

  Future<void> getCategoryListApi(BuildContext context) async {
    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getCategoryList,
      context: context,
    );

    GetBrandListModel model = GetBrandListModel.fromJson(data);
    if (model.statusCode == 200) {
      categoryList = model.data ?? [];
      update();
    }
  }

  List<ItemListData> itemList = [];

  Future<void> itemListApi() async {
    String url = "${Constants.itemListApi}?";

    if (itemId != 0) {
      url = url + "&" + "itemid=${itemId}";
    }
    if (brandId != 0) {
      url = url + "&" + "Brandid=${brandId}";
    }
    if (categoryId != 0) {
      url = url + "&" + "Categoryid=${categoryId}";
    }
    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    GetReportItemListModel model = GetReportItemListModel.fromJson(data);
    if (model.statusCode == 200) {
      itemList = model.data ?? [];
      update();
    }
  }

  void genaratePDFApi() async {
    String url = "Reports/ItemListPDFurl?";

    if (itemId != 0) {
      url = url + "&" + "itemid=${itemId}";
    }
    if (brandId != 0) {
      url = url + "&" + "Brandid=${brandId}";
    }
    if (categoryId != 0) {
      url = url + "&" + "Categoryid=${categoryId}";
    }
    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    Loading.show();
    Future.delayed(
      Duration(seconds: 5),
      () {
        Loading.dismiss();
        Get.toNamed(Routes.PDF_VIEW, arguments: data);
      },
    );
  }
}

Widget commonTableText({String? title, bool? isLight, bool? isEnd}) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Text(
      title ?? "",
      textAlign: isEnd == true ? TextAlign.end : TextAlign.start,
      style: TextStyle(
        fontSize: FontSize.s16,
        color: isLight == true ? Colors.black45 : Colors.black,
        fontFamily: FontFamily.medium,
      ),
    ),
  );
}
