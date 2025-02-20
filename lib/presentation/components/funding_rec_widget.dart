import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/constants/app_strings.dart';

class FundingRecievedWidget extends StatelessWidget {
  final double amount;
  final double? width;

  const FundingRecievedWidget({
    Key? key,
    required this.amount,
    this.width,
  }) : super(key: key);

  String formatAmount(double amount) {
    if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? null,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: kDarkPrimaryColor,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConstants.fundingCollected,
            style: kSubtitleTextStyle.copyWith(
              color: kNeonColor,
              fontSize: 14.sp,
            ),
          ),
          Text(
            "SR ${formatAmount(amount)}",
            style: kSubtitleTextStyle.copyWith(
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
