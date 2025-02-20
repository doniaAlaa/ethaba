import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/constants/app_strings.dart';

class FundingRequiredWidget extends StatelessWidget {
  final String amount;
  final double? width;

  const FundingRequiredWidget({
    Key? key,
    required this.amount,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? null,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "SAR",
                style: kSubtitleTextStyle.copyWith(
                  color: kWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              )),
          SizedBox(
            width: 5.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConstants.fundingRequired,
                style: kSubtitleTextStyle.copyWith(
                  color: kNeonColor,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                "SR $amount",
                style: kSubtitleTextStyle.copyWith(
                  color: kWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
