//all spacing values are in pixels using screen utls

// SizedBox helpers
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double extraSmall = 2.0;
const double small = 5.0;
const double medium = 10.0;
const double large = 16.0;
const double extraLarge = 22.0;

SizedBox extraSmallHeight() {
  return SizedBox(height: extraSmall.h);
}

smallHeight() => SizedBox(height: small.h);

mediumHeight() => SizedBox(height: medium.h);

largeHeight() => SizedBox(height: large.h);

extraLargeHeight() => SizedBox(height: extraLarge.h);

extraSmallWidth() => SizedBox(width: extraSmall.w);

smallWidth() => SizedBox(width: small.w);

mediumWidth() => SizedBox(width: medium.w);

largeWidth() => SizedBox(width: large.w);

extraLargeWidth() => SizedBox(width: extraLarge.w);

// // Vertical Spacing
// const double verticalSpaceSmall = 5.0;
// const double verticalSpaceMedium = 10.0;
// const double verticalSpaceLarge = 15.0;
// const double verticalSpaceExtraLarge = 20.0;

// SizedBox verticalSpaceSmallHeight() {
//   return SizedBox(height: verticalSpaceSmall.h);
// }
