// ignore_for_file: must_be_immutable

import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomCompleteInputfield extends StatelessWidget {
  final Widget textfiledTitle;
  final Widget textField;
  final RxString? errorText;
  const CustomCompleteInputfield(
      {super.key,
      required this.textfiledTitle,
      required this.textField,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 7.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          textfiledTitle,
          smallHeight(),
          textField,
          smallHeight(),
          errorText != null
              ? Obx(() => errorText!.value != ""
                  ? Text(
                      errorText!.value,
                      style: kErrorTextStyle,
                    )
                  : const SizedBox())
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
