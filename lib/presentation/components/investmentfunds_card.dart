import 'dart:ui';

import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/utils/status_helper.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/funding_rec_widget.dart';
import 'package:ethabah/presentation/screens/investor_flow/investment_fund_details/investment_fund_details_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ethabah/core/constants/app_theme.dart';
// ignore: unused_import
import 'package:ethabah/core/utils/date_helper.dart';
import 'package:ethabah/presentation/components/funding_req_widget.dart';
import 'package:ethabah/controller/categories_controller.dart';
import 'package:get/get.dart';

class InvestmentFundCard extends StatelessWidget {
  final InvestmentFund fund;
  final bool isLogged;

  const InvestmentFundCard({
    super.key,
    this.isLogged =false,
    required this.fund,
  });

  @override
  Widget build(BuildContext context) {
    final catController = Get.isRegistered<CategoriesController>()
        ? Get.find<CategoriesController>()
        : Get.put(CategoriesController());
    String categoryName = catController.getCategoryName(fund.categoryId??0);
    String profit = "${fund.profitPercentage}%";
    String profitPaidDuration = StringConstants.profitWillBePaid;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.r),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: kWhiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container to show image with top border curve
          Stack(
            children: [
              Container(
                height: 140.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                  ),
                  child: (fund.image != null)
                      ? Image.network(
                          fund.imageString,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            "assets/icons/splash.png",
                            fit: BoxFit.contain,
                            height: 70.h,
                          ),
                        )
                      : Image.asset(
                          "assets/icons/splash.png",
                          fit: BoxFit.contain,
                          height: 70.h,
                        ),
                ),
              ),
              Positioned(
                top: 0.01.sh,
                left: 0.02.sw,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: getStatusColor(fund.status??''),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    getStatusText(fund.status??''),
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    fund.name??'',
                    style: ksmallGreyHeadingTextStyle.copyWith(
                      fontSize: 16.sp,
                      color: kBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10, tileMode: TileMode.decal),
                enabled: !isLogged,
                child: Container(
                  decoration: BoxDecoration(
                    // color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(13.r),
                      bottomRight: Radius.circular(13.r),
                    ),
                  ),
                  child: Column(
                    children: [

                      SizedBox(height: 10.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FundingRequiredWidget(amount: fund.amount??''),
                                SizedBox(width: 10.w),
                                FundingRecievedWidget(
                                    amount: double.parse(fund.amountReceived.toString())),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 10.w),
                                Column(
                                  children: [
                                    //Profit Percentage

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.monetization_on,
                                          color: kPrimaryColor,
                                          size: 20.sp,
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          StringConstants.profitPercentage,
                                          style: ksmallDescTextStyle.copyWith(
                                            fontSize: 14.sp,
                                            color: kBlackColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      profit,
                                      style: ksmallDescTextStyle.copyWith(
                                        fontSize: 14.sp,
                                        color: kBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10.w),
                                //divider
                                Container(height: 30.h, width: 1.w, color: kPrimaryColor),
                                SizedBox(width: 10.w),
                                Column(
                                  children: [
                                    //Profit Paid Duration
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: kPrimaryColor,
                                          size: 20.sp,
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          StringConstants.durationOfInvestment,
                                          style: ksmallDescTextStyle.copyWith(
                                            fontSize: 14.sp,
                                            color: kBlackColor,
                                          ),
                                          maxLines: 2,
                                        )
                                      ],
                                    ),
                                    Text(
                                      '${fund.durationOfInvestment} ${fund.month}',
                                      style: ksmallDescTextStyle.copyWith(
                                        fontSize: 14.sp,
                                        color: kBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10.w),
                                // //divider
                                // Container(
                                //   height: 30.h,
                                //   width: 1.w,
                                //   color: kGreyColor,
                                // ),
                                // SizedBox(width: 10.w),
                              ],
                            ),
                            // Text(
                            //   "${StringConstants.profitPercentage}: ${fund.profitPercentage}%",
                            //   style: ksmallDescTextStyle.copyWith(
                            //     fontSize: 14.sp,
                            //     color: kBlackColor,
                            //   ),
                            // ),
                            // SizedBox(height: 5.h),
                            // Text(
                            //   "${StringConstants.durationOfInvestment}: ${fund.durationOfInvestment}",
                            //   style: ksmallDescTextStyle.copyWith(
                            //     fontSize: 14.sp,
                            //     color: kBlackColor,
                            //   ),
                            // ),
                            // SizedBox(height: 5.h),
                            // Text(
                            //   "${StringConstants.totalFunds}: ${fund.totalFunds}",
                            //   style: ksmallDescTextStyle.copyWith(
                            //     fontSize: 14.sp,
                            //     color: kBlackColor,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: 180,
                        height: 40.h,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(child: Text(StringConstants.viewDetails,style: TextStyle(color: kWhiteColor),)),
                      ),

                      // CustomRoundedButton(
                      //   backgroundColor: kPrimaryColor,
                      //   width: 0.5.sw,
                      //   // height: 40.h,
                      //   textColor: kWhiteColor,
                      //   loading: false,
                      //   text: StringConstants.viewDetails,
                      //   onPressed: () {
                      //     Get.to(
                      //           () => InvestmentFundDetailScreen2(
                      //         fund: fund,
                      //       ),
                      //     );
                      //   },
                      // ),
                    SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ),
              isLogged == true?SizedBox():
              Center(
                child: Container(
                  height: 180,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_outline,color: kBlackColor,size: 30,),
                      SizedBox(height: 6.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Text(StringConstants.signIn,style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w700,fontSize: 11)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(StringConstants.or,style: ksmallGreyHeadingTextStyle.copyWith(color: kOrangeColor,fontWeight: FontWeight.w700,fontSize: 10)),
                          ),
                          Text(StringConstants.createAccount,style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w700,fontSize: 11)),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(StringConstants.toSeeTheDetails,style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w700,fontSize: 10)),

                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
// import 'dart:developer';

// import 'package:ethabah/core/constants/app_strings.dart';
// import 'package:ethabah/core/utils/status_helper.dart';
// import 'package:ethabah/models/all_investment_fund_model.dart';
// import 'package:ethabah/presentation/components/custom_rounded_button.dart';
// import 'package:ethabah/presentation/components/funding_rec_widget.dart';
// import 'package:ethabah/presentation/screens/investor_flow/investment_fund_details/investment_fund_details_screen2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ethabah/core/constants/app_theme.dart';
// // ignore: unused_import
// import 'package:ethabah/core/utils/date_helper.dart';
// import 'package:ethabah/presentation/components/funding_req_widget.dart';
// import 'package:ethabah/controller/categories_controller.dart';
// import 'package:get/get.dart';

// class InvestmentFundCard extends StatelessWidget {
//   final InvestmentFund fund;

//   const InvestmentFundCard({
//     super.key,
//     required this.fund,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final catController = Get.isRegistered<CategoriesController>()
//         ? Get.find<CategoriesController>()
//         : Get.put(CategoriesController());
//     String categoryName =
//         catController.getCategoryName(fund.investorFund?.categoryId ?? 0);
//     String profit = "${fund.investorFund?.profitPercentage}%";
//     String profitPaidDuration = StringConstants.profitWillBePaid;
//     log("Image Link: ${fund.investorFund?.imageString}");
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(13.r),
//         boxShadow: [
//           BoxShadow(
//             color: kBlackColor.withOpacity(0.3),
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//         color: kWhiteColor,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Container to show image with top border curve
//           Stack(
//             children: [
//               Container(
//                 height: 140.h,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: kPrimaryColor,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(13.r),
//                     topRight: Radius.circular(13.r),
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(13.r),
//                     topRight: Radius.circular(13.r),
//                   ),
//                   child: (fund.investorFund?.image != null)
//                       ? Image.network(
//                           fund.investorFund?.imageString,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             log("Error: $error");
//                             log("Stack Trace: $stackTrace");
//                             return Image.asset(
//                               "assets/icons/splash.png",
//                               fit: BoxFit.contain,
//                               height: 70.h,
//                             );
//                           },
//                         )
//                       : Image.asset(
//                           "assets/icons/splash.png",
//                           fit: BoxFit.contain,
//                           height: 70.h,
//                         ),
//                 ),
//               ),
//               Positioned(
//                 top: 0.01.sh,
//                 left: 0.02.sw,
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: getStatusColor(fund.investorFund?.status ?? "0"),
//                     borderRadius: BorderRadius.circular(5.r),
//                   ),
//                   child: Text(
//                     getStatusText(fund.investorFund?.status ?? "0"),
//                     style: TextStyle(
//                       color: kWhiteColor,
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5.h),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Text(
//                     fund.name,
//                     style: ksmallGreyHeadingTextStyle.copyWith(
//                       fontSize: 20.sp,
//                       color: kPrimaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 2,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10.h),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     FundingRequiredWidget(
//                         amount: fund.investorFund?.amount ?? "0"),
//                     SizedBox(width: 10.w),
//                     FundingRecievedWidget(
//                         amount: fund.investorFund?.amountReceived ?? 0.0),
//                   ],
//                 ),
//                 SizedBox(height: 10.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(width: 10.w),
//                     Column(
//                       children: [
//                         //Profit Percentage

//                         Row(
//                           children: [
//                             Icon(
//                               Icons.monetization_on,
//                               color: kPrimaryColor,
//                               size: 20.sp,
//                             ),
//                             SizedBox(width: 5.w),
//                             Text(
//                               StringConstants.profitPercentage,
//                               style: ksmallDescTextStyle.copyWith(
//                                 fontSize: 14.sp,
//                                 color: kBlackColor,
//                               ),
//                             )
//                           ],
//                         ),
//                         Text(
//                           profit,
//                           style: ksmallDescTextStyle.copyWith(
//                             fontSize: 14.sp,
//                             color: kBlackColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: 10.w),
//                     //divider
//                     Container(height: 30.h, width: 1.w, color: kPrimaryColor),
//                     SizedBox(width: 10.w),
//                     Column(
//                       children: [
//                         //Profit Paid Duration
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.access_time,
//                               color: kPrimaryColor,
//                               size: 20.sp,
//                             ),
//                             SizedBox(width: 5.w),
//                             Text(
//                               profitPaidDuration,
//                               style: ksmallDescTextStyle.copyWith(
//                                 fontSize: 14.sp,
//                                 color: kBlackColor,
//                               ),
//                               maxLines: 2,
//                             )
//                           ],
//                         ),
//                         Text(
//                           fund.investorFund?.profit ?? "N/A",
//                           style: ksmallDescTextStyle.copyWith(
//                             fontSize: 14.sp,
//                             color: kBlackColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: 10.w),
//                     // //divider
//                     // Container(
//                     //   height: 30.h,
//                     //   width: 1.w,
//                     //   color: kGreyColor,
//                     // ),
//                     // SizedBox(width: 10.w),
//                   ],
//                 ),
//                 // Text(
//                 //   "${StringConstants.profitPercentage}: ${fund.profitPercentage}%",
//                 //   style: ksmallDescTextStyle.copyWith(
//                 //     fontSize: 14.sp,
//                 //     color: kBlackColor,
//                 //   ),
//                 // ),
//                 // SizedBox(height: 5.h),
//                 // Text(
//                 //   "${StringConstants.durationOfInvestment}: ${fund.durationOfInvestment}",
//                 //   style: ksmallDescTextStyle.copyWith(
//                 //     fontSize: 14.sp,
//                 //     color: kBlackColor,
//                 //   ),
//                 // ),
//                 // SizedBox(height: 5.h),
//                 // Text(
//                 //   "${StringConstants.totalFunds}: ${fund.totalFunds}",
//                 //   style: ksmallDescTextStyle.copyWith(
//                 //     fontSize: 14.sp,
//                 //     color: kBlackColor,
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//           SizedBox(height: 12.h),
//           Center(
//             child: CustomRoundedButton(
//               backgroundColor: kPrimaryColor,
//               width: 0.5.sw,
//               height: 40.h,
//               textColor: kWhiteColor,
//               loading: false,
//               text: StringConstants.viewDetails,
//               onPressed: () {
//                 Get.to(
//                   () => InvestmentFundDetailScreen2(
//                     fund: fund,
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 10.h),
//         ],
//       ),
//     );
//   }
// }
