import 'package:ecommerce_mobile_app/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
Widget custom_taxtField({String? title,String? hint , controller , }){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(blueColor).fontFamily("semibold").size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: "semibold",
            color: textfieldGrey
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: blueColor)),
        ),
      )
    ],
  );
}