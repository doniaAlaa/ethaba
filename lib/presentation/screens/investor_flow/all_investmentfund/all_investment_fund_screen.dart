import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/remote/invesment_fund.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/User_model.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/presentation/components/investmentfunds_card.dart';
import 'package:ethabah/presentation/screens/investor_flow/all_investmentfund/investment_fund_item_block.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/widget/home_app_bar_icon.dart';
import 'package:ethabah/presentation/screens/investor_flow/investment_fund_details/investment_details_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/investment_fund_details/investment_fund_details_screen2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class AllInvestmentFundScreen extends StatefulWidget {
  const AllInvestmentFundScreen({super.key});

  @override
  State<AllInvestmentFundScreen> createState() => _AllInvestmentFundScreenState();
}

class _AllInvestmentFundScreenState extends State<AllInvestmentFundScreen> {
  bool isLoggedIn = true;

  @override
  void initState() {

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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1D3E37),
              Color(0xFF178B7B),
              Color(0xFF178B7B),
              Color(0xFF178B7B),
               Color(0xFF178B7B),
              // Color(0xFF178B7B),
              // Color(0xFF178B7B),


              // kBackgroundColor,


            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )

      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
                children: [
                  Container(
                    height:MediaQuery.of(context).size.height*0.15,
                    child: Padding(
                      padding:  EdgeInsets.only(top: 24.h),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isLoggedIn?
                            HomeAppBarIcon(iconImage: 'assets/icons/profile.png',onTapFunc: (){
                              Get.toNamed(RoutesConstants.invProfileScreen);

                            },):SizedBox(),
                            Image.asset(kSplashLogo,scale: 3.5,),
                            isLoggedIn?
                            HomeAppBarIcon(iconImage: 'assets/icons/notification.png',onTapFunc: (){
                              Get.snackbar(
                                snackPosition: SnackPosition.TOP,
                                margin: const EdgeInsets.all(10),
                                'عفوا',
                                'لا توجد إشعارات الآن',
                                backgroundColor: kWhiteColor,
                                colorText: kPrimaryColor
                              );
                            },):SizedBox(),

                          ],
                        ),
                      ),
                    ),
                    // color: Colors.red,
                  ),
                  Expanded(
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                        color: kBackgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                  StringConstants.investmentBoxes,
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
                                future: InvestmentFundProvider.getAllInvestmentFunds(),
                                builder: (contex, snapshot) {
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
                                  if (snapshot.data == null ||
                                      snapshot.data!.data.isEmpty ||
                                      snapshot.data!.data == []) {
                                    return const Center(
                                      child: const Text(
                                          StringConstants.noInvestmentFundsAvailble,
                                          style: TextStyle(
                                              color: kPrimaryColor, fontSize: 20)),
                                    );
                                  }
                                  List<InvestmentFund> allInvestmentFunds =
                                      snapshot.data!.data;

                                  print(snapshot.data!.data.length);
                                  return Expanded(
                                    child: ListView.builder(
                                       // clipBehavior: Clip.none,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: ScrollPhysics(),
                                        itemCount: allInvestmentFunds.length,
                                        itemBuilder: (context, index) {
                                          // return Text('data');
                                          return GestureDetector(
                                            onTap: () async{
                                              final User? user = await SharedPref.getUser();
                                              print('============== ${user?.name}');
                                              if(user != null){

                                                Get.to(
                                                      () =>
                                                          InvestmentDetailsScreen(
                                                            investmentFund: allInvestmentFunds[index],
                                                            haveDateRange: false,
                                                            allFund: true,

                                                          ),
                                                );

                                              }else{
                                                Get.offAllNamed(RoutesConstants.authOnboard);

                                              }

                                            },
                                            child:
                                            InvestmentFundItemBlock(
                                              isLogged: isLoggedIn??false,
                                              fund: allInvestmentFunds[index],
                                            )

                                          );
                                        }),
                                  );


                                }),
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
