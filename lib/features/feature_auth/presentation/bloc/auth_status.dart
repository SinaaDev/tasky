part of 'auth_cubit.dart';

@immutable
abstract class AuthStatus {}


class LoggedIn extends AuthStatus{}

class LoggedOut extends AuthStatus{}

class initial extends AuthStatus{}
