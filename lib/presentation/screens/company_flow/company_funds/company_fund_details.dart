import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/utils/app_utils.dart';
import 'package:ethabah/core/utils/status_helper.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/models/investment_company_model.dart';
import 'package:ethabah/models/request_model.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/screens/document_pdf/document_pdf_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/make_investment/make_investment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CompanyFundDetails extends StatefulWidget {
  final InvestmentFundCompany investmentFundCompany;

  const CompanyFundDetails({super.key,required this.investmentFundCompany});

  @override
  State<CompanyFundDetails> createState() => _CompanyFundDetailsState();
}

class _CompanyFundDetailsState extends State<CompanyFundDetails> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final catController = Get.isRegistered<CategoriesController>()
        ? Get.find<CategoriesController>()
        : Get.put(CategoriesController());

    // String categoryName =
    //     catController.getCategoryName(widget.investmentFund.categoryId ?? 0) ?? "N/A";
    // String startDate = formatDate(widget.investmentFund.createdAt.toString());
    // String endDate = formatDate(widget.investmentFund.updatedAt.toString());
    // String durationOfInvestment = '${widget.investmentFund.durationOfInvestment} ${widget.investmentFund.month}';
    // String profitPercentage = '${widget.investmentFund.profitPercentage}%';
    // String profitType = widget.investmentFund.profit;
    // String status = getStatusText(widget.investmentFund.status);
    // Color statusColor = getStatusColor(widget.investmentFund.status);
    // double totalFundReq = double.parse(widget.investmentFund.totalFunds);
    // double totalFundRec =
    // double.parse(widget.investmentFund.amountReceived.toString() ?? '0.0');
    // double progress = totalFundRec / totalFundReq;
    // double remainingAmount = totalFundReq - totalFundRec;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.25,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: kSecondaryColor,

                ),
                child:
                // (widget.investmentFund.image != null)
                //     ? Image.network(
                //   widget.investmentFund.imageString,
                //   fit: BoxFit.fill,
                //   errorBuilder: (context, error, stackTrace) =>
                //       Image.asset(
                //         "assets/icons/splash.png",
                //         fit: BoxFit.fill,
                //         height: 70.h,
                //       ),
                // )
                //     :
                Image.asset(
                  "assets/icons/splash.png",
                  fit: BoxFit.fill,
                  height: 70.h,
                ),

              ),


            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16,top: 140),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.r),

                    ),
                    color: kWhiteColor,
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //     widget.investmentFund.name,
                        //     style: kSubHeadingTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 18)),
                        // SizedBox(height: 10,),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPrimaryColor.withOpacity(0.4)
                              ),
                              child: Icon(Icons.account_balance_rounded,color: kWhiteColor,),
                            ),
                            SizedBox(width: 10,),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Container(
                            //       width: MediaQuery.of(context).size.width*0.6,
                            //
                            //       child: Text(
                            //           'صندوق عقارى',
                            //           style: ksmallGreyHeadingTextStyle.copyWith(color: Color(
                            //               0xD5BDBBBB),fontWeight: FontWeight.w600,fontSize: 12)),
                            //     ),
                            //
                            //     SizedBox(height: 8,),
                            //     Container(
                            //       width: MediaQuery.of(context).size.width*0.7,
                            //       child: Text(
                            //           'صندوق عقارى استثمارى متوافق مع احكام الشريعة الاسلامية',
                            //           style: kSubtitleTextStyle.copyWith(fontSize: 14,)),
                            //     ),
                            //   ],
                            // )

                            Text(
                                widget.investmentFundCompany.name,
                                style: kSubHeadingTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 18)),
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
                                      '${widget.investmentFundCompany.total_funds}'+' '+'ر.س',
                                      style: ksmallDescTextStyle.copyWith(color: kPrimaryColor,fontWeight: FontWeight.w600,)),
                                  SizedBox(width: 6,),
                                  Text(
                                      'المبلغ المطلوب',
                                      style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor.withOpacity(0.5),fontSize: 11)),

                                ],
                              ),
                              Text(
                                  '${double.parse(widget.investmentFundCompany.progress_percentage.toString()).toStringAsFixed(2)}%',
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
                            percent:double.parse(widget.investmentFundCompany.progress_percentage.toString()) /100,
                            // linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: kPrimaryColor,
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    color: kWhiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            DetailsItem(title: StringConstants.typeOfInvestment, subTitle:widget.investmentFundCompany.category??'' , icon: Icons.category,),
                            SizedBox(width: 10,),
                            DetailsItem(title:  'مدة الفرصة', subTitle: widget.investmentFundCompany.duration_of_investment??'', icon: Icons.access_time,),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:16.0),
                          child: Divider(color: Color(0xD5F1F1F1),thickness: 2.0,),
                        ),
                        Row(
                          children: [
                            DetailsItem(title:
                            StringConstants.profitPercentage,
                              subTitle: '${widget.investmentFundCompany.profit_percentage}', icon: Icons.percent,),
                            SizedBox(width: 10,),

                            DetailsItem(title: 'تاريخ إنشاء الصندوق',
                              subTitle: '${widget.investmentFundCompany.created_at}', icon: Icons.date_range,
                            ),


                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical:16.0),
                        //   child: Divider(color: Color(0xD5F1F1F1),thickness: 2.0,),
                        // ),

                        // Row(
                        //   children: [
                        //     DetailsItem(title:
                        //     'تاريخ إنشاء الصندوق',
                        //       subTitle: 'profitPercentage', icon: Icons.date_range,),
                        //     SizedBox(width: 10,),
                        //
                        //     DetailsItem(title: 'الحد الأدنى للإستثمار',
                        //       subTitle: 'profitType', icon: Icons.monetization_on,
                        //     ),
                        //
                        //
                        //   ],
                        // ),
                        // widget.haveDateRange?
                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(vertical:16.0),
                        //       child: Divider(color: Color(0xD5F1F1F1),thickness: 2.0,),
                        //     ),
                        //     Row(
                        //       children: [
                        //         DetailsItem(title:  StringConstants.startOfPeriod,
                        //           subTitle: startDate, icon: Icons.date_range
                        //           ,),
                        //         SizedBox(width: 10,),
                        //         DetailsItem(title:
                        //         StringConstants.endOfPeriod,
                        //           subTitle:endDate, icon: Icons.event,),
                        //
                        //
                        //       ],
                        //     ),
                        //   ],
                        // ):SizedBox()




                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                      'وصف الصندوق',
                      style: ksmallDescTextStyle.copyWith(fontWeight: FontWeight.w600,color: kBlackColor)),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(16.r)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.description,color: kPrimaryColor,),
                        SizedBox(width: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Text(
                              '${'widget.investmentFundCompany.description'}',
                              style: kSubtitleTextStyle.copyWith(fontSize: 14,)),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                      'المستندات والضمانات',
                      style: ksmallDescTextStyle.copyWith(fontWeight: FontWeight.w600,color: kBlackColor)),
                ),
                widget.investmentFundCompany.documents != null?
                Container(
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(16.r)
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.investmentFundCompany.documents?.length,
                          itemBuilder: (context,index){return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  DocumentPdfScreen(pdf:widget.investmentFundCompany.documents?[index]??'' ,userType: UserType.investor)),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.file_copy,color: kPrimaryColor,),
                                        SizedBox(width: 10,),
                                        Text(
                                            '${widget.investmentFundCompany.document_names?[index]}',

                                            style: ksmallGreyHeadingTextStyle.copyWith(fontWeight: FontWeight.w600,color: kBlackColor)),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward)
                                  ],
                                ),
                              ),
                              index  ==  (widget.investmentFundCompany.documents!.length) -1   ? SizedBox(): Padding(
                                padding: const EdgeInsets.symmetric(vertical:16.0),
                                child: Divider(color: Color(0xD5F1F1F1),thickness: 2.0,),
                              )


                            ],
                          );})
                  ),
                ):Text('لا يوجد مستندات'),

                SizedBox(
                  height: 16.h,
                ),


              ],
            ),
          ),
        ],
      ),


    );

  }
}

class DetailsItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;

  const DetailsItem({super.key,required this.title,required this.subTitle , required this.icon});

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 35,width: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kPrimaryColor.withOpacity(0.1)
          ),
          child: Icon(icon,color: kPrimaryColor,),
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.3,

              child: Text(
                  title,
                  style: ksmallGreyHeadingTextStyle.copyWith(color: Color(
                      0xD5A1A1A1),fontWeight: FontWeight.w600,fontSize: 10)),
            ),

            SizedBox(height: 8,),
            Container(
              width: MediaQuery.of(context).size.width*0.3,
              child: Text(
                  subTitle,
                  style: kSubtitleTextStyle.copyWith(fontSize: 13,color: kPrimaryColor,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        )
      ],
    );

  }
}
