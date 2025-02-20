import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/utils/mobileNo_formatter.dart';
import 'package:ethabah/presentation/components/custom_appbar.dart';
import 'package:ethabah/presentation/components/custom_complete_inputField.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/custom_textfield.dart';
import 'package:ethabah/presentation/screens/company_flow/company_registration/company_registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyRegistrationScreen extends StatelessWidget {
  const CompanyRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyRegistrationController());
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mediumHeight(),

              const CustomAppBar(title: StringConstants.companyRegistration),
              extraLargeHeight(),
              CustomCompleteInputfield(
                  textfiledTitle: Text(
                    StringConstants.fullCompanyName,
                    // style: kTextFieldTitleStyle,
                    style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                  ),
                  textField: CustomTextField(
                    fillColor: kPrimaryColor.withOpacity(0.16),

                    controller: controller.fullCompanyNameController,
                    focusNode: controller.fcnFocusNode,
                    onSubmitted: (value) => controller.onFCNSubmitted,
                    onChanged: (value) => controller.validateFullCompanyName(),
                    hintText: StringConstants.enterFullCompanyName,
                  ),
                  errorText: controller.fullCompanyNameError),
              CustomCompleteInputfield(
                  textfiledTitle: Text(
                    StringConstants.commercialRegistrationNumber,
                    // style: kTextFieldTitleStyle,
                    style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                  ),
                  textField: CustomTextField(
                    fillColor: kPrimaryColor.withOpacity(0.16),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: controller.companyRegistrationController,
                    focusNode: controller.crFocusNode,
                    onSubmitted: (value) => controller.onCRSubmitted,
                    onChanged: (value) =>
                        controller.validateCompanyRegistration(),
                    hintText: StringConstants.enterCommercialRegistrationNumber,
                  ),
                  errorText: controller.companyRegistrationError),
              CustomCompleteInputfield(
                  textfiledTitle: Text(
                    StringConstants.emailAddress,
                    // style: kTextFieldTitleStyle,
                    style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                  ),
                  textField: CustomTextField(
                    fillColor: kPrimaryColor.withOpacity(0.16),

                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    onChanged: (value) => controller.validateEmail(),
                    hintText: StringConstants.enterEmailAddress,
                  ),
                  errorText: controller.emailError),
              // CustomCompleteInputfield(
              //     textfiledTitle: Text(
              //       StringConstants.password,
              //       // style: kTextFieldTitleStyle,
              //       style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),
              //
              //     ),
              //     textField: CustomTextField(
              //       fillColor: kPrimaryColor.withOpacity(0.16),
              //
              //       obscureText: true,
              //       keyboardType: TextInputType.visiblePassword,
              //       controller: controller.passwordController,
              //       focusNode: controller.passwordFocusNode,
              //       onChanged: (value) => controller.validatePassword(),
              //       hintText: StringConstants.enterPassword,
              //     ),
              //     errorText: controller.passwordError),
              Obx((){
                return CustomCompleteInputfield(
                  textfiledTitle: Text(
                    StringConstants.address,
                    // style: kTextFieldTitleStyle,
                    style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                  ),

                  textField: CustomTextField(
                    suffixIcon: Icon(Icons.arrow_drop_down,color: kPrimaryColor,size: 30,),
                    fillColor: kPrimaryColor.withOpacity(0.16),
                    readOnly: true,
                    onTapFunc: (){

                      showModalBottomSheet(
                          context: context,
                          backgroundColor: kWhiteColor,
                          builder: (builder){
                            return new Container(
                                height: 350.0,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent, //could change this to Color(0xFF737373),
                                //so you don't have to change MaterialApp canvasColor
                                child: FutureBuilder(
                                    future: controller.getCountries(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator(color: kPrimaryColor,));
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
                                      if (!snapshot.hasData ||
                                          snapshot.data!.data!.isEmpty ||
                                          snapshot.data == null ||
                                          snapshot.data?.data!.length == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 40),
                                          child: Text('لا توجد عناوين'),
                                        );

                                      }

                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 24,bottom: 24),
                                            child: Text(
                                              'اختر العنوان',
                                              style: ksmallGreyHeadingTextStyle.copyWith(
                                                fontSize: 16.sp,
                                                color: kBlackColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                          Container(
                                            height: 260,
                                            child: ListView.builder(
                                              //clipBehavior: Clip.none,
                                                shrinkWrap: true,

                                                // physics: const NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  final request = snapshot.data?.data[index];

                                                  return InkWell(
                                                      onTap: (){
                                                        controller.selectedIndex.value = index;
                                                        controller.selectedCountry.value  = request!.name;

                                                      },
                                                      child:Padding(
                                                          padding: const EdgeInsets.only(bottom: 24.0,right: 20,left: 20),
                                                          child: Obx((){

                                                            return Row(
                                                              children: [
                                                                Container(
                                                                  height: 15,width: 15,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      border:Border.all(color: kPrimaryColor)
                                                                  ),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(1.4),
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        color: controller.selectedIndex.value == index ?kPrimaryColor:Colors.transparent,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 12,),
                                                                Text(request!.name,style: ksmallGreyHeadingTextStyle.copyWith(
                                                                  fontSize: 16.sp,
                                                                  color: controller.selectedIndex.value == index ?kPrimaryColor:kBlackColor,
                                                                  // fontWeight: FontWeight.bold,
                                                                ),),
                                                              ],
                                                            );
                                                          })
                                                      )
                                                  );
                                                },
                                                itemCount: snapshot.data!.data.length),
                                          ),
                                        ],
                                      );


                                    })
                            );
                          }
                      );
                    },
                    controller: controller.addressController,
                    focusNode: controller.addressFocusNode,

                    // onChanged: (value) => controller.onAddressSubmitted,
                    hintText: controller.selectedCountry.value,
                  ),
                  errorText: controller.addressError,
                );
              }),

              // CustomCompleteInputfield(
              //     textfiledTitle: Text(
              //       StringConstants.phoneNumber,
              //       // style: kTextFieldTitleStyle,
              //       style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),
              //
              //     ),
              //     textField: Directionality(
              //       textDirection: TextDirection.ltr,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Container(
              //             height: 0.065.sh,
              //             width: 0.2.sw,
              //             decoration: BoxDecoration(
              //               color: kTextFieldFillColor,
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Center(
              //               child: Text(
              //                 "+966",
              //                 style: kTextFieldTitleStyle,
              //               ),
              //             ),
              //           ),
              //           smallWidth(),
              //           Expanded(
              //             child: CustomTextField(
              //               fillColor: kPrimaryColor.withOpacity(0.16),
              //
              //               inputFormatters: [
              //                 MobileNumberFormatter(),
              //               ],
              //               keyboardType: TextInputType.phone,
              //               controller: controller.phoneNumberController,
              //               focusNode: controller.phoneNumberFocusNode,
              //               onSubmitted: (value) =>
              //                   controller.onPhoneNumberSubmitted,
              //               onChanged: (value) =>
              //                   controller.validatePhoneNumber(),
              //               hintText: StringConstants.enterPhoneNumber,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     errorText: controller.phoneNumberError),
              // Directionality(
              //   textDirection: TextDirection.rtl,
              //   child: Obx(() => CustomRoundedButton(
              //       backgroundColor: kPrimaryColor,
              //       height: 0.065.sh,
              //       width: 0.5.sw,
              //       textColor: kWhiteColor,
              //       shadow: true,
              //       loading: controller.isOTPsendLoading.value,
              //       text: StringConstants.sendOTP,
              //       onPressed: () {
              //         controller.registerPhoneNumber();
              //       })),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // CustomCompleteInputfield(
              //   textfiledTitle: Text(
              //     StringConstants.enterOTP,
              //     // style: kTextFieldTitleStyle,
              //     style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),
              //
              //   ),
              //   textField: CustomTextField(
              //     fillColor: kPrimaryColor.withOpacity(0.16),
              //
              //     inputFormatters: [
              //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              //       LengthLimitingTextInputFormatter(6),
              //     ],
              //     keyboardType: TextInputType.number,
              //     controller: controller.otpController,
              //     focusNode: controller.otpFocusNode,
              //     hintText: StringConstants.enterOTP,
              //   ),
              //   errorText: controller.otpError,
              // ),
              mediumHeight(),
              Center(
                child: TextButton(
                    onPressed: () {
                      //TODO:
                      // controller.validateAndSubmit(context);
                      Get.toNamed(RoutesConstants.accountVerification, arguments: {
                        'fullCompanyName': controller.fullCompanyNameController.text,
                        'companyRegistration': controller.companyRegistrationController.text,
                        'phoneNumber': controller.phoneNumberController.text,
                        'address': controller.selectedCountry.value,
                        'email': controller.emailController.text,
                        'password': controller.passwordController.text,
                      });
                       },
                    child: Text(
                      "${StringConstants.next}>>",
                      style: kTextFieldTitleStyle,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
