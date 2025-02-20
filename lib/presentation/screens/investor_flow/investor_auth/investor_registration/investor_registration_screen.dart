import 'dart:io';

import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/utils/mobileNo_formatter.dart';
import 'package:ethabah/presentation/components/custom_appbar.dart';
import 'package:ethabah/presentation/components/custom_complete_inputField.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/custom_textfield.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/file_verification/file_verification_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/inverstor_reg_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/profile_pic/profile_pic_screen.dart';
import 'package:ethabah/presentation/screens/onboard/auth_onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InvestorRegistrationScreen extends StatefulWidget {
  const InvestorRegistrationScreen({super.key});

  @override
  State<InvestorRegistrationScreen> createState() => _InvestorRegistrationScreenState();
}

class _InvestorRegistrationScreenState extends State<InvestorRegistrationScreen> {
  XFile? img;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvestorRegistrationController());
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mediumHeight(),

              const CustomAppBar(title: StringConstants.investorRegistration),
              extraLargeHeight(),
              Center(
                child: InkWell(
                  onTap: () async{
                    final ImagePicker picker = ImagePicker();
                    img = await picker.pickImage(
                      source: ImageSource.gallery, // alternatively, use ImageSource.gallery
                      maxWidth: 400,
                    );
                    controller.img = img;
                    setState(() {

                    });
                  },
                  child: Stack(
                    // alignment: Alignment.bottomRight,
                    children: [
                      Container(
                          height: 140,width: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: kPrimaryColor,width: 2),
                            color:kPrimaryColor.withOpacity(0.16),
                          ),
                          child:img != null ?ClipRRect(
                              borderRadius: BorderRadius.circular(100000),
                              child: Image.file(File(img!.path),fit: BoxFit.cover,)):
                          Icon(Icons.account_circle_sharp,color: kPrimaryColor,size: 80,)
                        //Image.asset('assets/icons/primary_person.png',scale: 1.5,),
                        // Padding(
                        //   padding: const EdgeInsets.all(30.0),
                        //   child: SvgPicture.asset('assets/icons/person.svg',fit: BoxFit.contain,),
                        // ),
                      ),
                      InkWell(
                        onTap: () async{
                          if(img != null ){
                            img = null;
                            controller.img = null;
                            setState(() {});
                            print('object');
                          }else{
                            final ImagePicker picker = ImagePicker();
                            img = await picker.pickImage(
                              source: ImageSource.gallery, // alternatively, use ImageSource.gallery
                              maxWidth: 400,
                            );
                            controller.img = img;
                            setState(() {

                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:100.0),
                          child: Container(
                            height: 35,width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: kPrimaryColor,width: 2),
                              color:kPrimaryColor,
                            ),
                            child: Icon(img != null ?Icons.remove: Icons.add,color: kWhiteColor,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
              CustomCompleteInputfield(
                textfiledTitle: Text(
                  StringConstants.name,
                  // style: kTextFieldTitleStyle,
                  style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                ),
                textField: CustomTextField(
                  fillColor: kPrimaryColor.withOpacity(0.16),

                  controller: controller.nameController,
                  focusNode: controller.nameFocusNode,
                  onSubmitted: (value) => controller.onNameSubmitted(),
                  onChanged: (value) => controller.validateName(),
                  hintText: StringConstants.enterName,
                ),
                errorText: controller.nameError,
              ),
              CustomCompleteInputfield(
                textfiledTitle: Text(
                  StringConstants.nationalId,
                  // style: kTextFieldTitleStyle,
                  style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                ),
                textField: CustomTextField(
                  fillColor: kPrimaryColor.withOpacity(0.16),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 10,
                  controller: controller.nationalIDController,
                  // focusNode: controller.nameFocusNode,
                  // onSubmitted: (value) => controller.onNameSubmitted(),
                  onChanged: (value) => controller.validateNationalID(),
                  hintText: StringConstants.enterNationalId,
                ),
                errorText: controller.nationalIDError,
              ),

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
                  onSubmitted: (value) => controller.onEmailSubmitted(),
                  onChanged: (value) => controller.validateEmail(),
                  hintText: StringConstants.enterEmailAddress,
                ),
                errorText: controller.emailError,
              ),
              // CustomCompleteInputfield(
              //   textfiledTitle: Text(
              //     StringConstants.password,
              //     // style: kTextFieldTitleStyle,
              //     style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),
              //
              //   ),
              //   textField: CustomTextField(
              //     fillColor: kPrimaryColor.withOpacity(0.16),
              //
              //     obscureText: true,
              //     controller: controller.passwordController,
              //     focusNode: controller.passwordFocusNode,
              //     onSubmitted: (value) => controller.onPasswordSubmitted(),
              //     onChanged: (value) => controller.validatePassword(),
              //     hintText: StringConstants.enterPassword,
              //   ),
              //   errorText: controller.passwordError,
              // ),
              // CustomCompleteInputfield(
              //   textfiledTitle: Text(
              //     StringConstants.passwordConfirmation,
              //     // style: kTextFieldTitleStyle,
              //     style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),
              //
              //   ),
              //   textField: CustomTextField(
              //     fillColor: kPrimaryColor.withOpacity(0.16),
              //
              //     obscureText: true,
              //     controller: controller.passwordConfirmationController,
              //     focusNode: controller.passwordConfirmationFocusNode,
              //     onSubmitted: (value) =>
              //         controller.onPasswordConfirmationSubmitted(),
              //     onChanged: (value) =>
              //         controller.validatePasswordConfirmation(),
              //     hintText: StringConstants.enterPasswordConfirmation,
              //   ),
              //   errorText: controller.passwordConfirmationError,
              // ),
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
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                                ),
                                //could change this to Color(0xFF737373),
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
              //               controller: controller.phoneController,
              //               focusNode: controller.phoneFocusNode,
              //               onSubmitted: (value) => controller.onPhoneSubmitted,
              //               onChanged: (value) => controller.validatePhone(),
              //               hintText: StringConstants.enterPhoneNumber,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     errorText: controller.phoneError),
              // //Send OTP Button
              // Directionality(
              //   textDirection: TextDirection.rtl,
              //   child: Obx(() => CustomRoundedButton(
              //       backgroundColor: kPrimaryColor,
              //       height: 0.065.sh,
              //       width: 0.5.sw,
              //
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
              // //OTP TextField (6 Digits max - only numbers)
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
              // Center(
              //   child: Obx(() {
              //     return CustomRoundedButton(
              //       loading: controller.isLoading.value,
              //       text: StringConstants.next,
              //       onPressed: () {
              //         controller.registerInvestor();
              //       },
              //       textColor: kWhiteColor,
              //       backgroundColor: kPrimaryColor,
              //     );
              //   }),
              // ),
              // Center(
              //   child: Obx(
              //     () => controller.isOtpVerifyLoading.value
              //         ? const CircularProgressIndicator(
              //             color: kPrimaryColor,
              //           )
              //         : TextButton(
              //             onPressed: () {
              //               //TODO:
              //               controller.validateAndSubmit(context);
              //               // Navigator.push(
              //               //     context,
              //               //     MaterialPageRoute(
              //               //         builder: (context) => FileVerificationScreen(controller: controller)));
              //               //
              //               // Navigator.push(
              //               //     context,
              //               //     MaterialPageRoute(
              //               //         builder: (context) => ProfilePicScreen(controller: controller)));
              //               //
              //             },
              //             child: Text(
              //               "${StringConstants.verify}>>",
              //               style: kTextFieldTitleStyle,
              //             )),
              //   ),
              // ),
              Obx(() {
                return CustomRoundedButton(
                  backgroundColor: kPrimaryColor,
                  textColor: kWhiteColor,
                  loading: controller.isLoading.value,
                  text: StringConstants.submit,
                  onPressed: (){
                     controller.registerSubmit(context);

                  },
                );
              }),
              SizedBox(height: 24,)
            ],
          ),
        ),
      ),
    );
  }
}
