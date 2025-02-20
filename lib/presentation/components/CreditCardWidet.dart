import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ethabah/core/constants/app_theme.dart';

class CreditCardWidget extends StatelessWidget {
  final String cardName;
  final String cardNumber;
  final String expiryDate;
  final String cardLogo;

  const CreditCardWidget({
    Key? key,
    required this.cardName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardLogo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 0.23.sh,
          width: 0.95.sw,
          decoration: BoxDecoration(
            gradient: kCreditCardGradient,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: 0.05.sh,
          left: 0.05.sw,
          child: Text(
            cardName,
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: kFontFamily,
            ),
          ),
        ),
        Positioned(
          bottom: 0.03.sh,
          left: 0.05.sw,
          child: Text(
            cardNumber,
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              fontFamily: kFontFamily,
            ),
          ),
        ),
        Positioned(
          bottom: 0.03.sh,
          right: 0.1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expiryDate,
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: kFontFamily,
                ),
              ),
              Text(
                "Valid Thru",
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: kFontFamily,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0.05.sh,
          right: 0.05.sw,
          child: Image.asset(
            cardLogo,
            // height: 0.05.sh,
          ),
        ),
      ],
    );
  }
}
