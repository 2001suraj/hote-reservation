import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/core/utils/navigator_service.dart';
import 'package:hotel_reservation_app/routes/app_route.dart';
import 'package:hotel_reservation_app/theme/color.dart';
import 'package:hotel_reservation_app/widget/normal_btn.dart';
import 'package:hotel_reservation_app/widget/text.dart';

class StPageScreen extends ConsumerWidget {
  const StPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor().primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 450,
              width: double.infinity,
              child: const Image(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/1_pg.png',
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -30),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor().primary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                    ),
                    normalT("Plan Your Vacation With", size: 22),
                    normalT("Us", size: 22),
                    normalBtn(
                        tap: () {
                          NavigatorService.pushNamed(AppRoutes.createAccountScreen);
                        },
                        text: "Create Account"),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                        onTap: () {
                          NavigatorService.pushNamed(AppRoutes.loginScreen);
                        },
                        child: normalT("Already have an account", size: 23, weight: FontWeight.w500, color: AppColor().teal)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
