/*import 'package:dio/dio.dart';
import 'package:fraxinusfly/app/commons/get_storage_data.dart';

import '../commons/all.dart';
import 'api_class.dart';

class APIFunction {

  Future<dynamic> apiCall({
    required String apiName,
    required BuildContext context,
    FormData? params,
    String? rawData,
    String? token = "",
    bool isLoading = true,
  }) async {
    if(GetStorageData.containKey(GetStorageData.token))
      {
        token = GetStorageData.readString(GetStorageData.token);
      }
    var response = await HttpUtil(token!, isLoading, context).post(
      apiName,
      data: rawData!,
    );
    return response;
  }
}

class GetAPIFunction {
  Future<dynamic> apiCall({
    required String apiName,
    required BuildContext context,
    FormData? params,
    String? token = "",
    bool isLoading = true,
  }) async {
    if(GetStorageData.containKey(GetStorageData.token))
    {
      token = GetStorageData.readString(GetStorageData.token);
    }
    var response = await HttpUtil(token!, isLoading, context).get(
      apiName,
    );
    return response;
  }
}*/

import 'package:dio/dio.dart';
import 'package:fraxinusfly/app/commons/get_storage_data.dart';
import 'package:flutter/material.dart';
import '../commons/all.dart';
import 'api_class.dart';

class APIFunction {
  Future<dynamic> apiCall({
    required String apiName,
    required BuildContext context,
    FormData? params,
    String? rawData,
    bool isLoading = true,
  }) async {
    String token = "";

    if (GetStorageData.containKey(GetStorageData.token)) {
      token = GetStorageData.readString(GetStorageData.token);
    }

    var response = await HttpUtil(token, isLoading, context).post(
      apiName,
      data: rawData ?? "",
    );
    return response;
  }
}

class GetAPIFunction {
  Future<dynamic> apiCall({
    required String apiName,
    required BuildContext context,
    FormData? params,
    bool isLoading = true,
  }) async {
    String token = "";
    if (GetStorageData.containKey(GetStorageData.token)) {
      token = GetStorageData.readString(GetStorageData.token);
    }

    var response = await HttpUtil(token, isLoading, context).get(apiName);
    return response;
  }
}
