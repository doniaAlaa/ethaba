import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/models/User_model.dart';
import 'package:ethabah/presentation/others/privacy_policy_screen.dart';
import 'package:ethabah/presentation/others/terms_condition_screen.dart';
import 'package:ethabah/presentation/screens/contact_and_support_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/edit_profile/edit_profile_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/make_investment/make_investment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvProfileScreen extends StatelessWidget {
  const InvProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        //backgroundColor: kPrimaryColor,

        body: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    //Circle Avatar
                    // CircleAvatar(
                    //   radius: 50.r,
                    //   backgroundColor: kWhiteColor,
                    //   child: Icon(
                    //     Icons.person,
                    //     size: 50.r,
                    //     color: kPrimaryColor,
                    //   ),
                    // ),
                    // SizedBox(height: 5.h),
                    //Company Name
                    FutureBuilder(
                        future: SharedPref.getUser(),

                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Container(
                                  height: 120,width: 120,
                                  decoration:BoxDecoration(
                                    color: kWhiteColor,
                                    shape: BoxShape.circle
                                  ),
                                  child:
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(50.r),
                                      child:
                                      snapshot.data?.profile_img != null ?
                                      Image.network('https://admin.ethabah.com/profile/${snapshot.data?.profile_img}',fit: BoxFit.cover ,
                                        errorBuilder: ( context,  exception,stackTrace) {
                                          return Image.asset('assets/icons/primary_person.png');
                                        },
                                      ):Image.asset('assets/icons/primary_person.png'),)

                                  // Icon(
                                  //   Icons.person,
                                  //   size: 50.r,
                                  //   color: kPrimaryColor,
                                  // ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  snapshot.data!.name,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: kFontFamily,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: kWhiteColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: kFontFamily,
                              ),
                            );
                          }
                        }),

                    SizedBox(height: 5.h),
                    // GestureDetector(
                    //   onTap: () => Get.to(() => const InvEditProfileScreen()),
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(
                    //         horizontal: 10.w, vertical: 10.h),
                    //     decoration: BoxDecoration(
                    //       color: kWhiteColor,
                    //       borderRadius: BorderRadius.circular(35.r),
                    //     ),
                    //     child: Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         //edit profile
                    //         Icon(
                    //           Icons.edit,
                    //           color: kPrimaryColor,
                    //           size: 15.r,
                    //         ),
                    //         SizedBox(width: 5.w),
                    //         Text(StringConstants.editProfile,
                    //             style: TextStyle(
                    //               fontSize: 12.sp,
                    //               color: kPrimaryColor,
                    //               fontFamily: kFontFamily,
                    //             )),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    height: 0.6.sh,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10.r,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstants.accountSettings,
                            style: ksmallGreyHeadingTextStyle,
                          ),
                          SizedBox(height: 10.h),
                          // SettingsOption(
                          //     Icons.wallet, StringConstants.paymentOptions, () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               const AddPaymentOptionScreen()));
                          // }),
                          //submit a request
                          SettingsOption(
                            Icons.edit,
                            StringConstants.editProfile,
                            () async{
                              User? user = await SharedPref.getUser();

                              // Navigator.push(
                              //   context,
                              //   new MaterialPageRoute(builder: (context) => new InvEditProfileScreen()),
                              // );
                              Get.to(() =>  InvEditProfileScreen(profile_img: user?.profile_img??'',));
                            },
                          ),
                          //SettingsOption(Icons.request_page,
                          //     StringConstants.makeAnInvestment, () {
                          //   // Navigator.push(
                          //   //     context,
                          //   //     MaterialPageRoute(
                          //   //         builder: (context) =>
                          //   //             const MakeInvestmentScreen()));
                          //   Get.to(() => const MakeInvestmentScreen());
                          // }),
                          // SettingsOption(
                          //     Icons.dashboard, StringConstants.dashboard, () {}),
                          //privacy policy
                          SettingsOption(
                              Icons.privacy_tip, StringConstants.privacyPolicy,
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PrivacyPolicyScreen()));
                            //privacy policy
                          }),

                          //terms and conditions
                          SettingsOption(
                              Icons.file_copy, StringConstants.termsAndConditions,
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsConditionScreen()));
                            //terms and conditions
                          }),
                          // SettingsOption(
                          //     Icons.phone, StringConstants.contactUs, () {}),
                          // support
                          SettingsOption(Icons.support_agent, StringConstants.contactAndSupport,
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const ContactAndSupportScreen()));                              }),

                          //logout
                          SettingsOption(Icons.logout, StringConstants.logout,
                              () {
                            SharedPref.removeUser();
                            Get.offAllNamed(RoutesConstants.authOnboard);
                          }),
                        ],
                        //dashboard
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}

Widget SettingsOption(IconData icon, String title, GestureTapCallback? onTap) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: kGreyColor.withOpacity(0.3), width: 1.5),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: kBlackColor,
                  size: 20.r,
                ),
              ),
              SizedBox(width: 20.w),
              Text(title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: kBlackColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: kFontFamily,
                  )),
              //icon at the end
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: kGreyColor,
                size: 20.r,
              ),
            ],
          ),
          SizedBox(height: 5.h),
          //divider with indent and end indent
          Divider(
            indent: 10.w,
            endIndent: 10.w,
            color: const Color.fromARGB(255, 211, 212, 215),
          ),
        ],
      ),
    ),
  );
}
