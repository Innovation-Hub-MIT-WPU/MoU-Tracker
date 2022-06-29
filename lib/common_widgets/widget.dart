// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:MouTracker/common_utils/utils.dart';
import 'package:flutter/material.dart';


Widget formElement(String text, String hintText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
      ),
      SizedBox(height: kFormSpacing / 2),
      TextFormField(
        onChanged: (val) {},
        cursorColor: AppColors.buttonYellow,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: kBorderWidth)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.buttonYellow, width: kBorderWidth),
          ),
        ),
      ),
    ],
  );
}