import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/models/categories_model.dart';
import 'package:ethabah/presentation/components/custom_complete_inputField.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/custom_textfield.dart';
import 'package:ethabah/presentation/screens/company_flow/submit_request/submit_req_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubmitRequestScreen extends StatelessWidget {
  const SubmitRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubmitReqController());
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
          StringConstants.submitARequest,
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
              //SizedBox(height: 10.h),
              // Center(
              //   child:
              // ),
              SizedBox(height: 10.h),
              CustomCompleteInputfield(
                  textfiledTitle: Text(StringConstants.nameOfProject,
                      style: kTextFieldTitleStyle),
                  textField: CustomTextField(
                      fillColor: kPrimaryColor.withOpacity(0.16),

                      controller: controller.projectNameController,
                      focusNode: controller.projectNameFocusNode,
                      hintText: StringConstants.projectName,
                      onSubmitted: (value) {
                        controller.projectNameFocusNode.unfocus();
                      }),
                  errorText: controller.projectNameError),
              //DropDown Menu
              SizedBox(height: 10.h),
              Text(
                StringConstants.chooseCategory,
                style: kTextFieldTitleStyle,
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.16),

                    // color: kTextFieldFillColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Obx(() => DropdownButton<CategoryModel>(
                      dropdownColor: kTextFieldFillColor,
                      isExpanded: true,
                      underline: Container(),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: kPrimaryColor),
                      hint:
                          Text(StringConstants.chooseCategory, style: kHintTextStyle),
                      value: controller.selectedCategory.value,
                      onChanged: (CategoryModel? value) {
                        controller.selectedCategory.value = value;
                      },
                      items: controller.categories
                          .map<DropdownMenuItem<CategoryModel>>(
                              (CategoryModel value) {
                        return DropdownMenuItem<CategoryModel>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                    )),
              ),
              Obx(() => controller.categoryError.value != ""
                  ? Text(
                      controller.categoryError.value,
                      style: kErrorTextStyle,
                    )
                  : Container()),
              SizedBox(height: 10.h),
              CustomCompleteInputfield(
                  textfiledTitle: Text(StringConstants.purposeOfFunding,
                      style: kTextFieldTitleStyle),
                  textField: CustomTextField(
                      fillColor: kPrimaryColor.withOpacity(0.16),

                      controller: controller.purposeOfFundingController,
                      focusNode: controller.purposeOfFundingFocusNode,
                      hintText: StringConstants.egpurchasing20vehicles,
                      onSubmitted: (value) {
                        controller.purposeOfFundingFocusNode.unfocus();
                      }),
                  errorText: controller.purposeOfFundingError),
              SizedBox(height: 10.h),
              CustomCompleteInputfield(
                  textfiledTitle: Text(StringConstants.totalFundsForInvestments,
                      style: kTextFieldTitleStyle),
                  textField: CustomTextField(
                      fillColor: kPrimaryColor.withOpacity(0.16),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: controller.totalFundsController,
                      focusNode: controller.totalFundsFocusNode,
                      hintText: StringConstants.enterTotalFunds,
                      onSubmitted: (value) {
                        controller.totalFundsFocusNode.unfocus();
                      }),
                  errorText: controller.totalFundsError),
              SizedBox(height: 10.h),
              CustomCompleteInputfield(
                  textfiledTitle: Text(StringConstants.description,
                      style: kTextFieldTitleStyle),
                  textField: CustomTextField(
                      fillColor: kPrimaryColor.withOpacity(0.16),

                      controller: controller.shortDescriptionController,
                      focusNode: controller.shortDescriptionFocusNode,
                      hintText: StringConstants.enterDescription,
                      onSubmitted: (value) {
                        controller.shortDescriptionFocusNode.unfocus();
                      }),
                  errorText: controller.shortDescriptionError),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    StringConstants.uploadDocument,
                    style: kTextFieldTitleStyle,
                  ),
                  SizedBox(width: 16,),
                  InkWell(
                    onTap: () {
                      controller.fileNameError.value = '';
                      controller.fileController.text = '';

                      showModalBottomSheet(
                          context: context,
                          backgroundColor: kWhiteColor,
                          builder: (builder){
                            return new Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                                ),
                                //could change this to Color(0xFF737373),
                                //so you don't have to change MaterialApp canvasColor
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      CustomCompleteInputfield(
                                          textfiledTitle: Text(StringConstants.fileName,
                                              style: kTextFieldTitleStyle),
                                          textField: CustomTextField(
                                              fillColor: kPrimaryColor.withOpacity(0.16),

                                              controller: controller.fileController,
                                               focusNode: FocusNode(),
                                              hintText: StringConstants.enterFileName,
                                              // onSubmitted: (value) {
                                              //   controller.shortDescriptionFocusNode.unfocus();
                                              // }
                                              ),
                                          errorText: controller.fileNameError),
                                      InkWell(
                                        onTap: (){
                                          if(controller.validateFileName()){
                                            Navigator.pop(context);
                                            controller.pickFile();
                                          }

                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius: BorderRadius.all(Radius.circular(12))
                                          ),
                                          child: Icon(Icons.upload,color: kWhiteColor,size: 40,),

                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                      );

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6),
                        child: Icon(Icons.upload,color: kWhiteColor,),
                      ),

                    ),
                  )
                ],
              ),
              SizedBox(height: 5.h),
              // Obx(() => GestureDetector(
              //       onTap: () => controller.pickFile(),
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 10, vertical: 15),
              //         decoration: BoxDecoration(
              //           // color: kTextFieldFillColor,
              //           color: kPrimaryColor.withOpacity(0.16),
              //
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Row(
              //           children: [
              //             const Icon(Icons.upload_file, color: kPrimaryColor),
              //             SizedBox(width: 10.w),
              //             Flexible(
              //               child: Text(
              //                 controller.selectedFile.value != null
              //                     ? controller.selectedFile.value!.path
              //                         .split('/')
              //                         .last
              //                     : StringConstants.noFileChosen,
              //                 style: kHintTextStyle,
              //                 maxLines: 2,
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     )),
              Obx((){
                return Container(
                    // height: 300,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      // color: kTextFieldFillColor,
                      color: kPrimaryColor.withOpacity(0.16),

                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:

                    controller.documentsNames.isEmpty?Text(StringConstants.uploadFiles) :
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.documentsNames.length,
                        itemBuilder: (context,index){
                          return Row(
                            children: [
                              const Icon(Icons.upload_file, color: kPrimaryColor),
                              SizedBox(width: 10.w),
                              Flexible(
                                child: Text(controller.documentsNames[index],
                                  style: kHintTextStyle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        })
                );
              }),
              SizedBox(height: 8,),
              Obx(() => controller.fileError.value != ""
                  ? Text(
                      controller.fileError.value,
                      style: kErrorTextStyle,
                    )
                  : Container()),
              SizedBox(height: 30.h),
              Obx(() => CustomRoundedButton(
                  backgroundColor: kPrimaryColor,
                  textColor: kWhiteColor,
                  loading: controller.isLoading.value,
                  text: StringConstants.submit,
                  onPressed: () {
                    if (controller.validateForm()) {
                      controller.onSubmit(context);
                    }
                  })),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
