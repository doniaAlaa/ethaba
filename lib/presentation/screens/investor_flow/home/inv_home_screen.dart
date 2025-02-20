import 'dart:developer';

import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/User_model.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/models/req_investment_fund_model.dart';

import 'package:ethabah/presentation/screens/investor_flow/all_investmentfund/investment_fund_item_block.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/inv_home_screen_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/widget/my_investments_data_block.dart';
import 'package:ethabah/presentation/screens/investor_flow/investment_fund_details/investment_details_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/investment_fund_details/investment_fund_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyInvestments extends StatefulWidget {
  const MyInvestments({super.key});

  @override
  State<MyInvestments> createState() => _MyInvestmentsState();
}

class _MyInvestmentsState extends State<MyInvestments> {
   bool isLoggedIn = true;

  @override
  void initState() {
    // Future.delayed( Duration.zero, () async{
    //   final User? user = await SharedPref.getUser();
    //   isLoggedIn = user != null;
    //   print('isLoggedIn$isLoggedIn');
    // });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final User? user = await SharedPref.getUser();
      isLoggedIn = user != null;
      print('isLoggedIn$isLoggedIn');
      setState(() {});
    });

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final User? user = await SharedPref.getUser();
      isLoggedIn = user != null;
      print('isLoggedIn$isLoggedIn');
    });
    final controller = Get.put(InvHomeScreenController(), permanent: true);
    final catController = Get.isRegistered<CategoriesController>()
        ? Get.find<CategoriesController>()
        : Get.put(CategoriesController(), permanent: true);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1D3E37),
              Color(0xFF178B7B),
              Color(0xFF178B7B),
              Color(0xFF178B7B),
              Color(0xFF178B7B),



              // kBackgroundColor,


            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
          )

      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
        Container(
        height:MediaQuery.of(context).size.height*0.32,
        child: Padding(
            padding:  EdgeInsets.only(top: 40.h),
            child: Column(
              children: [
                Text(StringConstants.myInvestments,
                  style: ksmallHeadTextStyle.copyWith(color: kWhiteColor,fontSize: 18,fontWeight: FontWeight.w800),),
                SizedBox(height: 24.h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Obx((){
                        return    MyInvestmentsDataBlock(title: '${controller.allPaid.value}'+' '+'ر.س', subTitle: StringConstants.totalInvestments, itemIcon: Icons.inventory_sharp,);

                      }),
                      SizedBox(width: 10.h,),
                      MyInvestmentsDataBlock(title: '${controller.numOfBoxes.value}', subTitle:StringConstants.totalBoxes, itemIcon: Icons.layers,),
                    ],
                  ),
                ),
                SizedBox(height: 8.h,),
                Obx((){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        MyInvestmentsDataBlock(title: '${controller.allReceived.value}'+' '+'ر.س', subTitle: StringConstants.returns, itemIcon: Icons.recycling,),
                        SizedBox(width: 10.h,),
                        MyInvestmentsDataBlock(title: '${controller.totalProfit.value}'+' '+'ر.س', subTitle:StringConstants.dividends, itemIcon: Icons.attach_money_rounded,),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 16.h,),

              ],
            )
        ),
        // color: Colors.red,
      ),
            Expanded(
              child: Container(
                 // height:MediaQuery.of(context).size.height*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  color: kBackgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                       SizedBox(height: 20.h),
                      isLoggedIn?SizedBox():
                      Container(
                       height: 90.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF1D3E37),
                                Color(0xFF178B7B),
                                Color(0xFF178B7B),

                                // kBackgroundColor,


                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            )

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                height: 70,width: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF1D3E37),
                                      Color(0xFF178B7B),
                                      Color(0xFF178B7B),

                                      // kBackgroundColor,


                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                ),
                                child: Image.asset('assets/icons/white_user.png'),
                              ),
                              SizedBox(width: 10.w,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.6,
                                    child: Text(
                                      StringConstants.signInFirst,
                                      style: ksmallGreyHeadingTextStyle.copyWith(
                                          fontWeight: FontWeight.w100,
                                        color: kWhiteColor,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h,),
                                  InkWell(
                                    onTap: () {
                                      Get.offAllNamed(RoutesConstants.authOnboard);


                                    },
                                    child: Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width*0.6,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: kWhiteColor.withOpacity(0.5))
                                      ),
                                      child: Center(
                                        child: Text(
                                          StringConstants.start,
                                          style: ksmallGreyHeadingTextStyle.copyWith(
                                            fontWeight: FontWeight.w100,
                                            color: kWhiteColor,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),

                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            StringConstants.myInvestmentFund,
                            style: kTextFieldTitleStyle.copyWith(
                              fontWeight: FontWeight.w600
                              // fontSize: 16.sp,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      FutureBuilder(
                          future: controller.getRequestedInvestmentFund(),
                          builder: (context, snapshot) {
                            //log('Data: ${snapshot.data}');
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            }
                           if (snapshot.hasError) {
                                                return SizedBox(
                                                  height: 250.h,
                                                  child: Center(
                                                    child: Text(
                                                      StringConstants.somethingWentWrong,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: kPrimaryColor,
                                                          fontSize: 20.sp),
                                                    ),
                                                  ),
                                                );
                                              }
                            if (snapshot.data == [] ||
                                snapshot.data == null ||
                                snapshot.data!.data.isEmpty) {
                              return SizedBox(
                                height: 200.h,
                                child: Center(
                                  child: Text(
                                    StringConstants.noInvestmentFundsAvailble,
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }
                            //log('Data length: ${snapshot.data!.length}');
                            return Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: snapshot.data!.data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  // RequestInvestmentFund fund = snapshot.data![index];
                                  List<RequestInvestmentFund> fund = snapshot.data!.data;

                                  return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                                () =>
                                                InvestmentDetailsScreen(
                                                  investmentFund: fund[index].investmentFund,
                                                  haveDateRange: true,
                                                  allFund: false,

                                                ));
                                      },
                                      child:
                                          InvestmentFundItemBlock(
                                          isLogged: isLoggedIn??false,
                                          fund: fund[index].investmentFund,
                                          )
                                  );
                                },
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatAmount(double amount) {
  if (amount >= 1000) {
    return '${(amount / 1000).toStringAsFixed(1)}K';
  } else {
    return amount.toStringAsFixed(0);
  }
}
