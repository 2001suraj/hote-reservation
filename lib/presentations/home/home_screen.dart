import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/core/model/hotel_model.dart';
import 'package:hotel_reservation_app/core/utils/data/local_storage.dart';
import 'package:hotel_reservation_app/core/utils/navigator_service.dart';
import 'package:hotel_reservation_app/provider/base_provider.dart';
import 'package:hotel_reservation_app/provider/hotel_provider.dart';
import 'package:hotel_reservation_app/provider/user_provider.dart';
import 'package:hotel_reservation_app/routes/app_route.dart';
import 'package:hotel_reservation_app/theme/color.dart';
import 'package:hotel_reservation_app/widget/text.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor().primary,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: LocalStorage().gettoken(value: "email"),
            builder: (context, snap) {
              final email = snap.data.toString();
              final userData = ref.watch(userIndividualDataProvider(email));
              final hotelData = ref.watch(hotelDataProvider);
              final search = ref.watch(searchTextProvider);

              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/images/user.png"),
                        ),
                        SizedBox(
                          width: 200,
                          child: userData.when(
                            data: (data) {
                              return normalT("    Hi , ${data['name']}", weight: FontWeight.w500);
                            },
                            error: (e, r) => Text(e.toString()),
                            loading: () => const SizedBox.shrink(),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (value) {
                          ref.read(searchTextProvider.notifier).state = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: MaterialButton(
                            onPressed: () {},
                            child: Image(color: AppColor().primary, image: const AssetImage('assets/images/setting.png')),
                          ),
                          hintText: 'Search',
                          fillColor: AppColor().text,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    normalT("Nearby hotels"),
                    SizedBox(
                      height: 500,
                      child: hotelData.when(
                          data: (data) {
                            List filteredDocs =
                                data.docs.where((doc) => doc['name'].toString().toLowerCase().contains(search.toLowerCase())).toList();
                            return ListView.builder(
                                itemCount: filteredDocs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        AppRoutes.hotelDetailsViewPageRoute(HotelModel(
                                            name: filteredDocs[index]['name'],
                                            image: filteredDocs[index]['image'],
                                            rating: filteredDocs[index]['rating'],
                                            price: filteredDocs[index]['price'],
                                            location: filteredDocs[index]['address'],
                                            description: filteredDocs[index]['description'],
                                            photo: filteredDocs[index]['photo'])),
                                      );
                                    },
                                    child: individualHotelContainer(
                                      title: filteredDocs[index]['name'],
                                      image: filteredDocs[index]['image'],
                                      rating: filteredDocs[index]['rating'],
                                      price: filteredDocs[index]['price'],
                                      location: filteredDocs[index]['address'],
                                    ),
                                  );
                                });
                          },
                          error: (e, r) => Text(e.toString()),
                          loading: () => const SizedBox.shrink()),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

Container individualHotelContainer(
    {required String image, required String title, required String location, required String rating, required String price, bool? showPrice}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: AppColor().bg1,
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: NetworkImage(image),
            height: 90,
            width: 90,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: showPrice == false ? 200 : 145,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              normalT(title, size: 14, weight: FontWeight.w700),
              normalT(location, size: 11, weight: FontWeight.w400),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  normalT(rating, size: 11, weight: FontWeight.w600, color: AppColor().teal),
                  normalT(
                    "  (4,345 reviews)",
                    size: 11,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ),
        showPrice == false
            ? SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 50, child: normalT("Rs $price", size: 12, weight: FontWeight.w500, color: AppColor().teal)),
                  SizedBox(width: 50, child: normalT("/night", size: 10)),
                  TextButton(
                      onPressed: () {},
                      child: normalT(
                        "View",
                        size: 14,
                        decotation: TextDecoration.underline,
                      )),
                ],
              )
      ],
    ),
  );
}
