import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky/features/feature_auth/presentation/bloc/auth_cubit.dart';
import 'package:tasky/features/feature_auth/presentation/screens/sign_in_screen.dart';
import 'package:tasky/features/feature_auth/presentation/screens/sign_up_screen.dart';
import 'package:tasky/features/feature_create/presentation/bloc/create_cubit.dart';
import 'package:tasky/features/feature_create/presentation/screens/create_screen.dart';
import 'package:tasky/features/feature_home/presentation/bloc/profile_cubit/profile_cubit.dart';
import 'package:tasky/features/feature_home/presentation/screens/details_screen.dart';
import 'package:tasky/features/feature_home/presentation/screens/home_screen.dart';
import 'package:tasky/features/feature_home/presentation/screens/profile_screen.dart';
import 'package:tasky/features/feature_intro/presentation/screens/onboarding_screen.dart';
import 'package:tasky/features/feature_intro/presentation/screens/splash_screen.dart';

import 'features/feature_home/presentation/bloc/home_cubit/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (ctx) => AuthCubit()),
    BlocProvider(create: (ctx) => CreateCubit()),
    BlocProvider(create: (ctx) => HomeCubit()),
    BlocProvider(create: (ctx) => ProfileCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AuthCubit>(context).checkAuth();

    print('init state');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.dmSans().fontFamily,
          colorScheme: const ColorScheme.light(
              primary: Color(0xFF5F33E1), secondary: Colors.amberAccent)),
      home: FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 1555)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            } else {
              return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                if (state.authStatus is LoggedIn) {
                  return HomePage();
                } else {
                  return SignInScreen();
                }
              });
            }
          }),
      routes: {
        OnboardingScreen.routeName: (ctx) => const OnboardingScreen(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        HomePage.routeName: (ctx) => HomePage(),
        CreateScreen.routeName: (ctx) => const CreateScreen(),
        ProfileScreen.routeName: (ctx) => const ProfileScreen(),
        DetailsScreen.routeName: (ctx) => const DetailsScreen(),
      },
    );
  }
}
