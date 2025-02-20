import 'package:ethabah/controller/add_bank_account_controller.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';
import 'package:ethabah/presentation/components/custom_appbar.dart';
import 'package:ethabah/presentation/components/custom_complete_inputField.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddBankAccountScreen extends StatefulWidget {
  final bool editing;
  final BankData? data;
   AddBankAccountScreen({super.key,required this.editing,required this.data});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  Widget? prefix;
  late AddBankAccountController controller;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // Fetch user data from API using BuildContext
    BankData? bankData = widget.data;
     controller = Get.put(AddBankAccountController(),permanent: true);

    print('kkkkkkkkkkkkkkkkkk');
    controller.accountName.text = bankData?.account_name??'';
    controller.accountNum.text = bankData?.account_number??'';
    controller.iban.text = bankData?.iban_number?.replaceAll('SA', '')??'';
  }
  @override
  Widget build(BuildContext context) {

    bool isEditing = widget.editing;

    return Container(
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
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            mediumHeight(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child:  CustomAppBar(title:
              isEditing ?StringConstants.updateBankAccount:
              StringConstants.addBankAccount,titleColor: kWhiteColor,iconColor: kWhiteColor,),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        largeHeight(),
                        CustomCompleteInputfield(

                          textfiledTitle: Text(
                            StringConstants.accountName,
                            // style: kTextFieldTitleStyle,
                            style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                          ),
                          textField: CustomTextField(

                            fillColor: kPrimaryColor.withOpacity(0.16),
                            controller: controller.accountName,
                              focusNode: FocusNode(),
                            onSubmitted: (value) {},
                            onChanged: (value){
                              controller.validateShortDescription();

                            },
                            hintText: StringConstants.accountName,

                          ),

                           errorText: controller.error1,
                        ),
                        CustomCompleteInputfield(
                          textfiledTitle: Text(
                            StringConstants.accountNumber,
                            // style: kTextFieldTitleStyle,
                            style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                          ),
                          textField: CustomTextField(
                            fillColor: kPrimaryColor.withOpacity(0.16),
                            controller: controller.accountNum,
                            focusNode:FocusNode(),
                            maxLength: 14,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onSubmitted: (value) {},
                            onChanged: (value){
                              print(controller.accountName.text);
                              controller.validateShortDescription2();
                            },
                            hintText: StringConstants.accountNumber,
                          ),
                          errorText: controller.error2,
                        ),
                        StatefulBuilder(
                          builder: (context,setState) {
                            return CustomCompleteInputfield(
                              textfiledTitle: Text(
                                StringConstants.iban,
                                // style: kTextFieldTitleStyle,
                                style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

                              ),
                              textField: Directionality(
                                textDirection: TextDirection.ltr,
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 0.065.sh,
                                      width: 0.2.sw,
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor.withOpacity(0.16),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "SA",
                                          style: kTextFieldTitleStyle,
                                        ),
                                      ),
                                    ),
                                    smallWidth(),

                                    StatefulBuilder(
                                        builder: (context,setState) {

                                          print('ooooooooo');
                                          return Expanded(
                                            child: CustomTextField(
                                                    fillColor: kPrimaryColor.withOpacity(0.16),
                                                    controller: controller.iban,
                                                    focusNode: FocusNode(),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.digitsOnly
                                                    ],
                                                    maxLength: 22,
                                                    // prefix: prefix,
                                                    onSubmitted: (value) {},
                                                    onChanged: (value){

                                                      controller.validateShortDescription3();
                                                    },
                                                    hintText: StringConstants.iban,
                                                  ),
                                          );
                                        }
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //
                                //     CustomTextField(
                                //       fillColor: kPrimaryColor.withOpacity(0.16),
                                //       controller: controller.iban,
                                //       // focusNode: controller.nameFocusNode,
                                //       keyboardType: TextInputType.number,
                                //       inputFormatters: [
                                //         FilteringTextInputFormatter.digitsOnly
                                //       ],
                                //       maxLength: 20,
                                //       prefix: prefix,
                                //       onSubmitted: (value) {},
                                //       onChanged: (value){
                                //         if(value.length == 1){
                                //
                                //
                                //           setState(() {
                                //             prefix = Padding(
                                //               padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                //               child: Text('SA'),
                                //             );
                                //             // controller.iban.text = 'SA';
                                //             print('iiiiiiiiiii');
                                //
                                //           });
                                //         }else if(value.length == 0){
                                //
                                //           setState(() {
                                //             prefix = null;
                                //           });
                                //         }
                                //         controller.validateShortDescription3();
                                //       },
                                //       hintText: StringConstants.iban,
                                //     ),
                                //   ],
                                // ),
                              ),
                              errorText: controller.error3,
                            );
                          }
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
        floatingActionButton: Obx((){
          return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child: CustomRoundedButton(
            loading: controller.isLoading.value,
            text: isEditing ?StringConstants.updateBankAccount:
            StringConstants.addBankAccount,
            onPressed: () {
              controller.addBankAccount(context);

            },
            textColor: kWhiteColor,
            backgroundColor: kPrimaryColor,
          ),
        );})
        ,

      ),
    );
  }
}

