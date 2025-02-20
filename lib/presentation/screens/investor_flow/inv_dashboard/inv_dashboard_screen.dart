import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/presentation/screens/company_flow/home/home_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/all_investmentfund/all_investment_fund_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/inv_home_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/invstor_profile/investor_profile.dart';
import 'package:ethabah/presentation/screens/investor_flow/project_update/project_update_screen.dart';
import 'package:ethabah/presentation/screens/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ethabah/core/constants/app_theme.dart';

class InvDashboardScreen extends StatelessWidget {
  const InvDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());
    final catInj = Get.put(CategoriesController(), permanent: true);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Obx(() {
          switch (controller.selectedIndex.value) {
            case 0:
            //   return const InvHomeScreen();
            // case 1:
            //   return const AllInvestmentFundScreen();
              return const AllInvestmentFundScreen();
            case 1:
              return const MyInvestments();
            case 2:
              return const WalletScreen();
            case 3:
              return const InvProfileScreen();
            default:
              return const Text('Dashboard');
          }
        }),
      ),
      bottomNavigationBar: Obx(() => Container(
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Theme(
              data: ThemeData(
                // canvasColor: kPrimaryColor,
                canvasColor: kWhiteColor,

                splashColor: kNeonColor.withOpacity(0.1),
                highlightColor: kBlackColor,
                shadowColor: kBlackColor,
              ),
              child: BottomNavigationBar(
                selectedLabelStyle: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: kFontFamily,
                ),
                unselectedLabelStyle: TextStyle(

                  fontSize: 8.sp,
                  fontWeight: FontWeight.w300,
                  fontFamily: kFontFamily,
                ),
                type: BottomNavigationBarType.shifting,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: controller.selectedIndex.value,
                onTap: (index) => controller.changeIndex(index),
                // selectedItemColor: kNeonColor,
                // unselectedItemColor: kWhiteColor,
                selectedItemColor: kPrimaryColor,
                unselectedItemColor: kSecondaryColor,
                items:  [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined),
                    activeIcon: Icon(Icons.dashboard),
                    label: StringConstants.dashboard,
                  ),
                  //Investment Funds
                  BottomNavigationBarItem(
                    icon: Icon(Icons.attach_money),
                    activeIcon: Icon(Icons.attach_money),
                    label: StringConstants.myInvestments,
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.update),
                    activeIcon: Icon(Icons.wallet),
                    label: StringConstants.myWallet,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: StringConstants.profile,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
