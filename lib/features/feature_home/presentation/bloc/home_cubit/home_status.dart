part of 'home_cubit.dart';

abstract class HomeStatus{}

class HomeEmpty extends HomeStatus{}

class HomeLoading extends HomeStatus{}

class HomeCompleted extends HomeStatus{
  final List<AllTaskModel> allTaskList;

  HomeCompleted(this.allTaskList);
}

class HomeFailed extends HomeStatus{
  String message;

  HomeFailed(this.message);
}