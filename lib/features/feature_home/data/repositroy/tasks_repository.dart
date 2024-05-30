import 'package:dio/dio.dart';
import 'package:tasky/core/params/edit_task_params.dart';
import 'package:tasky/features/feature_home/data/model/AllTaskModel.dart';
import 'package:tasky/features/feature_home/data/model/OneTaskModel.dart';
import 'package:tasky/features/feature_home/data/model/profile_model.dart';
import 'package:tasky/features/feature_home/data/remote/api_provider.dart';

import '../../../../core/resources/data_state.dart';

class TaskRepository {
  HomeApiProvider apiProvider = HomeApiProvider();

  Future<DataState<List<AllTaskModel>>> fetchAllTask() async {
    try {
      Response response = await apiProvider.sendFetchAllRequest();
      print("status code ${response.statusCode}");

      if (response.statusCode == 200) {
        List<AllTaskModel> taskList = [];
        Response response = await apiProvider.sendFetchAllRequest();

        for (var item in response.data) {
          var task = AllTaskModel.fromJson(item);
          taskList.add(task);
        }
        print('list length: ${taskList.length}');
        return DataSuccess(taskList);
      } else {
        return DataFailed('Something went wrong');
      }
    } catch (e) {
      return DataFailed('Please check your connection');
    }
  }

  Future<DataState<ProfileModel>> fetchProfileDetails() async {
    try {
      Response response = await apiProvider.sendFetchProfileRequest();

      if (response.statusCode == 200) {
        ProfileModel profileModel = ProfileModel.fromJson(response.data);
        return DataSuccess(profileModel);
      } else {
        return const DataFailed('Something went wrong');
      }
    } catch (e) {
      return DataFailed('Check your connection');
    }
  }

  Future<DataState<OneTaskModel>> fetchOneTask(String taskId) async {
    try{
      Response response = await apiProvider.sendFetchOneTaskRequest(taskId);

      if(response.statusCode == 200){
        OneTaskModel oneTaskModel = OneTaskModel.fromJson(response.data);
        return DataSuccess(oneTaskModel);
      }else{
        return DataFailed('Something went wrong...');
      }
    }catch(e){
      return DataFailed('Check your connection');
    }

  }

  Future<DataState<void>> editTask(EditTaskParams params)async{
    try{
      Response response = await apiProvider.sendEditRequest(params);

      if(response.statusCode == 200){
        return DataSuccess(response.data);
      }else{
        return DataFailed('Something went wrong...');
      }
    }catch(e){
      return DataFailed('Check your connection...');
    }
  }

}
