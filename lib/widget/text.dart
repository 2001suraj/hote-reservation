import 'package:flutter/material.dart';
import 'package:hotel_reservation_app/theme/color.dart';

Text normalT(String? text, {double? size, Color? color, FontWeight? weight, TextDecoration? decotation, int? line}) {
  return Text(
    text ?? 'NA',
    maxLines: line ?? 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: size ?? 16,
      fontWeight: weight ?? FontWeight.w400,
      color: color ?? AppColor().text,
      height: 2,
      decoration: decotation ?? TextDecoration.none,
      decorationColor: AppColor().text,
    ),
  );
}
