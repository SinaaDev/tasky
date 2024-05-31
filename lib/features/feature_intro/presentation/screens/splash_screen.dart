import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/features/feature_intro/presentation/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void goToOnboarding(){
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
    });
  }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   goToOnboarding();
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: DelayedWidget(
              animationDuration: const Duration(milliseconds: 1500),
              child: SvgPicture.asset('assets/images/tasky_icon.svg')),
        ),
      ),
    );
  }
}
