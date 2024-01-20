import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/presentations/booking_listview/booking_listview_screen.dart';
import 'package:hotel_reservation_app/presentations/home/home_screen.dart';
import 'package:hotel_reservation_app/presentations/profile/profile_screen.dart';
import 'package:hotel_reservation_app/provider/base_provider.dart';
import 'package:hotel_reservation_app/theme/color.dart';

class AppNavigationScreen extends ConsumerWidget {
  AppNavigationScreen({super.key});

  List<Widget> pages = [HomeScreen(), BookingListviewScreen(), MyProfilePageScreen()];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentPageIndexProvider);
    return Scaffold(
      backgroundColor: AppColor().primary,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          ref.read(currentPageIndexProvider.notifier).state = value;
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Profile'),
        ],
      ),
    );
  }
}
