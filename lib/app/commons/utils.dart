import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'all.dart';

/// <<< To get commons function --------- >>>
class Utils {

  noDataFound(BuildContext context, bool isShow) {
    return Center(
      child: Text(
        isShow == true ? "No Data Found" : "",
        style: TextStyle(
          color: Colors.grey.withOpacity(0.6),
          fontFamily: FontFamily.medium,
          fontSize: FontSize.s16,
        ),
      ),
    );
  }

  /// <<< To check data, string, list, object are empty or not --------- >>>
  bool isValidationEmpty(String? val) {
    if (val == null ||
        val.isEmpty ||
        val == "null" ||
        val == "" ||
        val == "NULL") {
      return true;
    } else {
      return false;
    }
  }

  /// <<< To show snackBar massage  --------- >>>
  void showSnackBar(
      {required BuildContext context,
      required String message,
      bool? isOk = false}) {
    Future<void>.delayed(Duration.zero, () {
      Get.snackbar(
        "",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: isOk! ? Colors.green.shade600 : Colors.red.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        padding:
            const EdgeInsets.only(bottom: 15, top: 10, left: 15, right: 15),
        titleText: Container(),
      );
    });
  }

  /// <<< To show toast massage  --------- >>>
  void showToast({required String message, required BuildContext context}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      backgroundColor: Colors.black26,
    );
  }

  /// <<< hide keyboard --------- >>>
  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

/// <<< Error Massage Red color --------- >>>
void printError(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[91m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}
