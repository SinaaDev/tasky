import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/core/params/task_param.dart';
import 'package:tasky/features/feature_create/data/remote/api_provider.dart';

part 'create_state.dart';
part 'creation_status.dart';

class CreateCubit extends Cubit<CreateState> {
  CreateCubit() : super(CreateState(CreationInitial()));

  ApiProvider apiProvider = ApiProvider();


  Future<void> addTask(TaskParam param)async{

    emit(state.copyWith(newCreationStatus: CreationLoading()));

    apiProvider.sendCreateRequest(param);

    emit(state.copyWith(newCreationStatus: CreationCompleted()));


  }


}
