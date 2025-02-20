import 'dart:io';

import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/presentation/components/custom_textfield.dart';
import 'package:ethabah/presentation/screens/investor_flow/edit_profile/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/custom_complete_inputfield.dart';
import 'package:ethabah/presentation/components/upload_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class InvEditProfileScreen extends StatefulWidget {
   String? profile_img;
   InvEditProfileScreen({super.key,required this.profile_img });

  @override
  State<InvEditProfileScreen> createState() => _InvEditProfileScreenState();
}

class _InvEditProfileScreenState extends State<InvEditProfileScreen> {
  XFile? img;
  Widget? prefix;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
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
        title:  Text(
          StringConstants.editProfile,
          style: kSubtitleTextStyle.copyWith(
          // color: kNeonColor,
          color: kWhiteColor,

          fontWeight: FontWeight.bold,
        ),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              // color: kNeonColor,
              color: kWhiteColor,

            )),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mediumHeight(),
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
                          child:img != null  ?ClipRRect(
                              borderRadius: BorderRadius.circular(100000),
                              child: Image.file(File(img!.path),fit: BoxFit.cover,)):
                              widget.profile_img != null ?
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100000),
                                  child: Image.network('https://admin.ethabah.com/profile/${widget.profile_img}',fit: BoxFit.cover,
                                    errorBuilder: ( context,  exception,stackTrace) {
                                      return Image.asset('assets/icons/primary_person.png');
                                    },
                                  )):
                          Icon(Icons.account_circle_sharp,color: kPrimaryColor,size: 80,)
                        //Image.asset('assets/icons/primary_person.png',scale: 1.5,),
                        // Padding(
                        //   padding: const EdgeInsets.all(30.0),
                        //   child: SvgPicture.asset('assets/icons/person.svg',fit: BoxFit.contain,),
                        // ),
                      ),
                      InkWell(
                        onTap: () async{
                          print(img != null );
                          print(widget.profile_img != null);
                          if(img != null  || widget.profile_img != null ){
                            //remove
                            img = null;
                            widget.profile_img = null;
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
                            child: Icon(img != null || widget.profile_img != null ?Icons.remove: Icons.add,color: kWhiteColor,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomCompleteInputfield(
                textfiledTitle: Text(
                  StringConstants.name,
                  style: kTextFieldTitleStyle,
                ),
                textField: CustomTextField(
                  fillColor: kPrimaryColor.withOpacity(0.16),
                  controller: controller.nameController,
                  focusNode: controller.nameFocusNode,
                  onSubmitted: (value) => controller.nameFocusNode.unfocus(),
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
                  onSubmitted: (value) => controller.emailFocusNode.unfocus(),
                  onChanged: (value) => controller.validateEmail(),
                  hintText: StringConstants.enterEmailAddress,
                ),
                errorText: controller.emailError,
              ),
              CustomCompleteInputfield(
                textfiledTitle: Text(
                  StringConstants.nationalId,
                  // style: kTextFieldTitleStyle,
                  style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                ),
                textField: CustomTextField(
                  fillColor: kPrimaryColor.withOpacity(0.16),
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 10,
                  controller: controller.nationalIDController,
                  onTapFunc: (){
                    Get.snackbar(
                      StringConstants.forbidden,
                      StringConstants.contactWithSupportForNationalId,
                      backgroundColor: kNeonColor,
                      colorText: Colors.black,
                    );
                  },
                  // focusNode: controller.nameFocusNode,
                  // onSubmitted: (value) => controller.onNameSubmitted(),
                  onChanged: (value) => controller.validateName(),
                  hintText: StringConstants.enterNationalId,
                ),
                errorText: controller.nationalIDError,
              ),

              // CustomCompleteInputfield(
              //   textfiledTitle: Text(
              //     StringConstants.password,
              //     style: kTextFieldTitleStyle,
              //   ),
              //   textField: CustomTextField(
              //     fillColor: kPrimaryColor.withOpacity(0.16),
              //
              //     obscureText: true,
              //     controller: controller.passwordController,
              //     focusNode: controller.passwordFocusNode,
              //     onSubmitted: (value) =>
              //         controller.passwordFocusNode.unfocus(),
              //     onChanged: (value) => controller.validatePassword(),
              //     hintText: StringConstants.enterPassword,
              //   ),
              //   errorText: controller.passwordError,
              // ),
              // CustomCompleteInputfield(
              //   textfiledTitle: Text(
              //     StringConstants.passwordConfirmation,
              //     style: kTextFieldTitleStyle,
              //   ),
              //   textField: CustomTextField(
              //     fillColor: kPrimaryColor.withOpacity(0.16),
              //
              //     obscureText: true,
              //     controller: controller.passwordConfirmationController,
              //     focusNode: controller.passwordConfirmationFocusNode,
              //     onSubmitted: (value) =>
              //         controller.passwordConfirmationFocusNode.unfocus(),
              //     onChanged: (value) =>
              //         controller.validatePasswordConfirmation(),
              //     hintText: StringConstants.enterPasswordConfirmation,
              //   ),
              //   errorText: controller.passwordConfirmationError,
              // ),
              CustomCompleteInputfield(
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
                        StatefulBuilder(
                          builder: (context,setState) {
                            return Expanded(
                              child: CustomTextField(
                                fillColor: kPrimaryColor.withOpacity(0.16),
                                maxLength: 9,
                                readOnly: true,
                                keyboardType: TextInputType.phone,
                                controller: controller.phoneController,
                                focusNode: controller.phoneFocusNode,
                                // prefix: prefix,
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                //   child: Text('5'),
                                // ),
                                onTapFunc: (){
                                  Get.snackbar(
                                    StringConstants.forbidden,
                                    StringConstants.contactWithSupportForPhone,
                                    backgroundColor: kNeonColor,
                                    colorText: Colors.black,
                                  );
                                },
                                onSubmitted: (value) =>
                                    controller.phoneFocusNode.unfocus(),
                                onChanged: (value) {
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
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                  errorText: controller.phoneError),
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
              //     onSubmitted: (value) => controller.addressFocusNode.unfocus(),
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
              mediumHeight(),
              // Text(
              //   StringConstants.passport,
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
              //           children: controller.passportFiles
              //               .map((file) => Text(
              //                     basename(file.path),
              //                     style: kTextFieldTitleStyle.copyWith(
              //                         color: kPrimaryColor, fontSize: 12.sp),
              //                   ))
              //               .toList(),
              //         ),
              //       );
              //     }),
              //     UploadButton(
              //       label: StringConstants.upload,
              //       onTap: () => controller.pickFiles(controller.passportFiles),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20.h),
              // Text(
              //   StringConstants.nationalId,
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
              //           children: controller.nationalIdFiles
              //               .map((file) => Text(
              //                     basename(file.path),
              //                     style: kTextFieldTitleStyle.copyWith(
              //                         color: kPrimaryColor, fontSize: 10.sp),
              //                   ))
              //               .toList(),
              //         ),
              //       );
              //     }),
              //     UploadButton(
              //       label: StringConstants.upload,
              //       onTap: () =>
              //           controller.pickFiles(controller.nationalIdFiles),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 16.h),
              Obx(() {
                return CustomRoundedButton(
                  backgroundColor: kPrimaryColor,
                  textColor: kWhiteColor,
                  loading: controller.isLoading.value,
                  text: StringConstants.submit,
                  onPressed: () => controller.updateProfile(context),
                );
              }),
              mediumHeight(),
            ],
          ),
        ),
      ),
    );
  }
}
