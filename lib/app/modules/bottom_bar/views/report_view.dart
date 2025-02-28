import 'package:fraxinusfly/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:fraxinusfly/app/routes/app_pages.dart';
import 'package:gap/gap.dart';
import '../../../commons/all.dart';

class ReportView extends GetView<BottomBarController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20, AppBar().preferredSize.height, 20, 0),
      children: List.generate(
        controller.reportList.length,
        (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                if (controller.reportList[index].name == AppString.itemList) {
                  Get.toNamed(Routes.ITEM_LIST);
                } else if (controller.reportList[index].name ==
                    AppString.ledgerStatement) {
                  Get.toNamed(Routes.LEDGER_STATEMENT);
                } else if (controller.reportList[index].name ==
                    AppString.saleRegister) {
                  Get.toNamed(Routes.SALE_REGISTER);
                } else if (controller.reportList[index].name ==
                    AppString.purchaseRegister) {
                  Get.toNamed(Routes.PURCHASE_REGISTER);
                } else if (controller.reportList[index].name ==
                    AppString.outstandingReceivable) {
                  Get.toNamed(Routes.OUTSTANDING,
                      arguments: AppString.outstandingReceivable);
                } else if (controller.reportList[index].name ==
                    AppString.outstandingPayables) {
                  Get.toNamed(Routes.OUTSTANDING,
                      arguments: AppString.outstandingPayables);
                }
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFF78829A))),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        controller.reportList[index].image ?? "",
                        height: 30,
                      ),
                      Gap(8),
                      Text(
                        controller.reportList[index].name ?? "",
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: FontFamily.medium,
                            fontSize: FontSize.s16),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
