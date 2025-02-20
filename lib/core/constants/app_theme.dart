import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//font family
const kFontFamily = 'Inter';

const kPrimaryColor = Color(0xFF178B7B);
const kDarkPrimaryColor = Color(0xFF40A168);
const kSecondaryColor = Color(0xFF1B4C43);
const kNeonColor = Color(0xFFC7E92B);
const kOrangeColor = Color(0xFFF78819);
const kBlackColor = Color(0xFF000000);
const kWhiteColor = Color(0xFFFFFFFF);
const kGreyColor = Color(0xFF515978);

//Textfield fill Color
const kTextFieldFillColor = Color(0xFFB4D7C3);
//hint text color
const kHintTextColor = Color(0xFF475569);

//Star Color
const kStarColor = Color(0xFFF0B033);

//Screen Backgroud
const kBackgroundColor = Color(0xFFF7F7E2);

//Divider Color
const kDividerColor = Color(0xFFECEDF2);

const kIconBorderColor = Color(0xFFECEDF2);

//Icon Container Border Color
const kIconContainerBorderColor = Color(0xFFECEDF2);

//Gradient Color

//Gradient for credit card (Liner 3360BB , 5BCDDA top left to bottom right)
const kCreditCardGradient = LinearGradient(
  colors: [Color(0xFF3360BB), Color(0xFF5BCDDA)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

//Gradient for Splash Screen center top to bottom center Liner 1D3E37,1D3E37,178B7B
const kSplashScreenGradient = LinearGradient(
  colors: [
    Color(0xFF1D3E37),
    Color(0xFF178B7B),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

//TextStyle

TextStyle kHeadingTextStyle = TextStyle(
  fontSize: 24.sp,
  color: kBlackColor,
  fontFamily: kFontFamily,
  fontWeight: FontWeight.bold,
);

TextStyle kTextFieldTitleStyle = TextStyle(
    fontSize: 14.sp,
    color: kBlackColor,
    fontFamily: kFontFamily,
    fontWeight: FontWeight.bold);

//button text style
TextStyle kButtonTextStyle = TextStyle(
  fontSize: 14.sp,
  fontFamily: kFontFamily,
  //medium
  fontWeight: FontWeight.w500,
);

TextStyle kHintTextStyle = TextStyle(
  fontSize: 14.sp,
  color: kHintTextColor,
  fontFamily: kFontFamily,
  fontWeight: FontWeight.w300,
);

TextStyle kErrorTextStyle = TextStyle(
  fontSize: 14.sp,
  color: Colors.red,
  fontFamily: kFontFamily,
  fontWeight: FontWeight.w300,
);

TextStyle kSubHeadingTextStyle = TextStyle(
  fontSize: 18.sp,
  color: kBlackColor,
  fontFamily: kFontFamily,
  fontWeight: FontWeight.bold,
);

TextStyle kSubtitleTextStyle = TextStyle(
  fontSize: 14.sp,
  color: kBlackColor,
  fontFamily: kFontFamily,
  fontWeight: FontWeight.w500,
);

TextStyle mediumTextStyle = TextStyle(
  color: kWhiteColor,
  fontFamily: kFontFamily,
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
);

TextStyle ksmallGreyHeadingTextStyle = TextStyle(
  color: kGreyColor,
  fontFamily: kFontFamily,
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
);

TextStyle ksmallHeadTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  fontFamily: kFontFamily,
);
TextStyle ksmallDescTextStyle = TextStyle(
  color: const Color(0xFF72737A),
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  fontFamily: kFontFamily,
);
