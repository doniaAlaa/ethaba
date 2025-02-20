// import 'dart:developer';
//
// import 'package:ethabah/controller/categories_controller.dart';
// import 'package:ethabah/core/constants/app_routes.dart';
// import 'package:ethabah/core/constants/app_strings.dart';
// import 'package:ethabah/core/constants/app_theme.dart';
// import 'package:ethabah/data/remote/invesment_fund.dart';
// import 'package:ethabah/data/shared/user_pref.dart';
// import 'package:ethabah/models/User_model.dart';
// import 'package:ethabah/models/req_investment_fund_model.dart';
// import 'package:ethabah/presentation/components/funding_req_widget.dart';
// import 'package:ethabah/presentation/screens/company_flow/home/home_screen.dart';
// import 'package:ethabah/presentation/screens/investor_flow/home/inv_home_screen_controller.dart';
// import 'package:ethabah/presentation/screens/investor_flow/home/widget/req_invest_fund_card.dart';
// import 'package:ethabah/presentation/screens/investor_flow/investment_fund_details/investment_fund_detail_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class InvHomeScreen extends StatefulWidget {
//   const InvHomeScreen({super.key});
//
//   @override
//   State<InvHomeScreen> createState() => _InvHomeScreenState();
// }
//
// class _InvHomeScreenState extends State<InvHomeScreen> {
//    bool isLoggedIn = true;
//
//   @override
//   void initState() {
//     // Future.delayed( Duration.zero, () async{
//     //   final User? user = await SharedPref.getUser();
//     //   isLoggedIn = user != null;
//     //   print('isLoggedIn$isLoggedIn');
//     // });
//     WidgetsBinding.instance!.addPostFrameCallback((_) async {
//       final User? user = await SharedPref.getUser();
//       isLoggedIn = user != null;
//       print('isLoggedIn$isLoggedIn');
//       setState(() {});
//     });
//
//     super.initState();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance!.addPostFrameCallback((_) async {
//       final User? user = await SharedPref.getUser();
//       isLoggedIn = user != null;
//       print('isLoggedIn$isLoggedIn');
//     });
//     final controller = Get.put(InvHomeScreenController());
//     final catController = Get.isRegistered<CategoriesController>()
//         ? Get.find<CategoriesController>()
//         : Get.put(CategoriesController(), permanent: true);
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             children: [
//               // SizedBox(
//               //   height: 50.h,
//               //   width: double.infinity,
//               // ),
//               // Text(
//               //   StringConstants.myDashboard,
//               //   style: ksmallGreyHeadingTextStyle.copyWith(
//               //     fontSize: 20.sp,
//               //   ),
//               // ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               FutureBuilder(
//                   future: InvestmentFundProvider.dashboardIInvestmentStats(),
//                   builder: (context, snapshot) {
//                     log('Data: ${snapshot.data}');
//                     return Row(
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Stack(
//                             children: [
//                               Container(
//                                 height: 200.h,
//                                 decoration: BoxDecoration(
//                                   color: kSecondaryColor,
//                                   borderRadius: BorderRadius.circular(10.r),
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                     colors: [
//                                       kSecondaryColor.withOpacity(1),
//                                       kSecondaryColor,
//                                       kSecondaryColor.withOpacity(1),
//                                     ],
//                                     stops: [0.0, 0.5, 1.0],
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.white.withOpacity(0.5),
//                                       spreadRadius: 1,
//                                       blurRadius: 5,
//                                       offset: const Offset(0, 3),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10.r),
//                                   child: CustomPaint(
//                                     painter: ShinePainter(),
//                                     child: Container(),
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 5,
//                                 left: 0,
//                                 right: 0,
//                                 child: Container(
//                                   height: 200.h,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 15, vertical: 10),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(StringConstants.totalfundsInvested,
//                                           style: kSubHeadingTextStyle.copyWith(
//                                               color: kWhiteColor,
//                                               fontSize: 14.sp)),
//                                       //SizedBox(height: 5.h),
//                                       Text(
//                                           "SAR ${formatAmount(double.parse("${snapshot.data?["investorAmount"] ?? 0}"))}",
//                                           style: kHeadingTextStyle.copyWith(
//                                               color: kWhiteColor,
//                                               fontSize: 32.sp)),
//                                       SizedBox(height: 20.h),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 10.w),
//                         Column(
//                           children: [
//                             Container(
//                               height: 95.h,
//                               width: 0.25.sw,
//                               decoration: BoxDecoration(
//                                 color: Colors.orange[100],
//                                 border: Border.all(
//                                   color: Colors.orange.withOpacity(0.5),
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10.r),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.pending_actions,
//                                     color: Colors.orange,
//                                   ),
//                                   SizedBox(height: 5.h),
//                                   Text(
//                                     StringConstants.onHoldFunds,
//                                     style: ksmallGreyHeadingTextStyle.copyWith(
//                                       color: Colors.orange,
//                                       fontSize: 12.sp,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   Text(
//                                     "0",
//                                     style: ksmallGreyHeadingTextStyle.copyWith(
//                                       color: Colors.orange,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 10.h),
//                             Container(
//                               height: 95.h,
//                               width: 0.25.sw,
//                               decoration: BoxDecoration(
//                                 color: Colors.green[100],
//                                 border: Border.all(
//                                   color: Colors.green.withOpacity(0.5),
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10.r),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.check_circle_outline,
//                                     color: Colors.green,
//                                   ),
//                                   SizedBox(height: 5.h),
//                                   Text(
//                                     StringConstants.approvedFunds,
//                                     style: ksmallGreyHeadingTextStyle.copyWith(
//                                       color: Colors.green,
//                                       fontSize: 12.sp,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   Text(
//                                     "${snapshot.data?["investorpendingStatus"] ?? 0}",
//                                     style: ksmallGreyHeadingTextStyle.copyWith(
//                                       color: Colors.green,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   }),
//               SizedBox(height: 20.h),
//               Row(
//                 children: [
//                   Text(
//                     StringConstants.myInvestmentFund,
//                     style: ksmallGreyHeadingTextStyle.copyWith(
//                       fontSize: 20.sp,
//                     ),
//                   ),
//                   const Spacer(),
//                 ],
//               ),
//               isLoggedIn ?
//               FutureBuilder(
//                   future: controller.getRequestedInvestmentFund(),
//                   builder: (context, snapshot) {
//                     //log('Data: ${snapshot.data}');
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: CircularProgressIndicator(
//                           color: kPrimaryColor,
//                         ),
//                       );
//                     }
//                     if (snapshot.data == [] ||
//                         snapshot.data == null ||
//                         snapshot.data!.isEmpty) {
//                       return SizedBox(
//                         height: 200.h,
//                         child: Center(
//                           child: Text(
//                             StringConstants.noInvestmentFundsAvailble,
//                             style: TextStyle(
//                               color: kPrimaryColor,
//                               fontSize: 20.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                     //log('Data length: ${snapshot.data!.length}');
//                     return Expanded(
//                       child: ListView.builder(
//                         padding: EdgeInsets.zero,
//                         itemCount: snapshot.data!.length,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           RequestInvestmentFund fund = snapshot.data![index];
//                           return GestureDetector(
//                               onTap: () {
//                                 // log(fund.toJson().toString());
//                                 Get.to(() =>
//                                     InvestmentFundDetailScreen(fund: fund));
//                               },
//                               child: HorizontalInvestmentFundCard(
//                                 isLogged: isLoggedIn??false,
//                                 fund: fund,
//                               ));
//                         },
//                       ),
//                     );
//                   }):
//               Expanded(
//                 child: ListView.builder(
//                   padding: EdgeInsets.zero,
//                   itemCount: 20,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     // RequestInvestmentFund fund = RequestInvestmentFund(id: 1, userId:44,investmentFund: InvestmentFund(id: 7, userId: 77, categoryId: 88, name: 'name', profit: 'profit', amount: '9', month: 'month', totalFunds: 'totalFunds',
//                     //     profitPercentage: 'profitPercentage',
//                     //     durationOfInvestment: 'durationOfInvestment',
//                     //     status: 'status', viewer: 6, createdAt:DateTime.now() , updatedAt: DateTime.now() , investmentFundCompanies: [InvestmentFundCompany(id: 0, investorFundsId: 09, companyId: 0, requestId: 99, company: Company(id: 9, userId: 8, name: 'name', registerNum: '2', phone: '987878676', email: 'email@jk.com', password: 'password', registerCertificate: ['registerCertificate'], commercialCertificate: ['commercialCertificate'], status: 'status', createdAt: DateTime.now(), updatedAt: DateTime.now()))]),investorFundsId: 09, amount: '6909', timeOfInvestment:7, status: '908', createdAt:DateTime.now(), updatedAt:DateTime.now());
//                     //
//                     return GestureDetector(
//                         onTap: () async{
//                           final User? user = await SharedPref.getUser();
//                           print('============== ${user?.name}');
//                           if(user != null){
//                             // Get.to(() =>
//                             //     InvestmentFundDetailScreen(fund: fund));
//                           }else{
//                             Get.offAllNamed(RoutesConstants.authOnboard);
//
//                           }
//
//                         },
//                         child: HorizontalInvestmentFundCard(
//                           isLogged: isLoggedIn??false,
//
//                           fund: fund,
//                         ));
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// String formatAmount(double amount) {
//   if (amount >= 1000) {
//     return '${(amount / 1000).toStringAsFixed(1)}K';
//   } else {
//     return amount.toStringAsFixed(0);
//   }
// }
