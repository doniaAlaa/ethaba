import 'dart:developer';

import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/presentation/screens/company_flow/profile/edit_company_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/presentation/components/custom_complete_inputField.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/custom_textfield.dart';
import 'package:ethabah/presentation/components/upload_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

class EditCompanyProfileScreen extends StatelessWidget {
   EditCompanyProfileScreen({super.key});

  Widget? prefix;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditCompanyProfileController());
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
          StringConstants.editProfile,
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

      body: Obx(
        () => controller.isDataLoading.value
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                  ),
                  CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ],
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mediumHeight(),
                      CustomCompleteInputfield(
                        textfiledTitle: Text(
                          StringConstants.name,
                          style: kTextFieldTitleStyle,
                        ),
                        textField: CustomTextField(
                          fillColor: kPrimaryColor.withOpacity(0.16),

                          controller: controller.nameController,
                          focusNode: controller.nameFocusNode,
                          onSubmitted: (value) =>
                              controller.nameFocusNode.unfocus(),
                          onChanged: (value) => controller.validateName(),
                          hintText: StringConstants.enterName,
                        ),
                        errorText: controller.nameError,
                      ),
                      CustomCompleteInputfield(
                        textfiledTitle: Text(
                          StringConstants.emailAddress,
                          style: kTextFieldTitleStyle,
                        ),
                        textField: CustomTextField(
                          fillColor: kPrimaryColor.withOpacity(0.16),

                          keyboardType: TextInputType.emailAddress,
                          controller: controller.emailController,
                          focusNode: controller.emailFocusNode,
                          onSubmitted: (value) =>
                              controller.emailFocusNode.unfocus(),
                          onChanged: (value) => controller.validateEmail(),
                          hintText: StringConstants.enterEmailAddress,
                        ),
                        errorText: controller.emailError,
                      ),
                      //password
                      // CustomCompleteInputfield(
                      //   textfiledTitle: Text(
                      //     StringConstants.password,
                      //     style: kTextFieldTitleStyle,
                      //   ),
                      //   textField: CustomTextField(
                      //     fillColor: kPrimaryColor.withOpacity(0.16),
                      //
                      //     controller: controller.passwordController,
                      //     focusNode: controller.passwordFocusNode,
                      //     onSubmitted: (value) =>
                      //         controller.passwordFocusNode.unfocus(),
                      //     onChanged: (value) => controller.validatePassword(),
                      //     hintText: StringConstants.enterPassword,
                      //     obscureText: true,
                      //   ),
                      //   errorText: controller.passwordError,
                      // ),
                      StatefulBuilder(
                        builder: (context,setState) {
                          return CustomCompleteInputfield(
                            textfiledTitle: Text(
                              StringConstants.phoneNumber,
                              style: kTextFieldTitleStyle,
                            ),
                            textField: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 0.065.sh,
                                    width: 0.2.sw,
                                    decoration: BoxDecoration(
                                      color: kTextFieldFillColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "+966",
                                        style: kTextFieldTitleStyle,
                                      ),
                                    ),
                                  ),
                                  smallWidth(),
                                  Expanded(
                                    child: CustomTextField(
                                      readOnly: true,
                                      fillColor: kPrimaryColor.withOpacity(0.16),
                                       // maxLength:prefix != null? 8:9,
                                       maxLength:9,
                                      keyboardType: TextInputType.phone,
                                      controller: controller.phoneController,
                                      focusNode: controller.phoneFocusNode,
                                      onSubmitted: (value) =>
                                          controller.phoneFocusNode.unfocus(),
                                      // onChanged: (value) =>
                                      //     controller.validatePhone(),
                                      onTapFunc: (){
                                        Get.snackbar(
                                          StringConstants.forbidden,
                                          StringConstants.contactWithSupportForPhone,
                                          backgroundColor: kNeonColor,
                                          colorText: Colors.black,
                                        );
                                      },
                                      // prefix: prefix,
                                      onChanged: (value){
                                        // if(value.length == 1){
                                        //
                                        //
                                        //   setState(() {
                                        //     prefix = Padding(
                                        //       padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                        //       child: Text('5'),
                                        //     );
                                        //
                                        //   });
                                        // }else if(value.length == 0){
                                        //
                                        //   setState(() {
                                        //     prefix = null;
                                        //   });
                                        // }
                                        controller.validatePhone();
                                      },

                                      hintText: StringConstants.enterPhoneNumber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            errorText: controller.phoneError,
                          );
                        }
                      ),
                      // CustomCompleteInputfield(
                      //   textfiledTitle: Text(
                      //     StringConstants.address,
                      //     style: kTextFieldTitleStyle,
                      //   ),
                      //   textField: CustomTextField(
                      //     fillColor: kPrimaryColor.withOpacity(0.16),
                      //
                      //     controller: controller.addressController,
                      //     focusNode: controller.addressFocusNode,
                      //     onSubmitted: (value) =>
                      //         controller.addressFocusNode.unfocus(),
                      //     onChanged: (value) => controller.validateAddress(),
                      //     hintText: StringConstants.enterAddress,
                      //   ),
                      //   errorText: controller.addressError,
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
                                                                controller.addressController.text = request.name;
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
                      CustomCompleteInputfield(
                        textfiledTitle: Text(
                          StringConstants.companyRegistration,
                          style: kTextFieldTitleStyle,
                        ),
                        textField: CustomTextField(
                          fillColor: kPrimaryColor.withOpacity(0.16),

                          controller: controller.registerNumController,
                          focusNode: controller.registerNumFocusNode,
                          onSubmitted: (value) =>
                              controller.registerNumFocusNode.unfocus(),
                          onChanged: (value) =>
                              controller.validateRegisterNum(),
                          hintText:
                              StringConstants.enterCompanyRegistrationNumber,
                        ),
                        errorText: controller.registerNumError,
                      ),
                      mediumHeight(),
                      // Text(
                      //   StringConstants.companyRegistrationCertificate,
                      //   style: kTextFieldTitleStyle,
                      // ),
                      // SizedBox(height: 10.h),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Obx(() {
                      //       return Flexible(
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: controller.registerCertificateFiles
                      //               .map((file) => Text(
                      //                     basename(file.path),
                      //                     style: kTextFieldTitleStyle.copyWith(
                      //                         color: kPrimaryColor,
                      //                         fontSize: 12.sp),
                      //                   ))
                      //               .toList(),
                      //         ),
                      //       );
                      //     }),
                      //     UploadButton(
                      //       label: StringConstants.upload,
                      //       onTap: () => controller
                      //           .pickFiles(controller.registerCertificateFiles),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 20.h),
                      Text(
                        StringConstants.companyRegistrationCertificate,
                        style: kTextFieldTitleStyle,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.commercialCertificateFiles
                                    .map((file) => Text(
                                          basename(file.path),
                                          style: kTextFieldTitleStyle.copyWith(
                                              color: kPrimaryColor,
                                              fontSize: 12.sp),
                                        ))
                                    .toList(),
                              ),
                            );
                          }),
                          UploadButton(
                            label: StringConstants.upload,
                            onTap: () => controller.pickFiles(
                                controller.commercialCertificateFiles),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        StringConstants.licenses,
                        style: kTextFieldTitleStyle,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.licensesFiles
                                    .map((file) => Text(
                                          basename(file.path),
                                          style: kTextFieldTitleStyle.copyWith(
                                              color: kPrimaryColor,
                                              fontSize: 12.sp),
                                        ))
                                    .toList(),
                              ),
                            );
                          }),
                          UploadButton(
                            label: StringConstants.upload,
                            onTap: () =>
                                controller.pickFiles(controller.licensesFiles),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      Obx(() {
                        return CustomRoundedButton(
                          backgroundColor: kPrimaryColor,
                          textColor: kWhiteColor,
                          loading: controller.isLoading.value,
                          text: StringConstants.submit,
                          onPressed: () async {
                            final result = await controller.updateProfile();
                            if (result) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Get.snackbar(
                                  StringConstants.success,
                                  StringConstants
                                      .companyDetailUpdatedSuccessfully,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              });
                              // Navigator.of(context).pop();
                              Get.toNamed(RoutesConstants.dashboard);
                              Get.delete<EditCompanyProfileController>(force: true);
                            }
                          },
                        );
                      }),
                      mediumHeight(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
