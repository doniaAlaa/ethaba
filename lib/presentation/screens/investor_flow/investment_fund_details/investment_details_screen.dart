import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/utils/app_utils.dart';
import 'package:ethabah/core/utils/status_helper.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/screens/document_pdf/document_pdf_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/make_investment/make_investment_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/make_investment/make_investment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InvestmentDetailsScreen extends StatefulWidget {
  final InvestmentFund investmentFund;
  final bool haveDateRange;
  final bool allFund;

  const InvestmentDetailsScreen({super.key,required this.investmentFund,required this.haveDateRange,required this.allFund });

  @override
  State<InvestmentDetailsScreen> createState() => _InvestmentDetailsScreenState();
}

class _InvestmentDetailsScreenState extends State<InvestmentDetailsScreen> with TickerProviderStateMixin {

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

    print('eeeeeeeee');

    final catController = Get.isRegistered<CategoriesController>()
        ? Get.find<CategoriesController>()
        : Get.put(CategoriesController());

    String categoryName =
        catController.getCategoryName(widget.investmentFund.categoryId ?? 0) ?? "N/A";
    String startDate = formatDate(widget.investmentFund.createdAt.toString());
    String endDate = formatDate(widget.investmentFund.updatedAt.toString());
    String durationOfInvestment = '${widget.investmentFund.durationOfInvestment} ';
    // String durationOfInvestment = '${widget.investmentFund.month}';

    String profitPercentage = '${widget.investmentFund.profitPercentage}%';
    String profitType = widget.investmentFund.profit??'';
    String status = getStatusText(widget.investmentFund.status??'');
    Color statusColor = getStatusColor(widget.investmentFund.status??'');
    double totalFundReq = double.parse(widget.investmentFund.totalFunds??'');
    double totalFundRec =
    double.parse(widget.investmentFund.amountReceived.toString().replaceAll(',', '') ?? '0.0');
    double progress = totalFundRec / totalFundReq;
    double remainingAmount = totalFundReq - totalFundRec;

    String pdfLink = '';
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
                child: (widget.investmentFund.image != null)
                    ? Image.network(
                  widget.investmentFund.imageString,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset(
                        "assets/icons/splash.png",
                        fit: BoxFit.fill,
                        height: 70.h,
                      ),
                )
                    : Image.asset(
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

                            Container(
                              width: MediaQuery.of(context).size.width*0.6.w,
                              child: Text(
                                  widget.investmentFund.name??'',
                                  style: kSubHeadingTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 18)),
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
                                      '${totalFundReq}'+' '+'ر.س',
                                      style: ksmallDescTextStyle.copyWith(color: kPrimaryColor,fontWeight: FontWeight.w600,)),
                                  SizedBox(width: 6,),
                                  Text(
                                      'المبلغ المطلوب',
                                      style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor.withOpacity(0.5),fontSize: 11)),

                                ],
                              ),
                              Text(
                                  '${widget.investmentFund.progressPercentage?.toStringAsFixed(2)}%',
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
                            percent: widget.investmentFund.progressPercentage!/100,
                            // linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: kPrimaryColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                '${widget.investmentFund.amountReceived}'+' '+'ر.س',
                                style: ksmallDescTextStyle.copyWith(color: kBlackColor,fontWeight: FontWeight.w600,fontSize: 13)),
                            SizedBox(width: 6,),
                            Text(
                                'المبلغ المحصل',
                                style: ksmallGreyHeadingTextStyle.copyWith(color: kBlackColor.withOpacity(0.5),fontSize: 11)),

                          ],
                        ),


                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                 // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    color: kWhiteColor,
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            DetailsItem(title: StringConstants.typeOfInvestment, subTitle:categoryName , icon: Icons.category,),
                            SizedBox(width: 10,),
                            DetailsItem(title:  StringConstants.durationOfInvestment, subTitle: durationOfInvestment, icon: Icons.access_time,),

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
                               subTitle: profitPercentage, icon: Icons.percent,),
                            SizedBox(width: 10,),

                            DetailsItem(title: 'نظام الدفع',
                              subTitle: profitType, icon: Icons.monetization_on,
                            ),


                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:16.0),
                          child: Divider(color: Color(0xD5F1F1F1),thickness: 2.0,),
                        ),

                        Row(
                          children: [
                            DetailsItem(title:
                            'تاريخ إنشاء الصندوق',
                              subTitle: '${widget.investmentFund.createdAt}', icon: Icons.date_range,),
                            SizedBox(width: 10,),

                            DetailsItem(title: 'الحد الأدنى للإستثمار',
                              subTitle:'${widget.investmentFund.min_invest_amount}'+' '+'ر.س', icon: Icons.monetization_on,
                            ),


                          ],
                        ),
                        widget.haveDateRange && widget.investmentFund.status == 2 ?
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:16.0),
                              child: Divider(color: Color(0xD5F1F1F1),thickness: 2.0,),
                            ),
                            Row(
                              children: [
                                DetailsItem(title:  StringConstants.startOfPeriod,
                                  subTitle: widget.investmentFund.startOfPeriod??'', icon: Icons.date_range
                                  ,),
                                SizedBox(width: 10,),
                                DetailsItem(title:
                                StringConstants.endOfPeriod,
                                  subTitle:widget.investmentFund.endOfPeriod??'', icon: Icons.event,),


                              ],
                            ),
                          ],
                        ):SizedBox()




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
                                      'صندوق عقارى استثمارى متوافق مع احكام الشريعة الاسلامية',
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
                widget.investmentFund.documents == null ||  widget.investmentFund.documents!.isEmpty  ?
                Text(StringConstants.noFiles):
                Container(
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(16.r)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: widget.investmentFund.documents?.length,
                        itemBuilder: (context,index){return Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  DocumentPdfScreen(pdf:widget.investmentFund.documents?[index]??'' ,userType: UserType.investor,)),
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
                                      '${widget.investmentFund.document_names?[index]}',

                                      style: ksmallGreyHeadingTextStyle.copyWith(fontWeight: FontWeight.w600,color: kBlackColor)),
                                ],
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                        index  ==  (widget.investmentFund.documents!.length) -1   ? SizedBox(): Padding(
                          padding: const EdgeInsets.symmetric(vertical:16.0),
                          child: Divider(color: Color(0xD5F1F1F1),thickness: 2.0,),
                        )


                      ],
                    );})
                  ),
                ),

                SizedBox(
                  height: 16.h,
                ),
                // (widget.investmentFund.status == "0" || widget.investmentFund.status == "3")
                (
                    //widget.investmentFund.status != "2" ||
                    widget.allFund == false ||
                    widget.investmentFund.invest_before == true)
                    ?Container():
                     CustomRoundedButton(
                    height: 50.h,
                    backgroundColor: kPrimaryColor,
                    textColor: kWhiteColor,
                    loading: false,
                    text: 'استثمر الآن',
                    onPressed: () {
                      Get.delete<MakeInvestmentController>(force: true);
                      Get.to(() => MakeInvestmentScreen(
                          investmentFund: widget.investmentFund.name,
                          fundId:widget.investmentFund.id,
                          minFund: widget.investmentFund.min_invest_amount,
                          remainingAmount: remainingAmount));
                    })
                    ,
                SizedBox(
                  height: 10.h,
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
              width: MediaQuery.of(context).size.width*0.25,

              child: Text(
                  title,
                  style: ksmallGreyHeadingTextStyle.copyWith(color: Color(
                      0xD5A1A1A1),fontWeight: FontWeight.w600,fontSize: 10)),
            ),

            SizedBox(height: 8,),
            Container(
              width: MediaQuery.of(context).size.width*0.25,
              // constraints: BoxConstraints(
              //   minWidth: MediaQuery.of(context).size.width*0.2,
              // ),
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


