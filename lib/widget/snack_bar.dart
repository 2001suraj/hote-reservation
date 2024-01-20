import 'package:flutter/material.dart';
import 'package:hotel_reservation_app/theme/color.dart';
import 'package:hotel_reservation_app/widget/text.dart';

showsnackBar({
  required BuildContext context,
  required String text,
  Color? color,
  double? fsize,
  Widget? icon,
  double? width,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        color: color ?? AppColor().text,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: normalT(text, color: AppColor().primary),
      ),
      // backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
