import 'package:flutter/material.dart';
import 'package:fraxinusfly/app/api_common/loading.dart';
import 'package:fraxinusfly/my_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  GetStorage.init();
  Loading.init();
  runApp(
    MyApp(),
  );
}
