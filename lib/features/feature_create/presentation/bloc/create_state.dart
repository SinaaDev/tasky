part of 'create_cubit.dart';

@immutable
class CreateState {
  CreationStatus creationStatus;

  CreateState(this.creationStatus);

  CreateState copyWith({
    CreationStatus? newCreationStatus,
  }) {
    return CreateState(newCreationStatus ?? creationStatus);
  }
}
