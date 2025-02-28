import 'package:fraxinusfly/app/commons/all.dart';
import 'package:fraxinusfly/app/commons/get_storage_data.dart';
import 'package:fraxinusfly/app/data/common_widget/common_button.dart';
import 'package:fraxinusfly/app/data/common_widget/common_textfeild.dart';
import 'package:fraxinusfly/app/routes/app_pages.dart';
import 'package:gap/gap.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            padding: EdgeInsets.only(top: MediaQuery
                .of(context)
                .padding
                .top + 10, left: 20, right: 20),
            shrinkWrap: true,
            children: [
              Gap(AppBar().preferredSize.height),
              Row(
                children: [
                  Image.asset(
                    AppImages.appIcon,
                    height: 60,
                  ),
                  Gap(5),
                  Text(
                    AppString.appName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: FontFamily.bold,
                    ),
                  ),
                ],
              ),
              Gap(AppBar().preferredSize.height),
              Text(
                AppString.welcomeBack,
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: 28,
                  color: Colors.indigo,
                ),
              ),
              Text(
                AppString.pleaseLoginToContinue,
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s18,
                  color: Colors.black,
                ),
              ),
              Gap(30),
              CommonTextField(
                isTitle: true,
                controller: controller.userNameController,
                borderRadius: 8,
                hintText: AppString.enterUserName,
                title: AppString.userName,
              ),
              Gap(15),
              CommonTextField(
                isTitle: true,
                controller: controller.passwordController,
                borderRadius: 8,
                hintText: AppString.enterPassword,
                title: AppString.password,
                obscureText: true,
              ),
              Gap(20),
              CommonButton(btnName: AppString.login, onTap: () {
                Utils().hideKeyboard();
                controller.validation(context);
                // Get.offAllNamed(Routes.BOTTOM_BAR);
              },),
              if(controller.isLogin.value)
                Gap(15),
              if(controller.isLogin.value)
                Text(
                  controller.otpMsg,
                  style: TextStyle(
                    fontFamily: FontFamily.medium,
                    fontSize: FontSize.s16,
                    color: Colors.indigo,
                  ),
                ),
              if(controller.isLogin.value)
                Gap(15),
              if(controller.isLogin.value)
                CommonTextField(
                  isTitle: true,
                  controller: controller.otpController,
                  borderRadius: 8,
                  title: "OTP",
                ),
              if(controller.isLogin.value)
                Gap(20),
              if(controller.isLogin.value)
                CommonButton(btnName: "Verify", onTap: () {
                  if (controller.otp == controller.otpController.text.trim()) {
                    GetStorageData.saveString(GetStorageData.isOtpVerified, "true");
                    Get.offAllNamed(Routes.BOTTOM_BAR);
                  }else{
                    Utils().showToast(message: "Invalid OTP", context: context);
                  }
                },),
            ],
          ),
        );
      },
    );
  }
}
