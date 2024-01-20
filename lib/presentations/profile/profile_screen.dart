import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/core/utils/data/local_storage.dart';
import 'package:hotel_reservation_app/core/utils/navigator_service.dart';
import 'package:hotel_reservation_app/provider/user_provider.dart';
import 'package:hotel_reservation_app/routes/app_route.dart';
import 'package:hotel_reservation_app/theme/color.dart';
import 'package:hotel_reservation_app/widget/text.dart';

class MyProfilePageScreen extends ConsumerWidget {
  const MyProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor().primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
                future: LocalStorage().gettoken(value: 'email'),
                builder: (context, snap) {
                  final email = snap.data.toString();
                  final userData = ref.watch(userIndividualDataProvider(email));
                  return userData.when(
                      data: (value) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Align(alignment: Alignment.centerLeft, child: normalT("Profile", size: 24, weight: FontWeight.w700)),
                              ),
                              const CircleAvatar(
                                radius: 90,
                                backgroundImage: AssetImage('assets/images/user.png'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: normalT(value['name'] ?? "NA", size: 24, weight: FontWeight.w700),
                              ),
                              normalT(value['email'], size: 14, weight: FontWeight.w600),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10, vertical: 20),
                                  child: ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.logout,
                                      color: AppColor().text,
                                    ),
                                    title: SizedBox(width: 200, child: normalT("Log out", color: AppColor().text)),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              surfaceTintColor: AppColor().text,
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  normalT("Log out", color: AppColor().red, size: 22, weight: FontWeight.w700),
                                                  normalT("Are you sure you want to Logout?", size: 14, weight: FontWeight.w500),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: MaterialButton(
                                                          height: 42,
                                                          minWidth: 120,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                                          color: AppColor().primary,
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: normalT("Cancel", color: AppColor().text),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: MaterialButton(
                                                          height: 42,
                                                          minWidth: 120,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                                          color: AppColor().primary,
                                                          onPressed: () async {
                                                            FirebaseAuth auth = FirebaseAuth.instance;
                                                            await LocalStorage().clear(key: 'email');
                                                            await auth.signOut();
                                                            await NavigatorService.pushNamedAndRemoveUntil(AppRoutes.loginScreen);
                                                          },
                                                          child: normalT("Logout", color: AppColor().text),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                  )),
                              const Spacer(),
                              Spacer(),
                              const Spacer(),
                            ],
                          ),
                        );
                      },
                      error: (e, r) => Text(
                            e.toString(),
                          ),
                      loading: () => const Center(child:  SizedBox.shrink()));
                }),
          ),
        ),
      ),
    );
  }
}
