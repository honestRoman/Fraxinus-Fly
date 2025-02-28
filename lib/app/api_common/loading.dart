import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../commons/all.dart';

class Loading{

  static void init () {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.pouringHourGlass
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50.0
      ..radius = 15.0
      ..progressColor = Colors.red
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.red
      ..textColor = Colors.red
      ..maskColor = Colors.blue
      ..boxShadow = <BoxShadow>[]
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static void show() {
    EasyLoading.show();
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}