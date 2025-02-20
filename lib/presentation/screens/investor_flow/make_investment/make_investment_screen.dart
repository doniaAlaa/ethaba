import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/models/investment_dropdown_model.dart';
import 'package:ethabah/presentation/components/custom_complete_inputField.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/custom_textfield.dart';
import 'package:ethabah/presentation/screens/investor_flow/make_investment/make_investment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MakeInvestmentScreen extends StatelessWidget {
  final String? investmentFund;
  final double? remainingAmount;
  final int? fundId;
  final String? minFund;

  const MakeInvestmentScreen(
      {this.investmentFund, this.remainingAmount, this.fundId,super.key,this.minFund});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MakeInvestmentController());
    if (investmentFund != null) {
      controller.assignInvesmentFundToDropDown(investmentFund!);
      controller.remainingAmount = remainingAmount!;
    }
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          StringConstants.makeAnInvestment,
          style: kSubtitleTextStyle.copyWith(
            // color: kNeonColor,
            color: kWhiteColor,

            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kWhiteColor,
            // color: kNeonColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              CustomCompleteInputfield(
                  textfiledTitle:
                      Text(StringConstants.amount, style: kTextFieldTitleStyle),
                  textField: CustomTextField(
                      fillColor: kPrimaryColor.withOpacity(0.16),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: controller.amountController,
                      focusNode: controller.amountFocusNode,
                      hintText: StringConstants.enterAmount,
                      onSubmitted: (value) {
                        controller.amountFocusNode.unfocus();
                      }),
                  errorText: controller.amountError),
              SizedBox(height: 10.h),
              Obx(() => controller.investmentFundError.value != ""
                  ? Text(
                      controller.investmentFundError.value,
                      style: kErrorTextStyle,
                    )
                  : Container()),
              SizedBox(height: 10.h),
              Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(StringConstants.paymentReceipt, style: kTextFieldTitleStyle),
                  SizedBox(height: 8,),
                  GestureDetector(
                    onTap: () => controller.pickFile(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        // color: kTextFieldFillColor,
                        color: kPrimaryColor.withOpacity(0.16),

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.upload_file, color: kPrimaryColor),
                          SizedBox(width: 10.w),
                          Flexible(
                            child: Text(
                              controller.selectedFile.value != null
                                  ? controller.selectedFile.value!.path
                                  .split('/')
                                  .last
                                  : StringConstants.noFileChosen,
                              style: kHintTextStyle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  controller.fileValidated.value == true?
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text(
                      StringConstants.paymentImgValidation,
                      style: kErrorTextStyle,
                    ),
                  ):Container()
                ],
              )),
              // Obx(() => controller.fileError.value != ""
              //     ? Text(
              //   controller.fileError.value,
              //   style: kErrorTextStyle,
              // )
              //     : Container()),

              SizedBox(height: 30.h),
              Obx(() => CustomRoundedButton(
                  backgroundColor: kPrimaryColor,
                  textColor: kWhiteColor,
                  loading: controller.isLoading.value,
                  text: StringConstants.submit,
                  onPressed: () {

                    if (controller.validateForm(int.parse(minFund??''))) {
                      controller.onSubmit(context,fundId??0,int.parse(minFund??''));
                    }
                  })),
              SizedBox(height: 30.h),
              InkWell(
                onTap: (){
                      Get.toNamed(RoutesConstants.bankAccountDataScreen);

                },
                child: Row(
                  children: [
                    Text(
                      'الذهاب إلى بيانات التحويل البنكي',
                      style: ksmallGreyHeadingTextStyle.copyWith(color: kPrimaryColor,fontWeight: FontWeight.w900,fontSize: 12),
                    ),
                    SizedBox(width: 6,),
                    Icon(Icons.arrow_forward,color: kPrimaryColor,)
                  ],
                ),
              ),
              // InkWell(
              //   onTap: (){
              //     Get.toNamed(RoutesConstants.bankAccountDataScreen);
              //
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: kPrimaryColor,
              //       borderRadius: BorderRadius.circular(12)
              //
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12),
              //       child: Text(
              //         'بيانات التحويل البنكي',
              //         style: ksmallGreyHeadingTextStyle.copyWith(color: kWhiteColor),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
