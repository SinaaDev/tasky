part of 'home_cubit.dart';

class HomeState{
  HomeStatus homeStatus;
  DetailStatus detailStatus;
  EditStatus? editStatus;
  HomeState(this.homeStatus,this.detailStatus,this.editStatus);

  HomeState copyWith({
    HomeStatus? newHomeStatus,
    DetailStatus? newDetailsStatus,
    EditStatus? newEditStatus,
  }){
    return HomeState(newHomeStatus ?? homeStatus, newDetailsStatus ?? detailStatus, newEditStatus?? editStatus);
  }
}