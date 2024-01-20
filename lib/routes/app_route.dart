import 'package:flutter/material.dart';
import 'package:hotel_reservation_app/core/model/hotel_model.dart';
import 'package:hotel_reservation_app/presentations/booking_listview/add_hotel_screen.dart';
import 'package:hotel_reservation_app/presentations/booking_listview/booking_listview_screen.dart';
import 'package:hotel_reservation_app/presentations/create_account/create_account_screen.dart';
import 'package:hotel_reservation_app/presentations/first_page/first_page.dart';
import 'package:hotel_reservation_app/presentations/first_page/login/auth_screen.dart';
import 'package:hotel_reservation_app/presentations/first_page/login/login_page.dart';
import 'package:hotel_reservation_app/presentations/hotel_booking_scren.dart/hotel_booking_screen.dart';
import 'package:hotel_reservation_app/presentations/hotel_detail_view/hotel_detail_view_screen.dart';
import 'package:hotel_reservation_app/presentations/navigation_screen/app_navigation_screen.dart';
import 'package:hotel_reservation_app/presentations/profile/profile_screen.dart';


class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String stPageScreen = '/st_page_screen';

  static const String createAccountScreen = '/create_account_screen';

  static const String homePage = '/home_page';

  static const String homePageContainerScreen = '/home_page_container_screen';

  static const String hotelDetailsViewScreen = '/hotel_details_view_screen';



  static const String hotelBookingScreen = '/hotel_booking_screen';

  static const String bookingListviewScreen = '/booking_listview_screen';

  static const String afterTheBookingCancelationScreen = '/after_the_booking_cancelation_screen';

  static const String myProfilePageScreen = '/my_profile_page_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';
  static const String addhotelScreen = 'add hotel_Screen';

    static MaterialPageRoute hotelDetailsViewPageRoute(HotelModel argument) {
    return MaterialPageRoute(
      builder: (context) => HotelDetailsViewScreen(model: argument),
    );
  }
    static MaterialPageRoute hotelBoookingViewPageRoute(HotelModel argument) {
    return MaterialPageRoute(
      builder: (context) => HotelBookingScreen(model: argument),
    );
  }



  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    stPageScreen: (context) => StPageScreen(),
    createAccountScreen: (context) => CreateAccountScreen(),




    bookingListviewScreen: (context) => BookingListviewScreen(),

    myProfilePageScreen: (context) => MyProfilePageScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    addhotelScreen: (context) => AddHotelPage(),
    initialRoute: (context) => AuthScreen(),
  };
}
