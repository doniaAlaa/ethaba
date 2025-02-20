import 'dart:developer';

import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/remote/invesment_fund.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/User_model.dart';
import 'package:ethabah/models/project_doc.dart';
import 'package:ethabah/models/req_investment_fund_model.dart';
import 'package:ethabah/presentation/components/funding_req_widget.dart';
import 'package:ethabah/presentation/screens/company_flow/company_requests/company_request_details.dart';
import 'package:ethabah/presentation/screens/company_flow/company_requests/company_request_item_block.dart';
import 'package:ethabah/presentation/screens/company_flow/home/empty_requests.dart';
import 'package:ethabah/presentation/screens/company_flow/home/home_controller.dart';
import 'package:ethabah/presentation/screens/company_flow/home/home_screen.dart';
import 'package:ethabah/presentation/screens/company_flow/projects/empty_order.dart';
import 'package:ethabah/presentation/screens/company_flow/projects/project_screen_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/inv_home_screen_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/widget/home_app_bar_icon.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/widget/my_investments_data_block.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/widget/req_invest_fund_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

class CompanyRequestsScreen extends StatefulWidget {
  const CompanyRequestsScreen({super.key});

  @override
  State<CompanyRequestsScreen> createState() => _CompanyRequestsScreenState();
}

class _CompanyRequestsScreenState extends State<CompanyRequestsScreen> with RouteAware{
  // bool isLoggedIn = true;

  final controller = Get.put(ProjectScreenController());
  final catController = Get.isRegistered<CategoriesController>()
      ? Get.find<CategoriesController>()
      : Get.put(CategoriesController());
  RxString comapnyName = "".obs;

  String getDateFormatted() {
    final DateTime now = DateTime.now();
    final intl.DateFormat formatter = intl.DateFormat('dd MMM yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }


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
    getCompanyName();


  }
  getCompanyName() async {
    final user = await SharedPref.getUser();
    comapnyName.value = user?.name ?? "";
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
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
            Obx((){
              return Container(
                height:MediaQuery.of(context).size.height*0.32,
                child: Padding(
                    padding:  EdgeInsets.only(top: 40.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isLoggedIn?
                              HomeAppBarIcon(iconImage: 'assets/icons/profile.png',onTapFunc: (){
                                Get.toNamed(RoutesConstants.profileScreen);

                              },):SizedBox(),
                              Text('الطلبات الإستثمارية',
                                style: ksmallHeadTextStyle.copyWith(color: kWhiteColor,fontSize: 18,fontWeight: FontWeight.w800),),

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
                        SizedBox(height: 24.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              MyInvestmentsDataBlock(title: '${controller.totalFunds.value}'+' '+'ر.س', subTitle: StringConstants.totalFunds, itemIcon: Icons.inventory_sharp,),
                              SizedBox(width: 10.h,),
                              MyInvestmentsDataBlock(title: '${controller.acceptedReq.value}', subTitle:StringConstants.acceptedReq, itemIcon: Icons.layers,),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              MyInvestmentsDataBlock(title: '${controller.rejectedReq.value}', subTitle: StringConstants.rejectedReq, itemIcon: Icons.layers,),
                              SizedBox(width: 10.h,),
                              MyInvestmentsDataBlock(title: '${controller.pendingReq.value}', subTitle:StringConstants.pendingReq, itemIcon: Icons.layers,),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h,),

                      ],
                    )
                ),
                // color: Colors.red,
              );
            }),

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.6,
                            child: Text(
                              'الطلبات الإستثمارية الخاصة بالشركة :',
                              style: kSubHeadingTextStyle.copyWith(
                                color: kBlackColor,
                                fontSize: 14.sp,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                               Get.toNamed(RoutesConstants.submitRequest);

                            },
                            child: Container(
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
                              child: Center(child: Text(StringConstants.addRequest,style: TextStyle(color: kWhiteColor),)),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),



                      FutureBuilder(
                          future: controller.getCompanyRequest(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator(color: kPrimaryColor,));
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.data!.isEmpty ||
                                snapshot.data == null ||
                                snapshot.data?.data!.length == 0) {
                              return EmptyRequests();

                            }

                            return Expanded(
                              child: ListView.builder(
                                //clipBehavior: Clip.none,
                                  shrinkWrap: true,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final request = snapshot.data?.data[index];

                                    return InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) =>  CompanyRequestDetails(requestModel: snapshot.data!.data[index],)),
                                          );
                                        },
                                        child:
                                        CompanyRequestItemBlock(requestModel: snapshot.data!.data[index],isLogged: isLoggedIn??false,)
                                          );
                                  },
                                  itemCount: snapshot.data!.data.length),
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

Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> _downloadAllFiles(List<String> urls) async {
  for (String url in urls) {
    await _launchURL(url);
  }
}