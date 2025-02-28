import 'package:fraxinusfly/app/commons/get_storage_data.dart';
import 'package:fraxinusfly/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 2),() {
      if(GetStorageData.readString(GetStorageData.isOtpVerified) == "true")
        {
      Get.offAllNamed(Routes.BOTTOM_BAR);
        }
      else
        {
          getToken();
        }
    },);
    super.onInit();
  }

  getToken() {
    if(GetStorageData.containKey(GetStorageData.token))
      {
        Get.offAllNamed(Routes.BOTTOM_BAR);
      }
    else
      {
        Get.offAllNamed(Routes.COMPANY_CODE);
      }
  }
}
