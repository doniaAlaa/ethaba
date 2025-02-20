import 'dart:developer';

import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/main.dart';
import 'package:ethabah/models/User_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat(reverse: false);
  late final Animation<double> _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

  @override
  void initState() {
    super.initState();
    checkExistance();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  checkExistance() async {
    await Future.delayed(const Duration(seconds: 3));
    _controller.dispose();


    final User? user = await SharedPref.getUser();
    print(user?.bank_account);
    print('kkkkkkkkkkkkkkkkkkkkkkkkkkk');
    if (user != null){
      if (user.role == 0) {
            //investor
            Get.offAllNamed(RoutesConstants.investorDashboard);
          } else if (user.role == 2) {
            //company
            Get.offAllNamed(RoutesConstants.dashboard);
          }
      // Get.offAllNamed(RoutesConstants.investorDashboard);
    }else{
      Get.offAllNamed(RoutesConstants.allInvestmentFundScreen);

      // if (user?.role == 0) {
      //   Get.offAllNamed(RoutesConstants.allInvestmentFundScreen);
      // } else if (user?.role == 2) {
      //   Get.offAllNamed(RoutesConstants.companyRequestsScreen);
      // }
    }
    // log(user?.role.toString() ?? "No user found");
    // if (user != null) {
    //   if (user.role == 0) {
    //     Get.offAllNamed(RoutesConstants.investorDashboard);
    //   } else if (user.role == 2) {
    //     Get.offAllNamed(RoutesConstants.dashboard);
    //   } else {
    //     Get.offAllNamed(RoutesConstants.authOnboard);
    //   }
    // } else {
    //   Get.offAllNamed(RoutesConstants.authOnboard);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: const BoxDecoration(
        gradient: kSplashScreenGradient,
      ),
      child: Center(
        child: FadeTransition(
          opacity: _animation,
          child:
          Image.asset(kSplashLogo,
              height: 0.4.sh,
              width: 0.6.sw,
              // fit: BoxFit.contain,
              filterQuality: FilterQuality.high),
        ),
      ),
    );
  }
}
