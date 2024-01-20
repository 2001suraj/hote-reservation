import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/core/utils/data/local_storage.dart';
import 'package:hotel_reservation_app/core/utils/navigator_service.dart';
import 'package:hotel_reservation_app/provider/base_provider.dart';
import 'package:hotel_reservation_app/routes/app_route.dart';
import 'package:hotel_reservation_app/theme/color.dart';
import 'package:hotel_reservation_app/widget/normal_btn.dart';
import 'package:hotel_reservation_app/widget/snack_bar.dart';
import 'package:hotel_reservation_app/widget/text.dart';
import 'package:hotel_reservation_app/widget/text_field.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkbox = ref.watch(chekcBoxValueProvider);
    return Scaffold(
      backgroundColor: AppColor().primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                normalT("Login Accout", size: 25, weight: FontWeight.w700),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 28.0),
                  child: Divider(),
                ),
                NormalTextField(
                  text: "Enter your email",
                  icon: Icons.mail,
                  controller: email,
                ),
                NormalTextField(
                  text: "Password",
                  icon: Icons.lock,
                  controller: password,
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: AppColor().primary,
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green;
                        }
                        return AppColor().text;
                      }),
                      value: checkbox,
                      onChanged: (value) {
                        ref.read(chekcBoxValueProvider.notifier).state = !checkbox;
                      },
                    ),
                    normalT("Remember me"),
                  ],
                ),
                Align(
                    alignment: Alignment.center,
                    child: normalBtn(
                        tap: () async {
                          try {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
                            await LocalStorage().savetoken(key: 'email', token: email.text);
                            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.appNavigationScreen);
                          } on FirebaseAuthException catch (e) {
                            log(e.message.toString());
                            showsnackBar(
                              context: context,
                              text: "Invalid Crediental",
                            );
                          }
                        },
                        text: "Login")),
                GestureDetector(
                    onTap: () {
                      NavigatorService.pushNamed(AppRoutes.createAccountScreen);
                    },
                    child: normalT("Not  a member?  Sign Up")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
