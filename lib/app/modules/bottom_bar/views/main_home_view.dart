import 'package:fraxinusfly/app/commons/get_storage_data.dart';
import 'package:fraxinusfly/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:fraxinusfly/app/routes/app_pages.dart';
import 'package:gap/gap.dart';
import '../../../commons/all.dart';

class MainHomeView extends GetView<BottomBarController> {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      builder: (controller) {
        return ListView(
          padding:
              EdgeInsets.fromLTRB(20, AppBar().preferredSize.height, 20, 0),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.hiWelcomeBack,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: FontSize.s24,
                          fontFamily: FontFamily.bold,
                        ),
                      ),
                      Text(
                        AppString.salesAndPurchase,
                        style: TextStyle(
                          color: Color(0xFF78829A),
                          fontSize: FontSize.s14,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GetStorageData.saveString(
                        GetStorageData.isOtpVerified, "false");
                    Get.offAllNamed(Routes.COMPANY_CODE);
                    GetStorageData.removeData(GetStorageData.token);
                  },
                  child: Icon(
                    Icons.login,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Gap(20),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SHOW_REPORT,
                    arguments: AppString.todayTotal);
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(colors: [
                      Color(0xFF306FEA),
                      Color(0xFF7596F1),
                    ])),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.todayTotal,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s14,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                      Gap(12),
                      Text(
                        controller.todaySale,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s18,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap(20),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SHOW_REPORT,
                    arguments: AppString.monthlyTotal);
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(colors: [
                      Color(0xFFF84664),
                      Color(0xFFF76980),
                    ])),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.monthlyTotal,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s14,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                      Gap(12),
                      Text(
                        controller.monthSale,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s18,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap(20),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SHOW_REPORT,
                    arguments: AppString.todayPurchase);
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFBBC0E),
                      Color(0xFFFBBC0E),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.todayPurchase,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s14,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                      Gap(12),
                      Text(
                        controller.todayPurchase,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s18,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap(20),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SHOW_REPORT,
                    arguments: AppString.monthlyPurchase);
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(colors: [
                      Color(0xFF0FA172),
                      Color(0xFF44D2A4),
                    ])),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.monthlyPurchase,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s14,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                      Gap(12),
                      Text(
                        controller.monthPurchase,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s18,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

