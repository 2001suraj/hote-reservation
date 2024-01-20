import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/core/model/hotel_model.dart';
import 'package:hotel_reservation_app/core/service/hotel_service.dart';
import 'package:hotel_reservation_app/core/utils/navigator_service.dart';
import 'package:hotel_reservation_app/provider/base_provider.dart';

import 'package:hotel_reservation_app/provider/hotel_provider.dart';
import 'package:hotel_reservation_app/routes/app_route.dart';
import 'package:hotel_reservation_app/theme/color.dart';
import 'package:hotel_reservation_app/widget/text.dart';

class BookingListviewScreen extends ConsumerWidget {
  static const String routeName = 'BookingListviewScreen';
  const BookingListviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingData = ref.watch(bookingDataProvider);
    return Scaffold(
      backgroundColor: AppColor().primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    normalT("My Booking"),
                    IconButton(
                      onPressed: () {
                        NavigatorService.pushNamed(AppRoutes.addhotelScreen);
                      },
                      icon: Icon(
                        Icons.add,
                        color: AppColor().teal,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.75,
                child: bookingData.when(
                    data: (data) {
                      return ListView.builder(
                          itemCount: data.docs.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: AppColor().bg1),
                                child: Column(
                                  children: [
                                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18.0, right: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image(
                                            height: 85,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(data.docs[index]['image']),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 10, top: 10),
                                        width: 230,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            normalT(
                                              data.docs[index]['name'],
                                              size: 14,
                                              weight: FontWeight.w700,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 15,
                                                  color: AppColor().text,
                                                ),
                                                SizedBox(
                                                  width: 180,
                                                  child: normalT(
                                                    data.docs[index]['address'],
                                                    size: 14,
                                                    weight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            normalT(
                                              "${data.docs[index]['checkin']} - ${data.docs[index]['checkout']}",
                                              size: 14,
                                              weight: FontWeight.w400,
                                            ),
                                            normalT('Rs.${data.docs[index]['price']}', size: 14, weight: FontWeight.w400, color: AppColor().teal),
                                            MaterialButton(
                                              height: 21,
                                              minWidth: 70,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              color: data.docs[index]['status'].toString().toLowerCase() == ("Booked".toLowerCase())
                                                  ? AppColor().black
                                                  : AppColor().bgRedColor,
                                              onPressed: () {},
                                              child: normalT(
                                                data.docs[index]['status'],
                                                weight: FontWeight.w400,
                                                size: 11,
                                                color: data.docs[index]['status'].toString().toLowerCase() == ("Booked".toLowerCase())
                                                    ? AppColor().teal
                                                    : AppColor().red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                                      child: Divider(),
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: data.docs[index]['status'].toString().toLowerCase() == ("Booked").toLowerCase()
                                                ? AppColor().text
                                                : AppColor().red),
                                      ),
                                      onPressed: () {
                                        if (data.docs[index]['status'].toString().toLowerCase() == ("Booked").toLowerCase()) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  surfaceTintColor: AppColor().text,
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      normalT("Cancel Booking", color: AppColor().red, size: 22, weight: FontWeight.w700),
                                                      normalT(
                                                        "Are you sure you want to cancel your booking?",
                                                        size: 14,
                                                        weight: FontWeight.w500,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          MaterialButton(
                                                            height: 42,
                                                            minWidth: 120,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                                            color: AppColor().bg1,
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: normalT("Cancel", color: AppColor().text, size: 13),
                                                          ),
                                                          MaterialButton(
                                                            height: 42,
                                                            minWidth: 120,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                                            color: AppColor().primary,
                                                            onPressed: () {
                                                              HotelFirebase().update(
                                                                  HotelModel(
                                                                    name: data.docs[index]['name'],
                                                                    image: data.docs[index]['image'],
                                                                    price: data.docs[index]['price'],
                                                                    location: data.docs[index]['address'],
                                                                    rating: data.docs[index]['rating'],
                                                                    description: data.docs[index]['description'],
                                                                    photo: data.docs[index]['photo'],
                                                                    person: data.docs[index]['person'],
                                                                    status: 'Cancel',
                                                                    checkin: data.docs[index]['checkin'],
                                                                    checkout: data.docs[index]['checkout'],
                                                                  ),
                                                                  data.docs[index].id);
                                                              Navigator.pop(context);
                                                              ref.read(currentPageIndexProvider.notifier).state == 0;
                                                            },
                                                            child: normalT("Yes, Continue", color: AppColor().teal, size: 13),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        }
                                        if (data.docs[index]['status'].toString().toLowerCase() == ("Cancel").toLowerCase()) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  surfaceTintColor: AppColor().text,
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      normalT("Delete Booking", color: AppColor().red, size: 22, weight: FontWeight.w700),
                                                      normalT(
                                                        "Are you sure you want to Delete your booking?",
                                                        size: 14,
                                                        weight: FontWeight.w500,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          MaterialButton(
                                                            height: 42,
                                                            minWidth: 120,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                                            color: AppColor().bg1,
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: normalT("Cancel", color: AppColor().text, size: 13),
                                                          ),
                                                          MaterialButton(
                                                            height: 42,
                                                            minWidth: 120,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                                            color: AppColor().primary,
                                                            onPressed: () {
                                                              HotelFirebase().delete(data.docs[index].id);
                                                              Navigator.pop(context);
                                                              ref.read(currentPageIndexProvider.notifier).state == 0;
                                                            },
                                                            child: normalT("Yes, Continue", color: AppColor().teal, size: 13),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        }
                                      },
                                      child: normalT(
                                        data.docs[index]['status'].toString().toLowerCase() == ("Booked".toLowerCase())
                                            ? "Cancel Booking"
                                            : "Canceled",
                                        weight: FontWeight.w600,
                                        size: 15,
                                        color: data.docs[index]['status'].toString().toLowerCase() == ("Booked".toLowerCase())
                                            ? AppColor().teal
                                            : AppColor().red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    error: (e, r) => Text(e.toString()),
                    loading: () => const Center(child: SizedBox.shrink())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
