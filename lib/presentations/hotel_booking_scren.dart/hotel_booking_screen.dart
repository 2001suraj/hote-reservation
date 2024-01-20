import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/core/model/hotel_model.dart';
import 'package:hotel_reservation_app/core/service/hotel_service.dart';
import 'package:hotel_reservation_app/presentations/home/home_screen.dart';
import 'package:hotel_reservation_app/provider/base_provider.dart';
import 'package:hotel_reservation_app/routes/app_route.dart';
import 'package:hotel_reservation_app/theme/color.dart';
import 'package:hotel_reservation_app/widget/text.dart';
import 'package:intl/intl.dart';

class HotelBookingScreen extends ConsumerWidget {
  const HotelBookingScreen({super.key, required this.model});
  final HotelModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkInDate = ref.watch(checkInDateProvider);
    final checkOutDate = ref.watch(checkOutDateProvider);
    String checkINformattedDate = ref.watch(checkInformattedDateProvider);
    String checkOutformattedDate = ref.watch(checkOutformattedDateProvider);
    int person = ref.watch(personNumberProvider);

    return Scaffold(
      backgroundColor: AppColor().primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColor().text,
                      ),
                    ),
                    normalT("Booking Screen")
                  ],
                ),
              ),
              individualHotelContainer(
                  image: model.image ?? 'Na',
                  title: model.name ?? 'Na',
                  location: model.location ?? "Na",
                  rating: model.rating ?? 'NA',
                  price: model.price ?? "Na",
                  showPrice: false),
              Container(
                height: 130,
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor().bg1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    normalT(
                      "Check in",
                      size: 17,
                      weight: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        normalT(
                          checkINformattedDate,
                          size: 15,
                          weight: FontWeight.w600,
                        ),
                        IconButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: checkInDate,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2025),
                              );
                              if (picked != null && picked != checkInDate) {
                                ref.read(checkInDateProvider.notifier).state == picked;
                                ref.read(checkInformattedDateProvider.notifier).state = DateFormat('MMM dd yyyy').format(picked);
                              }
                              log(checkInDate.toString());
                            },
                            icon: Icon(
                              Icons.calendar_month,
                              color: AppColor().teal,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 130,
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor().bg1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    normalT(
                      "Check Out",
                      size: 17,
                      weight: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        normalT(
                          checkOutformattedDate,
                          size: 15,
                          weight: FontWeight.w600,
                        ),
                        IconButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: checkOutDate,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2025),
                              );
                              if (picked != null && picked != checkOutDate) {
                                ref.read(checkOutDateProvider.notifier).state == picked;
                                ref.read(checkOutformattedDateProvider.notifier).state = DateFormat('MMM dd yyyy').format(picked);
                              }
                              log(checkOutDate.toString());
                            },
                            icon: Icon(
                              Icons.calendar_month,
                              color: AppColor().teal,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 130,
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor().bg1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    normalT(
                      "Guest",
                      size: 17,
                      weight: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            padding: EdgeInsets.only(bottom: 20),
                            onPressed: () async {
                              if (person > 0) {
                                ref.read(personNumberProvider.notifier).state -= 1;
                              }
                            },
                            icon: Icon(
                              Icons.minimize,
                              color: AppColor().teal,
                            )),
                        normalT(
                          person.toString(),
                          size: 15,
                          weight: FontWeight.w600,
                        ),
                        IconButton(
                          onPressed: () async {
                            ref.read(personNumberProvider.notifier).state += 1;
                          },
                          icon: Icon(
                            Icons.add,
                            color: AppColor().teal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              normalT("Total: Rs ${person * int.parse(model.price ?? 'NA')}", color: AppColor().text, weight: FontWeight.w700),
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  height: 47,
                  minWidth: 214,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: AppColor().black,
                  onPressed: () {
                    final booking = HotelModel(
                      name: model.name,
                      image: model.image,
                      price: (person * int.parse(model.price ?? 'NA')).toString(),
                      location: model.location,
                      rating: model.rating,
                      description: model.description,
                      photo: model.photo,
                      person: person.toString(),
                      status: 'Booked',
                      checkin: checkINformattedDate.toString(),
                      checkout: checkOutformattedDate.toString(),
                    );
                    HotelFirebase().book(booking);
                    ref.read(currentPageIndexProvider.notifier).state = 1;
                    Navigator.pushReplacementNamed(context, AppRoutes.appNavigationScreen);
                  },
                  child: normalT(
                    "Book Now!",
                    color: AppColor().text,
                    size: 17,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
