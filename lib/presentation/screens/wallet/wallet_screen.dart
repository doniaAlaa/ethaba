import 'package:ethabah/controller/wallet_controller.dart';
import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/constants/test_scale.dart';
import 'package:ethabah/models/wallet_transactions_model.dart';
import 'package:ethabah/presentation/screens/company_flow/home/empty_requests.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/widget/home_app_bar_icon.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/otp%20view/verify_code_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/otp%20view/verify_code_screen.dart';
import 'package:ethabah/presentation/screens/wallet/empty_transactions.dart';
import 'package:ethabah/presentation/screens/wallet/my_bank_account_screen.dart';
import 'package:ethabah/presentation/screens/wallet/previous_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WalletController controller = Get.put(WalletController(),permanent: true);
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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // HomeAppBarIcon(iconImage: 'assets/icons/profile.png',onTapFunc: (){
                      // Get.toNamed(RoutesConstants.profileScreen);
                      //
                      // },),
                      Text(StringConstants.myWallet,style: ksmallHeadTextStyle.copyWith(color: kWhiteColor,fontSize: 18,fontWeight: FontWeight.w800)),

                       // HomeAppBarIcon(iconImage: 'assets/icons/notification.png',onTapFunc: (){},),

                    ],
                  ),
                ),
              ),
              // color: Colors.red,
            ),

            SizedBox(height: 6,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WalletHeaderBlock(title: StringConstants.walletData,onTap:(){
                    Get.toNamed(RoutesConstants.bankAccountDataScreen);

                  } ,),
                  SizedBox(width: 16,),
                  WalletHeaderBlock(title:StringConstants.myAccount,onTap: (){
                    controller.appearButton.value = -1.obs;
                    Get.delete<VerifyCodeController>(force: true);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>  EnterOTP(type: 'verifyMyBankAccount')),
                    // );
                    Get.toNamed(RoutesConstants.myBankAccountScreen,);


                  },)
                ],
              ),
            ),
            mediumHeight(),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Obx((){
                        return Center(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),

                                        'مجموع المبلغ المستثمر',style: ksmallHeadTextStyle.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w800)),
                                    SizedBox(height: 10,),
                                    Center(child: Text(
                                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),

                                        controller.allInvestAmount.value,style: ksmallHeadTextStyle.copyWith(color: kPrimaryColor,fontSize: 18,fontWeight: FontWeight.w800))),

                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 60,
                                    width: 1.5,
                                    color: kBlackColor.withOpacity(0.4),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    Text(
                                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),

                                        'مجموع المبلغ المسترد',style: ksmallHeadTextStyle.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w800)),
                                    SizedBox(height: 10,),

                                    Text(
                                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),

                                        controller.allBackAmount.value,style: ksmallHeadTextStyle.copyWith(color: kPrimaryColor,fontSize: 18,fontWeight: FontWeight.w800)),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 30,),

                      Text('العمليات السابقة',style: ksmallHeadTextStyle.copyWith(fontSize: 20,fontWeight: FontWeight.w800)),

                      FutureBuilder(
                          future: controller.getWalletTransactionData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: CircularProgressIndicator(color: kPrimaryColor,),
                              ));
                            }
                            if (!snapshot.hasData ||
                                // snapshot.data!.data != null ||
                                snapshot.data!.data.isEmpty ||
                                snapshot.data?.data.length == 0 || snapshot.data?.data.first.id == null ) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: EmptyTransactions(),
                              );

                            }
                            return Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Center(
                                  //   child: Container(
                                  //     child: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                  //       children: [
                                  //         Column(
                                  //           mainAxisAlignment: MainAxisAlignment.center,
                                  //           crossAxisAlignment: CrossAxisAlignment.center,
                                  //           children: [
                                  //             Text(
                                  //                 textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                  //
                                  //                 'مجموع المبلغ المستثمر',style: ksmallHeadTextStyle.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w800)),
                                  //             SizedBox(height: 10,),
                                  //             Center(child: Text(
                                  //                 textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                  //
                                  //                 '${snapshot.data?.total?.first.all_paid}'+' '+'ر.س',style: ksmallHeadTextStyle.copyWith(color: kPrimaryColor,fontSize: 18,fontWeight: FontWeight.w800))),
                                  //
                                  //           ],
                                  //         ),
                                  //         Padding(
                                  //           padding: const EdgeInsets.all(8.0),
                                  //           child: Container(
                                  //             height: 60,
                                  //             width: 1.5,
                                  //             color: kBlackColor.withOpacity(0.4),
                                  //           ),
                                  //         ),
                                  //         Column(
                                  //           mainAxisAlignment: MainAxisAlignment.center,
                                  //           crossAxisAlignment: CrossAxisAlignment.center,
                                  //
                                  //           children: [
                                  //             Text(
                                  //                 textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                  //
                                  //                 'مجموع المبلغ المسترد',style: ksmallHeadTextStyle.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w800)),
                                  //             SizedBox(height: 10,),
                                  //
                                  //             Text(
                                  //                 textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                  //
                                  //                 '${snapshot.data?.total?.first.all_recieved}'+' '+'ر.س',style: ksmallHeadTextStyle.copyWith(color: kPrimaryColor,fontSize: 18,fontWeight: FontWeight.w800)),
                                  //
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(height: 30,),
                                  //
                                  // Text('العمليات السابقة',style: ksmallHeadTextStyle.copyWith(fontSize: 20,fontWeight: FontWeight.w800)),

                                  Container(
                                    height: MediaQuery.of(context).size.height*0.45,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:20.0),
                                      child: ListView.builder(
                                        //clipBehavior: Clip.none,
                                          shrinkWrap: true,
                                          // physics: const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            TransactionData data = snapshot.data!.data[index];

                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 16.0),
                                              child: PreviousTransactionItem(transactionData: data,),
                                            );
                                          },
                                          itemCount: snapshot.data!.data.length),
                                    ),
                                  ),
                                ],
                              ),
                            );

                          }),


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

class WalletHeaderBlock extends StatelessWidget {
  final String title;
  final Function() onTap;
   WalletHeaderBlock({super.key,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (){
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kWhiteColor.withOpacity(0.6))
          ),
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 6),
                  child: Icon(Icons.display_settings_outlined,color: kWhiteColor,size: 16.sp,),
                ),
                Text(title,style: ksmallHeadTextStyle.copyWith(color: kWhiteColor,fontSize: 10.sp,fontWeight: FontWeight.w600)),
                SizedBox(),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
