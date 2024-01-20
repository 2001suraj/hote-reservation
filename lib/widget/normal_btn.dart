import 'package:flutter/material.dart';
import 'package:hotel_reservation_app/theme/color.dart';
import 'package:hotel_reservation_app/widget/text.dart';

Padding normalBtn({required void Function()? tap, required String text}) {
  return Padding(
    padding: const EdgeInsets.all(28.0),
    child: MaterialButton(
      onPressed: tap,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      color: AppColor().text,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: normalT(text, size: 30, weight: FontWeight.w700, color: AppColor().primary),
    ),
  );
}
