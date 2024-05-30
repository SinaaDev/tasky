import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tasky/core/params/login_params.dart';
import 'package:tasky/core/params/user_params.dart';
import 'package:tasky/core/widgets/app_button.dart';
import 'package:tasky/features/feature_auth/data/remote/api_provider.dart';
import 'package:tasky/features/feature_auth/presentation/bloc/auth_cubit.dart';
import 'package:tasky/features/feature_auth/presentation/screens/sign_up_screen.dart';
import 'package:tasky/features/feature_auth/presentation/screens/widgets/phone_field.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign_in_screen';

  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();

  // methods

  // eye icon
  bool obscure = true;

  Icon get eyeIcon {
    if (obscure) {
      return Icon(Iconsax.eye_slash);
    } else {
      return Icon(Iconsax.eye);
    }
  }

  void toggleObscure() {
    setState(() {
      obscure = !obscure;
    });
  }

  // login method


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              Hero(
                tag: 'intro',
                child: Image.asset(
                  'assets/images/intro.png',
                  fit: BoxFit.cover,
                  width: width,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16, left: 22),
                    child: Text(
                      'Login',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PhoneField(),
                  SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    padding: EdgeInsets.only(left: 16),
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password...',
                          suffixIcon: IconButton(
                            onPressed: toggleObscure,
                            icon: eyeIcon,
                          ),
                          suffixIconColor: Colors.grey),
                      obscureText: obscure,
                      onTapOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 32, left: 22, right: 22),
                    child: AppButton(title: 'Sign In', onPressed: (){
                      BlocProvider.of<AuthCubit>(context).login(passwordController.text);

                    }),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                      CupertinoButton(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(height: height*0.025,),
                    ],
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

