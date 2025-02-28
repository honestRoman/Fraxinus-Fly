import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fraxinusfly/app/api_common/api_function.dart';
import 'package:fraxinusfly/app/commons/get_storage_data.dart';
import '../../../commons/all.dart';
import '../../../routes/app_pages.dart';
import '../model/company_code_model.dart';
import '../model/company_model.dart';

class CompanyCodeController extends GetxController {
  int key = 0;
  final List<TextEditingController> codeController =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  TextEditingController companyNameController =
      TextEditingController(text: "Select Company");
  RxBool isLoaded = false.obs;
  RxBool isOpen = false.obs;
  RxInt companyId = 0.obs;

  collapse() {
    int newKey = 0;
    do {
      key = new Random().nextInt(10000);
    } while (newKey == key);
  }

  List<CompanyData> companyNameList = [];

  @override
  void onInit() {
    super.onInit();
    collapse();
    super.onClose();
  }

  Widget buildOtpField(BuildContext context, int index) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: TextField(
          controller: codeController[index],
          focusNode: focusNodes[index],
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.top,
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          maxLength: 1,
          cursorHeight: 20,
          style: const TextStyle(fontSize: 24),
          decoration: const InputDecoration(
            counterText: '',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (index < 5) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              }
            } else if (index > 0) {
              FocusScope.of(context).requestFocus(focusNodes[index - 1]);
            }
          },
        ),
      ),
    );
  }

  String getOtpCode() {
    String otp = '';
    for (var controller in codeController) {
      otp += controller.text;
    }
    return otp;
  }

  var code = "";

  Future<void> apiCallGetCompanyList(BuildContext context) async {
    code = "";
    codeController.forEach(
      (element) {
        if (code.isEmpty) {
          code = element.text;
        } else {
          code = code + element.text;
        }
      },
    );
    FormData formData = FormData.fromMap({});
    final data = await GetAPIFunction().apiCall(
      apiName:
          'https://fraxinuswebapis.azurewebsites.net/api/User/Companylist/${code}',
      context: context,
      params: formData,
    );

    CompanyListModel model = CompanyListModel.fromJson(data);
    if (model.statusCode == 200) {
      GetStorageData.saveString(GetStorageData.companyCode, code);
      companyNameList = model.data ?? [];
      update();
    }
  }

  Future<void> apiCallGetToken(BuildContext context) async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName:
          'https://fraxinuswebapis.azurewebsites.net/api/User/Selectcompany/$code/$companyId',
      context: context,
      params: formData,
    );
    CompanyCodeTokenModel model = CompanyCodeTokenModel.fromJson(data);
    if (model.statusCode == 200) {
      Get.offAllNamed(Routes.LOGIN, arguments: model.data!.token);
      update();
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
