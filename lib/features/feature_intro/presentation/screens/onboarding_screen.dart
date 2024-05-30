import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:tasky/features/feature_auth/presentation/screens/sign_in_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding_screen';

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // context methods
    void goToAuthPage() {
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    }

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/intro.png',
                fit: BoxFit.cover,
                width: width,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  JelloIn(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16, right: 60, left: 60),
                      child: Text(
                        'Task Management & To-Do List',
                        textAlign: TextAlign.center,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                      'This productive tool is designed to help you better manage your task project-wise conveniently!',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 32, left: 22, right: 22, bottom: height * 0.05),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            minimumSize: Size(double.infinity, 50)),
                        onPressed: goToAuthPage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Let's Start ",
                              style: textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                            ),
                            Icon(
                              IconlyBold.arrow_right,
                              color: Colors.white,
                            )
                          ],
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
