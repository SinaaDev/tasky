import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:tasky/features/feature_auth/data/remote/api_provider.dart';

import '../../../../core/params/login_params.dart';
import '../../../../core/params/user_params.dart';


part 'auth_state.dart';
part 'auth_status.dart';
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(authStatus: LoggedOut()));

  GetStorage getStorage = GetStorage();
  ApiProvider apiProvider = ApiProvider();

  void checkAuth(){

    print('checking the auth');
    emit(state.copyWith(LoggedOut()));
    var token = getStorage.read('accessToken');
    if(token != null){
      emit(state.copyWith(LoggedIn()));
      print('auth checked auth state is ${token != null}');
    }
  }


  // sign up function
  Future<dynamic> signUserIn({
    required password,
    required displayName,
    required experienceYear,
    required address,
    required level,
  }) async {

    GetStorage getStorage = GetStorage();
    print('phone number: ${phoneNumber}');
    print('password: ${password}');
    print('name: ${displayName}');
    print('experience years: ${experienceYear}');
    print('address: ${address}');
    print('experience level: ${level}');
    String? accessToken;
    final newUser = UserParams(
        phone: phoneNumber??'',
        password: password,
        displayName: displayName,
        experienceYears: experienceYear,
        address: address,
        level: level??'fresh');
    await ApiProvider().sendRegisterRequest(newUser).then((value) {
      print('sign in request send successfully');
      getStorage.write('userId', value.id);
      getStorage.write('accessToken', value.accessToken);
      getStorage.write('refreshToken', value.refreshToken);
      print('${state.authStatus} cubit');
      return accessToken = value.id ;
    }).onError((error, stackTrace) {
      print('onError: ${error.toString()}');
    });
    return accessToken;
  }



  Future<void> login(String password)async{
    emit(state.copyWith(LoggedOut()));

    GetStorage getStorage = GetStorage();

    final loginParams = LoginParams(
      phoneNumber: phoneNumber!,
      password: password,
    );

    await ApiProvider().sendSignInRequest(loginParams).then((value) {
      print('sign in request send successfully');
      getStorage.write('userId', value.id);
      getStorage.write('accessToken', value.accessToken);
      getStorage.write('refreshToken', value.refreshToken);
      emit(state.copyWith(LoggedIn()));
    }).onError((error, stackTrace) {
      print('onError: ${error.toString()}');
    });
  }

  void logout(){
    print(state.authStatus);
    getStorage.erase();
    emit(state.copyWith(LoggedOut()));
    print(state.authStatus);
  }



  String? phoneNumber;



}
