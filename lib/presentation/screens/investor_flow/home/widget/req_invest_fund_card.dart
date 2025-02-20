// import 'dart:ui';
//
// import 'package:ethabah/core/constants/app_strings.dart';
// import 'package:ethabah/models/req_investment_fund_model.dart';
// import 'package:ethabah/presentation/components/funding_rec_widget.dart';
// import 'package:ethabah/presentation/components/funding_req_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ethabah/core/constants/app_theme.dart';
// import 'package:ethabah/core/utils/status_helper.dart';
//
// class HorizontalInvestmentFundCard extends StatelessWidget {
//   final RequestInvestmentFund fund;
//   final bool isLogged;
//
//   const HorizontalInvestmentFundCard({
//     Key? key,
//     required this.fund,
//     this.isLogged = false
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: const EdgeInsets.only(top: 10.0,bottom: 10),
//       child: Column(
//         children: [
//           Container(
//             height: 160,
//             margin: EdgeInsets.symmetric(horizontal: 0.w, ),
//
//
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10.r),
//                 topRight: Radius.circular(10.r),
//               ),
//               color: kPrimaryColor,
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10.r),
//                 topRight: Radius.circular(10.r),
//               ),
//               child: (fund.investmentFund.image != null)
//                   ? Image.network(
//                 fund.investmentFund.imageString,
//                 fit: BoxFit.cover,
//                  height: 160,
//                 width: MediaQuery.of(context).size.width,
//
//                 errorBuilder: (context, error, stackTrace) =>
//                     Image.asset(
//                       "assets/icons/splash.png",
//                       fit: BoxFit.cover,
//                       height: 160,
//                       width: MediaQuery.of(context).size.width,
//
//
//                     ),
//               )
//                   : Image.asset(
//                 "assets/icons/splash.png",
//                 fit: BoxFit.cover,
//                 height: 160,
//                 width: MediaQuery.of(context).size.width,
//
//
//               ),
//             ),
//           ),
//           // Fund Details
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 0.w,),
//             child: Stack(
//               children: [
//                 Container(
//                   height: 180,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(10.r),
//                       bottomLeft: Radius.circular(10.r),
//                     ),
//                     color: kWhiteColor,
//                   ),
//                   child: ImageFiltered(
//                     imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                     enabled: !isLogged,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Flexible(
//                                 child: Text(
//                                   fund.investmentFund.name,
//                                   style: TextStyle(
//                                       fontSize: 14.sp,
//                                       color: kBlackColor,
//                                       fontWeight: FontWeight.w800),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10.h),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               FundingRequiredWidget(
//                                 amount: fund.investmentFund.amount??'',
//                               ),
//                               SizedBox(height: 5.w),
//                               // FundingRecievedWidget(
//                               //   amount: double.parse(fund.amountSum.toString()),
//                               // ),
//                             ],
//                           ),
//                           // SizedBox(height: 4.h),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.monetization_on,
//                                 color: kPrimaryColor,
//                                 size: 20.sp,
//                               ),
//                               SizedBox(width: 5.w),
//                               Container(
//                                 width: 0.45.sw,
//                                 child: Text(
//                                   overflow: TextOverflow.ellipsis,
//                                   "${fund.investmentFund.profitPercentage}% ${StringConstants.profit}",
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     color: kBlackColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 isLogged == true?SizedBox():
//                 Center(
//                   child: Container(
//                     height: 180,
//
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.lock_outline,color: kBlackColor,size: 30,),
//                         SizedBox(height: 6.h,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//
//                           children: [
//                             Text(StringConstants.signIn,style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w700,fontSize: 11)),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: Text(StringConstants.or,style: ksmallGreyHeadingTextStyle.copyWith(color: kOrangeColor,fontWeight: FontWeight.w700,fontSize: 10)),
//                             ),
//                             Text(StringConstants.createAccount,style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w700,fontSize: 11)),
//
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Text(StringConstants.toSeeTheDetails,style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w700,fontSize: 10)),
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//     // return Container(
//     //   height: 160.h,
//     //   width: 220.w,
//     //   margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
//     //   decoration: BoxDecoration(
//     //     color: kWhiteColor,
//     //     borderRadius: BorderRadius.circular(10.r),
//     //     boxShadow: [
//     //       BoxShadow(
//     //         color: kBlackColor.withOpacity(0.2),
//     //         blurRadius: 4,
//     //         offset: Offset(0, 2),
//     //       ),
//     //     ],
//     //   ),
//     //   child: Row(
//     //     crossAxisAlignment: CrossAxisAlignment.start,
//     //     children: [
//     //       // Image with status overlay
//     //       Stack(
//     //         clipBehavior: Clip.none,
//     //         children: [
//     //           Container(
//     //             height: 160.h,
//     //             width: 100.w,
//     //             decoration: BoxDecoration(
//     //               borderRadius: BorderRadius.only(
//     //                 bottomRight: Radius.circular(10.r),
//     //                 topRight: Radius.circular(10.r),
//     //               ),
//     //               color: kPrimaryColor,
//     //             ),
//     //             child: ClipRRect(
//     //               borderRadius: BorderRadius.only(
//     //                 bottomRight: Radius.circular(10.r),
//     //                 topRight: Radius.circular(10.r),
//     //               ),
//     //               child: (fund.investmentFund.image != null)
//     //                   ? Image.network(
//     //                       fund.investmentFund.imageString,
//     //                       fit: BoxFit.cover,
//     //                       height: 155.h,
//     //                       width: 100.w,
//     //                       errorBuilder: (context, error, stackTrace) =>
//     //                           Image.asset(
//     //                         "assets/icons/splash.png",
//     //                         fit: BoxFit.contain,
//     //                       ),
//     //                     )
//     //                   : Image.asset(
//     //                       "assets/icons/splash.png",
//     //                       fit: BoxFit.contain,
//     //                     ),
//     //             ),
//     //           ),
//     //           Positioned(
//     //             top: 0.h,
//     //             right: 0,
//     //             child: Container(
//     //               width: 100.w,
//     //               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//     //               decoration: BoxDecoration(
//     //                  // color: getStatusColor(fund.status).withOpacity(0.5),
//     //                   color: Colors.white.withOpacity(0.3),
//     //
//     //                   borderRadius: BorderRadius.only(
//     //                     topRight: Radius.circular(10.r),
//     //                   )),
//     //               child: Text(
//     //                 getStatusText(fund.status),
//     //                 style: TextStyle(
//     //                   color: kWhiteColor,
//     //                   fontSize: 8.sp,
//     //                   fontWeight: FontWeight.bold,
//     //                 ),
//     //               ),
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //       // Fund Details
//     //       Expanded(
//     //         child: Padding(
//     //           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
//     //           child: Stack(
//     //             children: [
//     //               Container(
//     //
//     //                 child: ImageFiltered(
//     //                   imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//     //                   enabled: !isLogged,
//     //                   child: Column(
//     //                     crossAxisAlignment: CrossAxisAlignment.start,
//     //                     children: [
//     //                       Row(
//     //                         children: [
//     //                           Flexible(
//     //                             child: Text(
//     //                               fund.investmentFund.name,
//     //                               style: TextStyle(
//     //                                   fontSize: 19.sp,
//     //                                   color: kPrimaryColor,
//     //                                   fontWeight: FontWeight.w800),
//     //                               maxLines: 2,
//     //                               overflow: TextOverflow.ellipsis,
//     //                             ),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                       SizedBox(height: 5.h),
//     //                       Column(
//     //                         crossAxisAlignment: CrossAxisAlignment.start,
//     //                         children: [
//     //                           FundingRequiredWidget(
//     //                             amount: fund.investmentFund.amount,
//     //                           ),
//     //                           SizedBox(height: 5.w),
//     //                           // FundingRecievedWidget(
//     //                           //   amount: double.parse(fund.amountSum.toString()),
//     //                           // ),
//     //                         ],
//     //                       ),
//     //                       // SizedBox(height: 4.h),
//     //                       Row(
//     //                         mainAxisSize: MainAxisSize.min,
//     //                         children: [
//     //                           Icon(
//     //                             Icons.monetization_on,
//     //                             color: kPrimaryColor,
//     //                             size: 20.sp,
//     //                           ),
//     //                           SizedBox(width: 5.w),
//     //                           Container(
//     //                             width: 0.45.sw,
//     //                             child: Text(
//     //                               overflow: TextOverflow.ellipsis,
//     //                               "${fund.investmentFund.profitPercentage}% ${StringConstants.profit}",
//     //                               style: TextStyle(
//     //                                 fontSize: 14.sp,
//     //                                 color: kBlackColor,
//     //                               ),
//     //                             ),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //               ),
//     //               isLogged == true?SizedBox():
//     //               Column(
//     //                 mainAxisAlignment: MainAxisAlignment.center,
//     //                 children: [
//     //                   Row(
//     //                     mainAxisAlignment: MainAxisAlignment.center,
//     //                     children: [
//     //                       Text(StringConstants.signIn,style: ksmallGreyHeadingTextStyle.copyWith(color: kSecondaryColor,fontWeight: FontWeight.w700,fontSize: 11)),
//     //                       Padding(
//     //                         padding: const EdgeInsets.symmetric(horizontal: 4.0),
//     //                         child: Text(StringConstants.or,style: ksmallGreyHeadingTextStyle.copyWith(color: kOrangeColor,fontWeight: FontWeight.w700,fontSize: 10)),
//     //                       ),
//     //                       Text(StringConstants.createAccount,style: ksmallGreyHeadingTextStyle.copyWith(color: kSecondaryColor,fontWeight: FontWeight.w700,fontSize: 11)),
//     //
//     //                     ],
//     //                   ),
//     //                   SizedBox(height: 10,),
//     //                   Text(StringConstants.toSeeTheDetails,style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w700,fontSize: 10)),
//     //
//     //                 ],
//     //               ),
//     //             ],
//     //           ),
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }
