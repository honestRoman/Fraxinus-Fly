import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fraxinusfly/app/commons/font_family.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fraxinusfly",
      initialRoute: AppPages.INITIAL,
      theme: ThemeData(
        fontFamily: FontFamily.medium,
      ),
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    );
  }
}
