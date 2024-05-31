
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tasky/core/widgets/app_button.dart';
import 'package:tasky/features/feature_auth/presentation/bloc/auth_cubit.dart';
import 'package:tasky/features/feature_auth/presentation/screens/sign_in_screen.dart';
import 'package:tasky/features/feature_auth/presentation/screens/widgets/phone_field.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign_up_screen';

  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final experienceController = TextEditingController();
  String? levelController;

  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  // methods
  bool obscure = true;

  Icon get eyeIcon {
    if (obscure) {
      return const Icon(Iconsax.eye_slash);
    } else {
      return const Icon(Iconsax.eye);
    }
  }

  void toggleObscure() {
    setState(() {
      obscure = !obscure;
    });
  }

  // dispose controllers

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: 'intro',
              child: Image.asset(
                'assets/images/intro2.png',
                fit: BoxFit.cover,
                width: width,
                height: 400,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 22),
                  child: Text(
                    'Login',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: nameController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name...',
                    ),
                    onTapOutside: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 15),
                PhoneField(),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: experienceController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Years of experince...',
                        suffixIconColor: Colors.grey),
                    onTapOutside: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(border: InputBorder.none),
                    value: levelController,
                    hint: Text(
                      'Choose Experience Level',
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        levelController = newValue!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items: <String>['fresh', 'junior', 'midLevel', 'senior']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: addressController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Address...',
                        suffixIconColor: Colors.grey),
                    onTapOutside: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: obscure,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password...',
                        suffixIcon: IconButton(
                          onPressed: toggleObscure,
                          icon: eyeIcon,
                        ),
                        suffixIconColor: Colors.grey),
                    onTapOutside: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 32, left: 22, right: 22),
                  child: AppButton(
                      title: 'Sign Up',
                      onPressed: () async {
                        BlocProvider.of<AuthCubit>(context)
                            .signUserIn(
                                password: passwordController.text,
                                displayName: nameController.text,
                                experienceYear: experienceController.text,
                                address: addressController.text,
                                level: levelController)
                            .then((userId) {
                              print(userId);
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    icon: Icon(
                                      userId != null
                                          ? Icons.check
                                          : Icons.error_outlined,
                                      color: const Color(0xFF5F33E1),
                                      size: 40,
                                    ),
                                    title: Text(
                                        userId != null? 'Succeed' : 'Failed',style: const TextStyle(fontWeight: FontWeight.bold),),
                                    content: Text(userId != null
                                        ? 'You have successfully Signed up now go to sign in page and login'
                                        : 'Try again',style: const TextStyle(fontSize: 24),textAlign: TextAlign.center,),
                                actions: [
                                  AppButton(title: userId != null? 'Sign In':'Ok', onPressed: (){
                                    if(userId != null){
                                      Navigator.pop(context,true);
                                      Navigator.pop(context,true);
                                    }else{
                                      Navigator.pop(context,false);
                                    }
                                  })
                                ],
                                  ));
                        });
                      }),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    CupertinoButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context, SignInScreen.routeName);
                      },
                      padding: EdgeInsets.zero,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
