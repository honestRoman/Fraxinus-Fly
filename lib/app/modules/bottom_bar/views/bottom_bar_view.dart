import 'dart:io';
import 'package:fraxinusfly/app/commons/all.dart';
import 'package:gap/gap.dart';
import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: SizedBox(
            height: AppBar().preferredSize.height + (Platform.isIOS ? 30 : 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.indexCount.value = 0;
                        controller.update();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.home,
                            height: 25,
                            color: controller.indexCount.value == 0
                                ? Colors.blue
                                : Colors.black45,
                          ),
                          Gap(6),
                          Text(
                            AppString.main,
                            style: TextStyle(
                              color: controller.indexCount.value == 0
                                  ? Colors.blue
                                  : Colors.black45,
                              fontSize: FontSize.s14,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.indexCount.value = 1;
                        controller.update();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.transaction,
                              height: 25,
                              color: controller.indexCount.value == 1
                                  ? Colors.blue
                                  : Colors.black45),
                          Gap(6),
                          Text(
                            AppString.transaction,
                            style: TextStyle(
                              color: controller.indexCount.value == 1
                                  ? Colors.blue
                                  : Colors.black45,
                              fontSize: FontSize.s14,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.indexCount.value = 2;
                        controller.update();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.report,
                            height: 25,
                            color: controller.indexCount.value == 2
                                ? Colors.blue
                                : Colors.black45,
                          ),
                          Gap(6),
                          Text(
                            AppString.reports,
                            style: TextStyle(
                              color: controller.indexCount.value == 2
                                  ? Colors.blue
                                  : Colors.black45,
                              fontSize: FontSize.s14,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: controller.screen[controller.indexCount.value],
        );
      },
    );
  }
}
