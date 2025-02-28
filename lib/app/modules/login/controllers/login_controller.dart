import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fraxinusfly/app/api_common/api_function.dart';
import 'package:fraxinusfly/app/commons/get_storage_data.dart';
import 'package:fraxinusfly/app/modules/login/model/login_model.dart';
import '../../../commons/all.dart';
import '../model/otp_model.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String token = "";
  String otp = "";
  String otpMsg = "";
  RxBool isLogin = false.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      token = Get.arguments;
    }
    super.onInit();
  }

  void validation(BuildContext context) {
    if (Utils().isValidationEmpty(userNameController.text.trim())) {
      AppString.pleaseEnter(AppString.userName);
    } else if (Utils().isValidationEmpty(passwordController.text.trim())) {
      AppString.pleaseEnter(AppString.password);
    } else {
      apiCallLogin(context);
    }
  }

  Future<void> apiCallSendOtp(BuildContext context) async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.sendOTP,
      context: context,
      params: formData,
    );

    OtpModel model = OtpModel.fromJson(data);
    if (model.statusCode == 200) {
      Utils().showToast(message: model.data!.otp!, context: context);
      otp = model.data!.otp ?? "";
      otpMsg = model.data!.otpResponse ?? "";
      update();
    } else {
      Utils().showToast(message: model.responseMsg ?? "", context: context);
    }
  }

  final dio = Dio();

  Future<void> apiCallLogin(BuildContext context) async {
    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Cookie':
          'ARRAffinity=ad26f9a6bd8a60cc0a709ea5aba83deeee69ecdeb9e8ed99f43a1cd50f09889a; ARRAffinitySameSite=ad26f9a6bd8a60cc0a709ea5aba83deeee69ecdeb9e8ed99f43a1cd50f09889a'
    };
    var data = json.encode({
      "userName": userNameController.text.trim(),
      "password": passwordController.text.trim(),
    });
    var dio = Dio();
    var response = await dio.request(
      'https://fraxinuswebapis.azurewebsites.net/api/User/UserLogin',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    LoginModel model = LoginModel.fromJson(response.data);

    if (model.statusCode == 200) {
      GetStorageData.saveString(GetStorageData.token, model.data!.token);
      isLogin.value = true;
      apiCallSendOtp(context);
      update();
    } else {
      Utils().showToast(message: model.responseMsg ?? "", context: context);
      log(response.statusMessage ?? "");
    }
  }
}
