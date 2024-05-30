part of 'home_cubit.dart';

abstract class DetailStatus {}

class DetailLoading extends DetailStatus {}

class DetailCompleted extends DetailStatus {
  OneTaskModel oneTaskModel;

  DetailCompleted(this.oneTaskModel);
}

class DetailFailed extends DetailStatus {
  String error;

  DetailFailed(this.error);
}
