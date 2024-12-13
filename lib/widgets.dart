import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget textfeld({
  required TextInputType keyboardType,
  required String hintTexts,
}) {
  return Container(
    margin: EdgeInsets.only(left: 2.0.w, right: 2.0.w),
    child: TextFormField(
        keyboardType: keyboardType,
        readOnly: true,
      decoration: InputDecoration(
        constraints: BoxConstraints(maxHeight: 8.h,maxWidth: 85.w),
        contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        hintText: hintTexts,
        hintStyle: TextStyle(
          color: Colors.black, // Set your desired hint text color here
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white),
        )
      ),
    ),
  );
}
