import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:tasky/core/params/task_param.dart';
import 'package:tasky/core/token/token_manager.dart';

class ApiProvider {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 6000),
      receiveTimeout: Duration(seconds: 6000),
      responseType: ResponseType.json,
      contentType: 'application/json'
    )
  );
  GetStorage getStorage = GetStorage();

  Future<dynamic> sendCreateRequest(TaskParam param) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await TokenManager.instance.getAccessToken()}'
    };
    var data = json.encode({
      "image": param.path,
      "title": param.title,
      "desc": param.desc,
      "priority": param.priority,
      "dueDate": param.dueDate
    });
    var response = await dio.request(
      'https://todo.iraqsapp.com/todos',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    print(response.data);
  }

  Future<dynamic> sendDeleteRequest(String taskId)async{
    var headers = {
      'Authorization': 'Bearer ${await TokenManager.instance.getAccessToken()}'
    };
    var response = await dio.request(
      'https://todo.iraqsapp.com/todos/$taskId',
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
    );
    print('Delete response: ${response.data}');
    return response;
  }

}
