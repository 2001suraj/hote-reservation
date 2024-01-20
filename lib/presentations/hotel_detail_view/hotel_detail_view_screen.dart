import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/core/model/hotel_model.dart';
import 'package:hotel_reservation_app/provider/base_provider.dart';
import 'package:hotel_reservation_app/routes/app_route.dart';
import 'package:hotel_reservation_app/theme/color.dart';
import 'package:hotel_reservation_app/widget/text.dart';

class HotelDetailsViewScreen extends ConsumerWidget {
  HotelDetailsViewScreen({super.key, required this.model});

  final HotelModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showMore = ref.watch(showMoreProvider);

    final wordCount = RegExp(r'\b\w+\b').allMatches(model.description ?? 'NA').length;
    final displayedText = ref.read(showMoreProvider) ? (model.description ?? 'NA') : (model.description ?? 'NA').split(' ').take(30).join(' ');
    return Scaffold(
      backgroundColor: AppColor().primary,
      appBar: AppBar(
        backgroundColor: AppColor().primary,
        title: normalT(model.name ?? 'NA'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  height: 169,
                  width: double.infinity,
                  image: NetworkImage(model.image ?? 'NA'),
                  fit: BoxFit.cover,
                ),
              ),
              normalT(
                model.name ?? 'NA',
                weight: FontWeight.w700,
                size: 31,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 38.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColor().teal,
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      width: 250,
                      child: normalT(
                        model.location ?? 'NA',
                        weight: FontWeight.w500,
                        line: 3,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              normalT(
                'Description',
                weight: FontWeight.w600,
                size: 20,
              ),
              Text(
                displayedText,
                style: TextStyle(color: AppColor().text1, fontSize: 14, fontWeight: FontWeight.w400),
              ),
              if (wordCount > 50)
                TextButton(
                  onPressed: () {
                    log(ref.read(showMoreProvider).toString());
                    ref.read(showMoreProvider.notifier).state = !showMore;
                  },
                  child: normalT(showMore ? 'Show Less' : 'Read More', color: AppColor().primary),
                ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                normalT(
                  'Gallery Photos',
                  weight: FontWeight.w700,
                  size: 19,
                ),
                GestureDetector(onTap: () {}, child: normalT('See All', weight: FontWeight.w700, size: 19, color: AppColor().primary)),
              ]),
              SizedBox(
                // height: 107,
                width: double.infinity,
                child: GridView.builder(
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: model.photo?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(image: NetworkImage(model.photo?[index]), fit: BoxFit.cover),
                          color: AppColor().text1,
                        ),
                        width: 135,
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  normalT("Rs ${model.price}", size: 18, weight: FontWeight.w700, color: AppColor().teal),
                  normalT(
                    " /hour",
                    size: 11,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
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
                    Navigator.push(context, AppRoutes.hotelBoookingViewPageRoute(model));
                  },
                  child: normalT(
                    "Book Now!",
                    color: AppColor().text,
                    size: 17,
                    weight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
