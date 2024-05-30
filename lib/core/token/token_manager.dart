import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tasky/core/models/TokenModel.dart';

import 'api.dart';

class TokenManager {
  static TokenManager? _instance;

  static TokenManager get instance {
    _instance ??= TokenManager._();
    return _instance!;
  }
  GetStorage getStorage = GetStorage();

  String accessToken = '';
  String refreshToken ='';
  String userId = '';
  bool isRefreshing = false;
  Completer<void>? completer;

  TokenManager._();

  Future<String> getAccessToken() async {
    if (isTokenExpired() && !isRefreshing) {
      debugPrint("Token has expired, refreshing access token.");
      isRefreshing = true;
      completer = Completer<void>();
      await renewAccessToken();
      isRefreshing = false;
      completer?.complete();
    }
    if (isRefreshing) {
      debugPrint(
          "Already refreshing access token, waiting for it to complete.");
      // await completer?.future;
    }
    String token = getStorage.read('accessToken');
    return token;
  }

  Future<String> getUserId()async{
    userId = getStorage.read('userId');
    print('user id: $userId');
    return userId;
  }

  bool isTokenExpired() {
    String token = getStorage.read('accessToken');
    print(JwtDecoder.isExpired(token));
    return JwtDecoder.isExpired(token);
  }

  Future<void> renewAccessToken() async {
    String rToken = getStorage.read('refreshToken');
    final String token = await Api.getNewAccessToken(rToken);
    getStorage.write('accessToken', token);
  }

  void setToken(TokenModel token) {
    accessToken = token.accessToken ?? accessToken;
    refreshToken = token.refreshToken ?? refreshToken;
  }

  //Method added to just simulate access token expire and refresh process
  void expireAccessToken() {
    accessToken =
        "yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTY3Mjc2NjAyOCwiZXhwIjoxNjc0NDk0MDI4fQ.kCak9sLJr74frSRVQp0_27BY4iBCgQSmoT3vQVWKzJg";
  }
}
