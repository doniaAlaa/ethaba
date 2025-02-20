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
import 'package:percent_indicator/linear_percent_indicator.dart';

class InvestmentFundItemBlock extends StatelessWidget {
  final InvestmentFund fund;
  final bool isLogged;
  // final bool have;

  const InvestmentFundItemBlock({super.key, required this.fund,  this.isLogged = false,
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
                          Container(
                            width:MediaQuery.of(context).size.width*0.5,
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
                                    '${fund.createdAt}',
                                    style: ksmallGreyHeadingTextStyle.copyWith(
                                      fontSize: 10.sp,
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

                      SizedBox(height: 16.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                    '${fund.amount}'+' '+'ر.س',
                                    style: ksmallDescTextStyle.copyWith(color: kPrimaryColor,fontWeight: FontWeight.w600,)),
                                SizedBox(width: 6,),
                                Text(
                                    'المبلغ المطلوب',
                                    style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor.withOpacity(0.5),fontSize: 11)),

                              ],
                            ),
                            Text(
                                '${fund.progressPercentage?.toStringAsFixed(2)}%',
                                style: ksmallGreyHeadingTextStyle.copyWith(color:kPrimaryColor,fontWeight: FontWeight.w600,)),

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: LinearPercentIndicator(
                          // width: MediaQuery.of(context).size.width - 60.w,
                          animation: true,
                          animationDuration: 2500,
                          lineHeight: 8.0,
                          barRadius: Radius.circular(30),
                          backgroundColor:  kPrimaryColor.withOpacity(0.4),
                          percent: fund.progressPercentage!/100,
                          // linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: kPrimaryColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              '${fund.amountReceived}'+' '+'ر.س',
                              style: ksmallDescTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w600,fontSize: 13)),
                          SizedBox(width: 6,),
                          Text(
                              'المبلغ المحصل',
                              style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor.withOpacity(0.5),fontSize: 11)),

                        ],
                      ),
                      SizedBox(height: 20,),
                      /////////////////////////////////////////////////////////////////////////////////////
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.4,
                            child: Column(
                              children: [
                                DataItem(title: 'نوع الصندوق',subTitle: '${fund.category_name}',),
                                SizedBox(height: 16,),
                                DataItem(title: 'مدة الفرصة',subTitle: '${fund.durationOfInvestment}',),
                                SizedBox(height: 10,),



                              ],
                            ),
                          ),
                          Container(
                            width: 1.5,
                            height: 100,
                            color:  Color(0xD5E1E1E1),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              DataItem(title: 'متوسط نسبة الربح',subTitle: '${fund.profitPercentage}',),
                              SizedBox(height: 16,),
                              DataItem(title: 'نظام الدفع',subTitle: '${fund.profit}',),
                              SizedBox(height: 10,),


                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      isLogged == true?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'حالة الصندوق',
                              style: ksmallGreyHeadingTextStyle.copyWith(color: Color(
                                  0xD5A1A1A1),fontWeight: FontWeight.w600,fontSize: 12)),
                          SizedBox(height: 6,),
                          Container(
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
                        ],
                      ):SizedBox(),


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
                  style: kSubtitleTextStyle.copyWith(fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        )
      ],
    );

  }
}
