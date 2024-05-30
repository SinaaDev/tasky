part of 'profile_cubit.dart';


abstract class ProfileStatus {}

class ProfileLoading extends ProfileStatus {}

class ProfileCompleted extends ProfileStatus {
  final ProfileModel profileModel;

  ProfileCompleted(this.profileModel);
}

class ProfileFailed extends ProfileStatus {
  String message;

  ProfileFailed(this.message);
}
