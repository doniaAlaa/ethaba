import 'dart:ui';

import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/utils/status_helper.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/models/request_model.dart';
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
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CompanyRequestItemBlock extends StatelessWidget {
  // final InvestmentFund fund;
  final Request requestModel;
  final bool isLogged;
  // final bool have;

  const CompanyRequestItemBlock({super.key, required this.requestModel,  this.isLogged = false
  });

  @override
  Widget build(BuildContext context) {

        // var str = requestModel.createdAt!.toIso8601String();
        // var newStr = str.substring(0,10) + ' ' + str.substring(11,23);
        // print(newStr);
        //
        // DateTime Date = DateTime.parse(newStr);
        // DateFormat dateFormat = DateFormat("yyyy-MM-dd ");
        //
        // String dateString = DateFormat("yyyy-MM-dd").format(Date);

        final catController = Get.isRegistered<CategoriesController>()
        ? Get.find<CategoriesController>()
        : Get.put(CategoriesController());
    // String categoryName = catController.getCategoryName(fund.categoryId);
    // String profit = "${fund.profitPercentage}%";
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
          Stack(
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                enabled: !isLogged,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:MediaQuery.of(context).size.width*0.4,
                                child: Text(
                                  requestModel.name??'',
                                  style: ksmallGreyHeadingTextStyle.copyWith(
                                    fontSize: 16.sp,
                                    color: kBlackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(height: 4,),

                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4),
                              child: Row(

                                children: [
                                  Icon(Icons.calendar_month,color: kPrimaryColor,size: 20,),
                                  SizedBox(width: 6,),
                                  Text(
                                    // '${dateString}',
                                    '${requestModel.createdAt}',

                                    style: ksmallGreyHeadingTextStyle.copyWith(
                                      fontSize: 12.sp,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: 8.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                    '${requestModel!.totalFunds}'+' '+'ر.س',
                                    style: ksmallDescTextStyle.copyWith(color: kPrimaryColor,fontWeight: FontWeight.w600,)),
                                SizedBox(width: 6,),
                                Text(
                                    StringConstants.totalFund,
                                    style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor.withOpacity(0.5),fontSize: 11)),

                              ],
                            ),
                            // Text(
                            //     '80%',
                            //     style: ksmallGreyHeadingTextStyle.copyWith(color:kPrimaryColor,fontWeight: FontWeight.w600,)),
                          ],
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10.0),
                      //   child: LinearPercentIndicator(
                      //     // width: MediaQuery.of(context).size.width - 60.w,
                      //     animation: true,
                      //     animationDuration: 2500,
                      //     lineHeight: 8.0,
                      //     barRadius: Radius.circular(30),
                      //     backgroundColor:  kPrimaryColor.withOpacity(0.4),
                      //     percent: 0.8,
                      //     // linearStrokeCap: LinearStrokeCap.butt,
                      //     progressColor: kPrimaryColor,
                      //   ),
                      // ),
                      SizedBox(height: 16,),
                      DataItem(title: 'نوع الصندوق',subTitle: '${requestModel.category}',),
                      SizedBox(height: 16,),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       width: MediaQuery.of(context).size.width*0.4,
                      //       child: Column(
                      //         children: [
                      //           DataItem(title: 'نوع الصندوق',subTitle: '${requestModel.category}',),
                      //           SizedBox(height: 12,),
                      //           DataItem(title: 'مدة الفرصة',subTitle: '${'fund.month'}',),
                      //           SizedBox(height: 10,),
                      //
                      //
                      //
                      //         ],
                      //       ),
                      //     ),
                      //     // SizedBox(height: 16,),
                      //     //
                      //     // Container(
                      //     //   width: 1.5,
                      //     //   height: 100,
                      //     //   color:  Color(0xD5E1E1E1),
                      //     // ),
                      //     // SizedBox(width: 10,),
                      //     // Column(
                      //     //   children: [
                      //     //     DataItem(title: 'نسبة الربح',subTitle: '${'fund.profitPercentage'} %',),
                      //     //     SizedBox(height: 10,),
                      //     //     DataItem(title: 'عائد الاستثمار',subTitle: '${'fund.durationOfInvestment'}%',),
                      //     //     SizedBox(height: 10,),
                      //     //
                      //     //
                      //     //   ],
                      //     // ),
                      //   ],
                      // ),
                      Text(
                          'حالة الصندوق',
                          style: ksmallGreyHeadingTextStyle.copyWith(color: Color(
                              0xD5A1A1A1),fontWeight: FontWeight.w600,fontSize: 12)),
                      SizedBox(height: 6,),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                           color: getStatusColor(requestModel.status??'0'),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          getStatusText(requestModel.status??'0'),
                          style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),

                      Container(
                        // width: 180,
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

                      SizedBox(height: 10,),

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
                          Text(StringConstants.signIn,style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w700,)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(StringConstants.or,style: ksmallGreyHeadingTextStyle.copyWith(color: kOrangeColor,fontWeight: FontWeight.w700,)),
                          ),
                          Text(StringConstants.createAccount,style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w700,)),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(StringConstants.toSeeTheDetails,style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w700,)),

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

class DataItem extends StatelessWidget {
  final String title;
  final String subTitle;

  const DataItem({super.key,required this.title,required this.subTitle ,});

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.3,

              child: Text(
                  title,
                  style: ksmallGreyHeadingTextStyle.copyWith(color: Color(
                      0xD5A1A1A1),fontWeight: FontWeight.w600,fontSize: 12)),
            ),

            // SizedBox(height: 6,),
            Container(
              width: MediaQuery.of(context).size.width*0.3,
              child: Text(
                  subTitle,
                  style: kSubtitleTextStyle.copyWith(fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        )
      ],
    );

  }
}
