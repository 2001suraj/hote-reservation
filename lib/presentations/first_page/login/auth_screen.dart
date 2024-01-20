import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/presentations/first_page/first_page.dart';
import 'package:hotel_reservation_app/presentations/home/home_screen.dart';
import 'package:hotel_reservation_app/presentations/navigation_screen/app_navigation_screen.dart';

class AuthScreen extends ConsumerWidget {
  AuthScreen({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (auth.currentUser != null) {
      return AppNavigationScreen();
    }
    return StPageScreen();
  }
}
