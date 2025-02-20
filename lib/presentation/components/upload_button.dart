import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ethabah/core/constants/app_theme.dart';

class UploadButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const UploadButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                label,
                style: kTextFieldTitleStyle.copyWith(color: kWhiteColor),
              ),
              smallWidth(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
