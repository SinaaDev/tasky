part of 'home_cubit.dart';

abstract class EditStatus {}

class EditLoading extends EditStatus {}

class EditCompleted extends EditStatus {
}

class EditFailed extends EditStatus {
  String error;

  EditFailed(this.error);
}
