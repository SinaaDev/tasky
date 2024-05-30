part of 'profile_cubit.dart';

class ProfileState {
  ProfileStatus profileStatus;

  ProfileState(this.profileStatus);

  ProfileState copyWith(
    ProfileStatus? newProfileStatus,
  ) {
    return ProfileState(newProfileStatus ?? profileStatus);
  }
}
