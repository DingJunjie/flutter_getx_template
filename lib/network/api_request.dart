// ignore_for_file: constant_identifier_names, camel_case_types

import 'dart:convert';
import 'dart:typed_data';
import 'package:at_planning/exceptions/error.exception.dart';
import 'package:at_planning/exceptions/request.exception.dart';
import 'package:at_planning/models/resp_dto.dart';
import 'package:at_planning/network/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../consts/code.dart';

const String HTTPS_CENSOR_BASE_URL = "test.bitebei.com";

enum HTTP_METHOD { GET, POST }

const InvalidCredential = 101;
const ExpiredCredential = 102;
const PermissionLacked = 103;
const PermissionDenied = -103;
const ExceptCode = 104;
const ErrorCode = 105;
const OkCode = 1;

const HTTP_OK = 200;

abstract class ToJson {
  String toJson();
}

final class Req {
  static int badRequestCount = 0;

  static Future<T> post<T, R extends RespDto<T>>(
      String path, ToJson body, R Function(String) fromJsonFn,
      {bool login = true, bool isStream = false}) async {
    Uri uri = Uri(scheme: "https", host: HTTPS_CENSOR_BASE_URL, path: path);
    debugPrint("准备发送请求 post，url$path，body为${body.toJson().toString()}");

    final response = await _common(
        uri: uri,
        method: HTTP_METHOD.POST,
        fromJsonFn: fromJsonFn,
        body: body,
        login: login);

    return response.get();
  }

  static Future<Uint8List> postBinary(
    String uri,
    ToJson body,
  ) async {
    final header = await _headers(true);
    Uri fullUri = Uri(scheme: "https", host: HTTPS_CENSOR_BASE_URL, path: uri);

    final resp = await http.post(
      fullUri,
      headers: header,
      body: body.toJson(),
    );

    return resp.bodyBytes;
  }

  static Future<T> get<T, R extends RespDto<T>>(
      String path, R Function(String) fromJsonFn,
      {bool login = true}) async {
    Uri uri = Uri(scheme: "https", host: HTTPS_CENSOR_BASE_URL, path: path);
    debugPrint("准备发送请求 get，url$path");

    final response = await _common(
        uri: uri,
        method: HTTP_METHOD.GET,
        fromJsonFn: fromJsonFn,
        login: login);
    return response.get();
  }

  static Future<Result<T>> _common<T, R extends RespDto<T>>(
      {required Uri uri,
      required HTTP_METHOD method,
      required R Function(String) fromJsonFn,
      ToJson? body,
      bool login = true}) async {
    late http.Response resp;
    final header = await _headers(login);

    if (method == HTTP_METHOD.GET) {
      resp = await http.get(uri, headers: header);
    } else if (method == HTTP_METHOD.POST) {
      resp = await http.post(uri, headers: header, body: body!.toJson());
    }

    int statusCode = resp.statusCode;

    if (statusCode == HTTP_OK) {
      print("get response ${resp.body}");

      final t = fromJsonFn(resp.body);
      switch (t.code) {
        case OK_CODE:
          return ResOk(t.data as T);
        // return t.data!;
        case INVALID_CREDENTIAL:
          //TODO
          EasyLoading.showToast("登录已失效，请重新登录");
          break;
        case EXPIRED_CREDENTIAL:
          //TODO
          EasyLoading.showToast("频繁刷新，请稍后重试");
          break;
        case PERMISSION_LACKED:
          //@TODO
          // EasyLoading.showToast("没有权限，请联系管理员");
          break;
        case PERMISSION_DENIED:
          //TODO
          // EasyLoading.showToast("权限错误，请联系管理员");
          break;
        case EXCEPT_CODE:
          //TODO
          debugPrint("Network Error 104, message: $resp");
          final msg = json.decode(resp.body)["msg"];
          final errCode = RequestException[msg];
          if (errCode == null) {
            EasyLoading.showError("捕获了未知的错误");
            throw Exception("errCode null");
          }
          final errMsg = ErrorMessage.getErrorMessage(errCode);
          EasyLoading.showError(errMsg);
          break;
        case ERROR_CODE:
          debugPrint("Server error, message: $resp");
          EasyLoading.showToast("网络出现错误，请稍后重试");
          break;
        case _:
          //TODO
          throw Exception("bad request status: $statusCode");
      }

      return ResErr(CodeMsg(t.code, t.msg));
    } else if (statusCode == NOT_FOUND) {
      EasyLoading.showToast("请求错误");
      throw Exception("bad request status: $statusCode");
    } else if (statusCode == SERVER_NOT_RESPONSE) {
      if (badRequestCount > 3) {
        EasyLoading.showToast("服务器响应错误，即将退出");
        Future.delayed(const Duration(seconds: 2), () {
          badRequestCount = 0;
        });
      }
      EasyLoading.showToast("服务器响应错误，Error code 502，请联系管理员");
      badRequestCount++;
      throw Exception("bad request status: $statusCode");
    } else {
      debugPrint("未知错误");
      // throw Exception("bad request status: $statusCode");
      return ResErr(CodeMsg(-1, "bad request status: $statusCode"));
    }
  }

  static fetchData<T, R extends RespDto<T>>() {}

  // static Future<RefreshTokenResp> refreshToken<RefreshTokenReqDto>(
  //     ToJson body) async {
  //   print("token刷新，body为$body");
  //   final resp = await http.post(
  //     Uri(
  //         scheme: "https",
  //         host: HTTPS_CENSOR_BASE_URL,
  //         path: "/auth/login/refresh"),
  //     // Uri.parse("$HTTPS_CENSOR_BASE_URL/auth/login/refresh"),
  //     headers: await _headers(false),
  //     body: body.toJson(),
  //   );

  //   return RefreshTokenResp.fromJson(resp.body);
  // }
}

Future<Map<String, String>> _headers(bool login) async => {
      'Content-Type': 'application/json',
      'Authorization': login ? await Token.fetch() : 'anonymous'
    };

final class Token {
  static Future? _locker;

  static bool get isRefreshing => _locker != null;

  static bool isTokenExpired = false;

  static String token = "";

  static getToken() {
    return token;
  }

  static Future<String> fetch() async {
    if (isTokenExpired) {
      if (isRefreshing) {
        await _locker;
      } else {
        debugPrint("准备刷新token，创建锁");
        _locker = refresh().whenComplete(() => _locker = null).catchError((e) {
          print("refreshing error $e");
          _locker = null;
        });
        await _locker;
        _locker = null;
      }
    }
    debugPrint(token);
    return getToken();
  }

  static Future refresh() async {}
}
