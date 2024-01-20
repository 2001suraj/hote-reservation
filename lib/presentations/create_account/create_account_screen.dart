import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

import '../../widget/text_field.dart';

class CreateAccountScreen extends ConsumerWidget {
  CreateAccountScreen({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();

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
                normalT("Create Account", size: 25, weight: FontWeight.w700),
                normalT("Start booking with creating account", size: 19, weight: FontWeight.w500),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 28.0),
                  child: Divider(),
                ),
                NormalTextField(
                  text: "Full Name",
                  icon: Icons.person,
                  controller: name,
                ),
                NormalTextField(
                  text: "Valid email",
                  icon: Icons.mail,
                  controller: email,
                ),
                NormalTextField(
                  text: "Phone number",
                  icon: Icons.phone,
                  controller: phone,
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
                    SizedBox(width: 250, child: normalT("By checking the box you agree to our Terms and Conditions.", size: 12, line: 2)),
                  ],
                ),
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        normalBtn(
                            tap: () async {
                              try {
                                FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                                FirebaseAuth auth = FirebaseAuth.instance;

                                await firebaseFirestore.collection('user').doc(email.text).set(
                                  {"name": name.text, "email": email.text, "phone": phone.text, "booked_list": []},
                                );
                                await auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
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
                            text: "Create Account"),
                        GestureDetector(
                            onTap: () {
                              NavigatorService.pushNamed(AppRoutes.loginScreen);
                            },
                            child: normalT("Already a member?  Log In")),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
