import 'package:bloc/bloc.dart';
import 'package:tasky/core/params/edit_task_params.dart';
import 'package:tasky/core/resources/data_state.dart';
import 'package:tasky/features/feature_home/data/model/OneTaskModel.dart';
import 'package:tasky/features/feature_home/data/remote/api_provider.dart';
import 'package:tasky/features/feature_home/data/repositroy/tasks_repository.dart';

import '../../../data/model/AllTaskModel.dart';

part 'home_state.dart';
part 'home_status.dart';
part 'detail_status.dart';
part 'edit_status.dart';
class HomeCubit extends Cubit<HomeState> {

  TaskRepository taskRepository = TaskRepository();

  HomeCubit() : super(HomeState(HomeEmpty(),DetailLoading(),EditLoading()));

  HomeApiProvider apiProvider = HomeApiProvider();


  OneTaskModel? task;

  Future<dynamic> fetchAllTasks()async{

    emit(state.copyWith(newHomeStatus: HomeLoading()));

    DataState dataState = await taskRepository.fetchAllTask();

    if(dataState is DataSuccess){
      print('data is success');
      emit(state.copyWith(newHomeStatus: HomeCompleted(dataState.data)));

    }
    if(dataState is DataFailed){
      emit(state.copyWith(newHomeStatus: HomeFailed(dataState.error!)));

    }
  }

  Future<dynamic> fetchOneTask(String taskId)async{
    emit(state.copyWith(newDetailsStatus: DetailLoading()));

    DataState dataState = await taskRepository.fetchOneTask(taskId);

    if(dataState is DataSuccess){
      emit(state.copyWith(newDetailsStatus: DetailCompleted(dataState.data)));
      task = dataState.data;
    }

    if(dataState is DataFailed){
      emit(state.copyWith(newDetailsStatus: DetailFailed(dataState.error!)));
    }
  }

  Future<void> editTask(EditTaskParams params) async{

    emit(state.copyWith(newEditStatus: EditLoading()));

    DataState dataState = await taskRepository.editTask(params);

    if(dataState is DataFailed){
      emit(state.copyWith(newEditStatus: EditCompleted()));
    }

    if(dataState is DataFailed){
      emit(state.copyWith(newEditStatus: EditFailed(dataState.error!)));
    }

  }

}
