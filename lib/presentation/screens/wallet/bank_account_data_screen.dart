import 'package:ethabah/controller/wallet_controller.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/remote/admin_bank_account_provider.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';
import 'package:ethabah/presentation/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminBankAccountDataScreen extends StatelessWidget {
  const AdminBankAccountDataScreen({super.key});

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
              child: const CustomAppBar(title: StringConstants.walletData,titleColor: kWhiteColor,iconColor: kWhiteColor,),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(StringConstants.copyData,style: ksmallHeadTextStyle.copyWith(color: kBlackColor.withOpacity(0.55),fontSize: 15,fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(height: 20,),


                      FutureBuilder<AdminBankDataModel>(
                          future: controller.getAdminBankData(),
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
                              return const Center(
                                child: const Text(
                                    StringConstants.noData,
                                    style: TextStyle(
                                        color: kPrimaryColor, fontSize: 20)),
                              );
                            }
                            BankData? bankData =
                                snapshot.data!.data;
                            return Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  mediumHeight(),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(StringConstants.accountDetails,style: ksmallHeadTextStyle.copyWith(color: kBlackColor,fontSize: 16,fontWeight: FontWeight.w800)),
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

                                          AccountItemData(title:StringConstants.iban ,subTitle: bankData?.iban_number??"",),

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
            InkWell(
                onTap: () async{
                  await Clipboard.setData(ClipboardData(text: subTitle));
                  Get.snackbar(
                    StringConstants.done,
                    StringConstants.copyDone,

                    snackPosition: SnackPosition.TOP,
                    margin: const EdgeInsets.all(10),
                    backgroundColor: Colors.white,
                    colorText: Colors.black,
                  );
                },
                child: Row(
                  children: [
                    Text(StringConstants.copy,style: ksmallHeadTextStyle.copyWith(color: kBlackColor,fontSize: 10,fontWeight: FontWeight.w900)),
                    SizedBox(width: 4,),
                    Icon(Icons.copy,color: kPrimaryColor,),

                  ],
                ))
          ],
        )
      ],
    );
  }
}
