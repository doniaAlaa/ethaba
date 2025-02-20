// import 'package:ethabah/core/constants/app_strings.dart';
// import 'package:ethabah/core/constants/app_theme.dart';
// import 'package:ethabah/data/remote/invesment_fund.dart';
// import 'package:ethabah/models/all_investment_fund_model.dart';
// import 'package:ethabah/models/req_investment_fund_model.dart' as reqInvests;
// import 'package:ethabah/presentation/components/investmentfunds_card.dart';
// import 'package:ethabah/presentation/screens/investor_flow/investment_fund_details/investment_fund_details_screen2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../models/req_investment_fund_model.dart';
//
// class AllInvestmentFundScreen extends StatelessWidget {
//   const AllInvestmentFundScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//           child: SingleChildScrollView(
//             clipBehavior: Clip.none,
//             child: Column(
//               children: [
//                 Text(
//                   StringConstants.investmentFund,
//                   style: ksmallGreyHeadingTextStyle.copyWith(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 FutureBuilder(
//                     future: InvestmentFundProvider.getAllInvestmentFunds(),
//                     builder: (contex, snapshot) {
//                       // if (snapshot.connectionState == ConnectionState.waiting) {
//                       //   return const Center(
//                       //     child: CircularProgressIndicator(
//                       //       color: kPrimaryColor,
//                       //     ),
//                       //   );
//                       // }
//                       // if (snapshot.hasError) {
//                       //   return SizedBox(
//                       //     height: 250.h,
//                       //     child: Center(
//                       //       child: Text(
//                       //         StringConstants.somethingWentWrong,
//                       //         style: TextStyle(
//                       //             fontWeight: FontWeight.bold,
//                       //             color: kPrimaryColor,
//                       //             fontSize: 20.sp),
//                       //       ),
//                       //     ),
//                       //   );
//                       // }
//                       // if (snapshot.data == null ||
//                       //     snapshot.data!.data.isEmpty ||
//                       //     snapshot.data!.data == []) {
//                       //   return const Center(
//                       //     child: const Text(
//                       //         StringConstants.noInvestmentFundsAvailble,
//                       //         style: TextStyle(
//                       //             color: kPrimaryColor, fontSize: 20)),
//                       //   );
//                       // }
//                       // List<InvestmentFund> allInvestmentFunds =
//                       //     snapshot.data!.data;
//                       // return ListView.builder(
//                       //     clipBehavior: Clip.none,
//                       //     shrinkWrap: true,
//                       //     padding: EdgeInsets.zero,
//                       //     physics: const NeverScrollableScrollPhysics(),
//                       //     itemCount: allInvestmentFunds.length,
//                       //     itemBuilder: (context, index) {
//                       //       return GestureDetector(
//                       //         onTap: () {
//                       //           Get.to(
//                       //             () => InvestmentFundDetailScreen2(
//                       //               fund: allInvestmentFunds[index],
//                       //             ),
//                       //           );
//                       //         },
//                       //         child: InvestmentFundCard(
//                       //           fund: allInvestmentFunds[index],
//                       //         ),
//                       //       );
//                       //     });
//                       //////////////////////////////////////////////////////////////////////////////////
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(
//                           child: CircularProgressIndicator(
//                             color: kPrimaryColor,
//                           ),
//                         );
//                       }
//                       if (snapshot.hasError) {
//                         return SizedBox(
//                           height: 250.h,
//                           child: Center(
//                             child: Text(
//                               StringConstants.somethingWentWrong,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: kPrimaryColor,
//                                   fontSize: 20.sp),
//                             ),
//                           ),
//                         );
//                       }else{
//                         return ListView.builder(
//                             clipBehavior: Clip.none,
//                             shrinkWrap: true,
//                             padding: EdgeInsets.zero,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: 3,
//                             itemBuilder: (context, index) {
//                               reqInvests.InvestmentFund fund =
//                               reqInvests.InvestmentFund(id: 7, userId: 77, categoryId: 88,
//                                       name: 'name', profit: 'profit', amount: '9', month: 'month', totalFunds: 'totalFunds',
//                                   profitPercentage: 'profitPercentage',
//                                   durationOfInvestment: 'durationOfInvestment',
//                                   status: 'status', viewer: 6, createdAt:DateTime.now() , updatedAt: DateTime.now() ,
//                                       investmentFundCompanies: [InvestmentFundCompany(id: 0, investorFundsId: 09, companyId: 0, requestId: 99, company:
//                                       Company(id: 9, userId: 8, name: 'name',
//                                           registerNum: '2', phone: '987878676', email: 'email@jk.com', password: 'password',
//                                           registerCertificate: ['registerCertificate'], commercialCertificate: ['commercialCertificate'],
//                                           status: 'status', createdAt: DateTime.now(), updatedAt: DateTime.now()))]);
//
//                               return GestureDetector(
//                                 onTap: () {
//                                   Get.to(
//                                         () => InvestmentFundDetailScreen2(
//                                       fund: allInvestmentFunds[index],
//                                     ),
//                                   );
//                                 },
//                                 child: InvestmentFundCard(
//                                   fund: allInvestmentFunds[index],
//                                 ),
//                               );
//                             });
//                       }
//
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
