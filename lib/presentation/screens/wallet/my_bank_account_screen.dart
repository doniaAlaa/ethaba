import 'package:ethabah/controller/add_bank_account_controller.dart';
import 'package:ethabah/controller/wallet_controller.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/remote/admin_bank_account_provider.dart';
import 'package:ethabah/models/User_model.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';
import 'package:ethabah/presentation/components/custom_appbar.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/otp%20view/verify_code_screen.dart';
import 'package:ethabah/presentation/screens/wallet/add_bank_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyBankAccountScreen extends StatelessWidget {
  const MyBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WalletController controller = Get.put(WalletController());
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
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
            mediumHeight(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child:  CustomAppBar(title: StringConstants.myAccount,titleColor: kWhiteColor,iconColor: kWhiteColor,),
            ),


            mediumHeight(),


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
                  padding: const EdgeInsets.only(right: 16.0,left: 16,top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [



                      FutureBuilder<BankData?>(
                          future: controller.loadUserProfile(),
                          builder: (contex, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            }

                            if (snapshot.hasError) {
                              return SizedBox(
                                height: 250.h,
                                child: Center(
                                  child: Text(
                                    StringConstants.somethingWentWrong,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                        fontSize: 20.sp),
                                  ),
                                ),
                              );
                            }
                            if (snapshot.data == null ) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/icons/no_data.png',scale: 0.6,),
                                    SizedBox(height: 20,),
                                    const Center(
                                      child: const Text(
                                          StringConstants.noData,
                                          style: TextStyle(
                                              color: kPrimaryColor, fontSize: 20)),
                                    ),
                                  ],
                                ),
                              );
                            }
                            BankData? bankData = snapshot.data;
                            return Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  mediumHeight(),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(StringConstants.myAccountDetails,style: ksmallHeadTextStyle.copyWith(color: kBlackColor,fontSize: 16,fontWeight: FontWeight.w800)),
                                  ),

                                  mediumHeight(),

                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.r),
                                      ),
                                      color: kWhiteColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [



                                          AccountItemData(title:StringConstants.accountName ,subTitle:bankData?.account_name??"",),
                                          mediumHeight(),
                                          mediumHeight(),
                                          mediumHeight(),

                                          AccountItemData(title:StringConstants.iban ,subTitle: bankData?.iban_number??'',),

                                          mediumHeight(),
                                          mediumHeight(),
                                          mediumHeight(),

                                          AccountItemData(title:StringConstants.accountNumber ,subTitle: bankData?.account_number??"",),


                                        ],
                                      ),
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


          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Obx((){

            return controller.appearButton != -1 ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
              child: CustomRoundedButton(
                loading: false,
                text: controller.appearButton == 1 ? StringConstants.addBankAccount: StringConstants.updateBankAccount,
                onPressed: () {
                  Get.delete<AddBankAccountController>(force: true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  EnterOTP(type: 'verifyMyBankAccount',isEditing: controller.appearButton == 1?false:true,myBankData:controller.myData)),
                  );
                },
                textColor: kWhiteColor,
                backgroundColor: kPrimaryColor,
              ),
            ):Container();})

      ),

    );
  }
}

class AccountItemData extends StatelessWidget {
  final String title;
  final String subTitle;
  const AccountItemData({super.key,required this.title,required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(title,style: ksmallHeadTextStyle.copyWith(color: kBlackColor.withOpacity(0.4),fontSize: 11,fontWeight: FontWeight.w600)),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(subTitle,style: ksmallHeadTextStyle.copyWith(color: kBlackColor,fontSize: 14,fontWeight: FontWeight.w800)),

          ],
        )
      ],
    );
  }
}
