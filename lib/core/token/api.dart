import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/core/token/token_manager.dart';

class Api {


  static Future<String> getNewAccessToken(String refreshToken)async{
    print('getNewAccessToken called');
    Response response = await Dio(
      BaseOptions(
        baseUrl: 'https://todo.iraqsapp.com',
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
      ),
    ).get('https://todo.iraqsapp.com/auth/refresh-token',
        queryParameters: {
          'token': refreshToken,
        }
    );
    return response.data['access_token'];
  }


  static Future<Map<String, dynamic>> makeApiCall(String url) async {
    final dynamic response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization":
            "Bearer ${await TokenManager.instance.getAccessToken()}"
      },
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> fetchProfile() async {
    return await makeApiCall("https://api.escuelajs.co/api/v1/auth/profile");
  }
}
