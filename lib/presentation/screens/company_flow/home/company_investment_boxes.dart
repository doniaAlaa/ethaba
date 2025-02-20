import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/remote/invesment_fund.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/User_model.dart';
import 'package:ethabah/models/all_investment_fund_model.dart';
import 'package:ethabah/presentation/components/funding_req_widget.dart';
import 'package:ethabah/presentation/components/investmentfunds_card.dart';
import 'package:ethabah/presentation/screens/company_flow/company_funds/company_fund_details.dart';
import 'package:ethabah/presentation/screens/company_flow/company_funds/company_fund_item_block.dart';
import 'package:ethabah/presentation/screens/company_flow/company_requests/company_request_details.dart';
import 'package:ethabah/presentation/screens/company_flow/home/empty_requests.dart';
import 'package:ethabah/presentation/screens/company_flow/home/home_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/widget/home_app_bar_icon.dart';
import 'package:ethabah/presentation/screens/investor_flow/investment_fund_details/investment_fund_details_screen2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class CompanyInvestmentBoxes extends StatefulWidget {
  const CompanyInvestmentBoxes({super.key});

  @override
  State<CompanyInvestmentBoxes> createState() => _CompanyInvestmentBoxesState();
}

class _CompanyInvestmentBoxesState extends State<CompanyInvestmentBoxes> {
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
                        Get.toNamed(RoutesConstants.profileScreen);

                      },):SizedBox(),
                      Text(StringConstants.boxes,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Text(
                        'الصناديق الخاصة بالشركة',
                        style: kSubHeadingTextStyle.copyWith(
                          color: kBlackColor,
                          fontSize: 16.sp,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 20.h),

                      FutureBuilder(
                          future: controller.getCompanyFund(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator(color: kPrimaryColor,));
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.isEmpty ||
                                snapshot.data == null ||
                                snapshot.data?.length == 0) {
                              return EmptyRequests();

                            }
                            return Expanded(
                              child: ListView.builder(
                                //clipBehavior: Clip.none,
                                  shrinkWrap: true,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final request = snapshot.data![index];

                                    return GestureDetector(
                                      onTap: () {
                                        // Get.toNamed(
                                        //   RoutesConstants.projectDetailsCompany,
                                        //   arguments: request,
                                        // );

                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) =>  CompanyFundDetails(investmentFundCompany: snapshot.data![index],)),
                                        );
                                      },
                                      child: CompanyFundItemBlock(investmentFundCompany: snapshot.data![index],)
                                    );
                                  },
                                  itemCount: snapshot.data!.length),
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

String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

class ShinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.0),
          Colors.white.withOpacity(0.25),
          Colors.white.withOpacity(0.0),
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
