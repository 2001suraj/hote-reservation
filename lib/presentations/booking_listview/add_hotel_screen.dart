import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_reservation_app/core/model/hotel_model.dart';
import 'package:hotel_reservation_app/core/service/hotel_service.dart';
import 'package:hotel_reservation_app/core/service/image_store.dart';
import 'package:hotel_reservation_app/core/utils/navigator_service.dart';

import 'package:hotel_reservation_app/provider/base_provider.dart';
import 'package:hotel_reservation_app/routes/app_route.dart';
import 'package:hotel_reservation_app/theme/color.dart';
import 'package:hotel_reservation_app/widget/text.dart';
import 'package:hotel_reservation_app/widget/text_field.dart';
import 'package:image_picker/image_picker.dart';

class AddHotelPage extends ConsumerStatefulWidget {
  const AddHotelPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddHotelPageState();
}

class _AddHotelPageState extends ConsumerState<AddHotelPage> {
  XFile? image;
  List<XFile>? photos;
  final TextEditingController title = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController des = TextEditingController();

  final TextEditingController rating = TextEditingController();
  Future<void> pickImage() async {
    var media = ImagePicker();
    final List<XFile> pickedMedia = await media.pickMultipleMedia();

    setState(() {
      photos = pickedMedia;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: AppColor().primary,
              onPressed: () async {
                List<File> photoList = photos?.map((xFile) => File(xFile.path)).toList() ?? [];

                await HotelFirebase().add(
                  HotelModel(
                    name: title.text,
                    location: location.text,
                    person: '',
                    rating: rating.text,
                    price: price.text,
                    description: des.text,
                  ),
                );
                var photo = File(image!.path);
                await IamgeStorage().storeImage(photo: photo, name: title.text);
                await IamgeStorage().addPhotos(photos: photoList, name: title.text);
                ref.read(currentPageIndexProvider.notifier).state = 0;
                NavigatorService.pushNamedAndRemoveUntil(AppRoutes.appNavigationScreen);
              },
              child: normalT("add", color: AppColor().text),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                image == null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.grey, image: DecorationImage(image: AssetImage('assets/images/room1.png'), fit: BoxFit.cover)),
                      )
                    : Container(
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                Positioned(
                  bottom: 0,
                  right: 80,
                  child: TextButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final img = await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          image = img;
                        });
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Upload a photo',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                          )
                        ],
                      )),
                ),
              ],
            ),
            NormalTextField(
              controller: title,
              text: 'Title',
            ),
            NormalTextField(
              controller: location,
              text: 'location',
            ),
            NormalTextField(
              controller: price,
              text: 'price',
            ),
            NormalTextField(
              controller: des,
              text: 'description',
            ),
            NormalTextField(
              controller: rating,
              text: 'rating',
            ),
            photos == null
                ? const SizedBox.shrink()
                : SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        for (int i = 0; i < photos!.length; i++)
                          Container(
                              width: 120,
                              margin: const EdgeInsets.all(10),
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(photos![i].path),
                                  fit: BoxFit.cover,
                                ),
                              )),
                      ],
                    ),
                  ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: AppColor().primary,
              onPressed: () {
                pickImage();
              },
              child: normalT(
                "Add Images",
              ),
            )
          ],
        ),
      ),
    );
  }
}
