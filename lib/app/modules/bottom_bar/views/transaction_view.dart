import 'package:fraxinusfly/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:fraxinusfly/app/routes/app_pages.dart';
import 'package:gap/gap.dart';
import '../../../commons/all.dart';

class TransactionView extends GetView<BottomBarController> {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20, AppBar().preferredSize.height, 20, 0),
      children: List.generate(
        controller.transactionTab.length,
        (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                if (controller.transactionTab[index].name ==
                    AppString.quotation) {
                  Get.toNamed(Routes.QUOTATION);
                } else if (controller.transactionTab[index].name ==
                    AppString.salesOrder) {
                  Get.toNamed(Routes.SALES_ORDER);
                } else {
                  Get.toNamed(Routes.SALE_INVOICE);
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
                        controller.transactionTab[index].image ?? "",
                        height: 30,
                      ),
                      Gap(8),
                      Text(
                        controller.transactionTab[index].name ?? "",
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
