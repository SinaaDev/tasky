import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/features/feature_home/data/model/profile_model.dart';
import 'package:tasky/features/feature_home/data/remote/api_provider.dart';
import 'package:tasky/features/feature_home/data/repositroy/tasks_repository.dart';

import '../../../../../core/resources/data_state.dart';

part 'profile_state.dart';

part 'profile_status.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(ProfileLoading()));
  HomeApiProvider apiProvider = HomeApiProvider();

  Future<void> fetchUserProfile() async {
    emit(state.copyWith(ProfileLoading()));

    DataState dataState = await TaskRepository().fetchProfileDetails();

    if (dataState is DataSuccess) {
      emit(state.copyWith(ProfileCompleted(dataState.data)));
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(ProfileFailed(dataState.error!)));
    }
  }
}
