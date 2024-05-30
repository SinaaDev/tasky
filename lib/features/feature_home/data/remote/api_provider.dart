
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tasky/core/params/edit_task_params.dart';

import '../../../../core/token/token_manager.dart';

class HomeApiProvider{
  Dio dio = Dio();

  Future<dynamic> sendFetchAllRequest()async{
    var headers = {
      'Authorization': 'Bearer ${await TokenManager.instance.getAccessToken()}'
    };
    var response = await dio.request(
      'https://todo.iraqsapp.com/todos?page=1',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    print(response.data);
    return response;
  }

  Future<dynamic> sendFetchProfileRequest()async{
    var headers = {
      'Authorization': 'Bearer ${await TokenManager.instance.getAccessToken()}'
    };
    var response = await dio.request(
      'https://todo.iraqsapp.com/auth/profile',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    print(response.data);
    return response;
  }

  Future<dynamic> sendFetchOneTaskRequest(String taskId)async{
    var headers = {
      'Authorization': 'Bearer ${await TokenManager.instance.getAccessToken()}'
    };
    var response = await dio.request(
      'https://todo.iraqsapp.com/todos/$taskId',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    print(response.data);
    return response;
  }

  Future<dynamic> sendEditRequest(EditTaskParams params)async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await TokenManager.instance.getAccessToken()}'
    };
    var data = json.encode({
      "image": params.image,
      "title": params.title,
      "desc": params.desc,
      "priority": params.priority,
      "status": params.status,
      "user": await TokenManager.instance.getUserId()
    });
    Response response = await dio.request(
      'https://todo.iraqsapp.com/todos/${params.user}',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );
    print(response.data);
    return response;
  }

}