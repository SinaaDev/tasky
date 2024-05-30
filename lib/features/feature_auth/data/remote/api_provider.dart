
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tasky/core/models/TokenModel.dart';
import 'package:tasky/core/params/login_params.dart';
import 'package:tasky/core/params/user_params.dart';
import 'package:tasky/core/token/api.dart';
import 'package:tasky/core/token/token_manager.dart';

class ApiProvider {
  final Dio dio = Dio();
  GetStorage getStorage = GetStorage();


  Future<TokenModel> sendRegisterRequest(UserParams params) async {
    try {
      Response response = await dio.postUri(
        Uri.parse('https://todo.iraqsapp.com/auth/register'),
        data: {
          "phone": params.phone??'',
          "password": params.password,
          "displayName": params.displayName,
          "experienceYears": params.experienceYears,
          "address": params.address,
          "level": params.level??'fresh', //fresh , junior , midLevel , senior
        },
      );
      print(response.data);
      return TokenModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        print('401 error');
        return Future.error('Invalid credential');
      } else {
        return Future.error('Internal Server error');
      }
    } catch (e) {
      print('server error');
      return Future.error(e.toString());
    }

  }

  Future<TokenModel> sendSignInRequest(LoginParams params) async {
    try {
      Response response = await dio.postUri(
          Uri.parse('https://todo.iraqsapp.com/auth/login'),
          data: {"phone": params.phoneNumber, "password": params.password});
      print(response.data);
      return TokenModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        print('401 error');
        return Future.error('Invalid credential');
      } else {
        return Future.error('Internal Server error');
      }
    } catch (e) {
      print('server error');
      return Future.error(e.toString());
    }
  }
}
