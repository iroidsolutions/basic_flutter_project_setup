import 'package:align_flutter_app/api/base_provider.dart';
import 'package:align_flutter_app/models/response/common_response.dart';
import 'package:align_flutter_app/network/network_manger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../shared/constants/constants.dart';

class ApiProvider extends BaseProvider {
  CommonResponse commonResponse = CommonResponse();
  final NetworkManager networkManager = Get.put(NetworkManager());
  Future<CommonResponse> postMethod(String path, dynamic data,
      {bool isMultipart = false, FormData? formData}) async {
    printInfo(info: "API Request ======= $data");

    if (networkManager.connectionType.value != 0) {
      Response response = await post(
        path,
        isMultipart ? formData : data,
        headers: {
          'accept': 'application/json',
        },
      ).catchError((error) {
        print(error);
      });
      printInfo(info: "RESPONSE ======= ${response.body}");

      if (response.body != null && response.statusCode == 200) {
        commonResponse = CommonResponse.fromJson(response.body);

        if (commonResponse.dioMessage != null) {
          await EasyLoading.showToast(commonResponse.dioMessage!);
        }
      } else {
        EasyLoading.dismiss();
        await EasyLoading.showToast(StringConstant.serverError);
      }
    } else {
      EasyLoading.dismiss();
      await EasyLoading.showToast(StringConstant.networkError);
    }

    return commonResponse;
  }

  Future<CommonResponse> getMethod(String path) async {
    print(path);
    var response = await get(
      path,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
    ).catchError((e) {
      print("==ERROR===${e.toString()}");
    });
    printInfo(info: "RESPONSE ======= ${response.body}");
    if (response.statusCode == 200 && response.body != null) {
      commonResponse = CommonResponse.fromJson(response.body);
      if (commonResponse.dioMessage != null) {
        await EasyLoading.showToast(commonResponse.dioMessage!);
      }
    } else {
      await EasyLoading.showToast(commonResponse.dioMessage ?? "Null");
    }
    return commonResponse;
  }

  Future<CommonResponse> putMethod(
      String path, Map<String, dynamic> data) async {
    Response response = await put(path, data);
    commonResponse = CommonResponse.fromJson(response.body);
    if (commonResponse.dioMessage != null) {
      await EasyLoading.showToast(commonResponse.dioMessage!);
    } else {
      await EasyLoading.showToast(commonResponse.dioMessage ?? "Null");
    }
    return commonResponse;
  }

  Future<CommonResponse> deleteMethod(
      String path, Map<String, dynamic> data) async {
    printInfo(info: "API Request ======= $data");

    if (networkManager.connectionType.value != 0) {
      Response response = await delete(
        path,
        headers: {
          'accept': 'application/json',
        },
      ).catchError((error) {
        print(error);
      });
      printInfo(info: "RESPONSE ======= ${response.body}");

      if (response.body != null && response.statusCode == 200) {
        commonResponse = CommonResponse.fromJson(response.body);

        if (commonResponse.dioMessage != null) {
          await EasyLoading.showToast(commonResponse.dioMessage!);
        }
      } else {
        EasyLoading.dismiss();
        await EasyLoading.showToast(StringConstant.serverError);
      }
    } else {
      EasyLoading.dismiss();
      await EasyLoading.showToast(StringConstant.networkError);
    }

    return commonResponse;
  }

  // Future<Response> register(String path, RegisterRequest data) {
  //   return post(path, data.toJson());
  // }

  // Future<Response> getUsers(String path) {
  //   return get(path);
  // }
}
  // Future<Response> login(String path, LoginRequest data) {
  //   return post(path, data.toJson());
  // }

  // Future<Response> register(String path, RegisterRequest data) {
  //   return post(path, data.toJson());
  // }

  // Future<Response> getUsers(String path) {
  //   return get(path);
  // }

  // Future<Response> test(String path) {
  //   return get(path);
  // }

