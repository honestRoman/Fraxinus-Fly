import 'package:fraxinusfly/app/data/common_widget/common_button.dart';
import 'package:gap/gap.dart';
import '../../../commons/all.dart';
import '../controllers/company_code_controller.dart';

class CompanyCodeView extends GetView<CompanyCodeController> {
  const CompanyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompanyCodeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.appIconWithName),
                      Gap(12),
                      Text(
                        "Enter Your Client Code",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s20,
                        ),
                      ),
                      Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            6,
                            (index) =>
                                controller.buildOtpField(context, index)),
                      ),
                      Gap(20),
                      CommonButton(
                        btnName: AppString.loadCompanyList,
                        onTap: () {
                          controller.isLoaded.value = true;
                          Utils().hideKeyboard();
                          controller.apiCallGetCompanyList(context);
                        },
                      ),
                      Gap(15),
                      if (controller.companyNameList.isNotEmpty)
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  AppString.selectCompany,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: FontFamily.semiBold,
                                    fontSize: FontSize.s20,
                                  ),
                                ),
                                Gap(12),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: controller.isOpen.value
                                            ? Colors.blue
                                            : Colors.black26),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Theme(
                                    data: ThemeData(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      key: Key(controller.key.toString()),
                                      onExpansionChanged: (value) {
                                        controller.isOpen.value = value;
                                        controller.update();
                                      },
                                      title: Text(
                                        controller.companyNameController.text,
                                      ),
                                      children: List.generate(
                                        controller.companyNameList.length,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.companyNameController
                                                  .text = controller
                                                      .companyNameList[index]
                                                      .companyName ??
                                                  "";
                                              controller
                                                  .companyId.value = controller
                                                      .companyNameList[index]
                                                      .companyId ??
                                                  0;
                                              controller.collapse();
                                              controller.update();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                controller
                                                        .companyNameList[index]
                                                        .companyName ??
                                                    "",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(15),
                                CommonButton(
                                  btnName: AppString.next,
                                  onTap: () {
                                    controller.apiCallGetToken(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
