import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnderReviewScreen extends StatefulWidget {
  const UnderReviewScreen({super.key});

  @override
  _UnderReviewScreenState createState() => _UnderReviewScreenState();
}

class _UnderReviewScreenState extends State<UnderReviewScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      Get.offNamed(RoutesConstants.authOnboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              kUnderReviewImage,
            ),
          ),
          mediumHeight(),
          Text(
            StringConstants.underReview,
            style: kHeadingTextStyle.copyWith(color: kNeonColor),
          ),
          largeHeight(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              StringConstants
                  .ourTeamReviewsAndApprovesTheDocumentsToActivateTheAccount,
              style: kSubHeadingTextStyle.copyWith(color: kWhiteColor),
              textAlign: TextAlign.center,
            ),
          ),
          extraLargeHeight(),
          Text(
            StringConstants.itUsuallyTakes2448HoursToReviewTheDocuments,
            style: kSubtitleTextStyle.copyWith(color: kWhiteColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
