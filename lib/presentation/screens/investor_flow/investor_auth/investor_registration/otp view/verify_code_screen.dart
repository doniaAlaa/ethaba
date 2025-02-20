import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_spacing.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/utils/mobileNo_formatter.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';
import 'package:ethabah/presentation/components/custom_appbar.dart';
import 'package:ethabah/presentation/components/custom_complete_inputField.dart';
import 'package:ethabah/presentation/components/custom_rounded_button.dart';
import 'package:ethabah/presentation/components/custom_textfield.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/inverstor_reg_controller.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/otp%20view/verify_code_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EnterOTP extends StatefulWidget {

  final String type ;
  final bool? isEditing ;
  final BankData? myBankData;
  EnterOTP({required this.type,this.isEditing,this.myBankData});

  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {

  Widget? prefix;
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(VerifyCodeController());
    TextEditingController t1= TextEditingController();
    TextEditingController t2= TextEditingController();
    TextEditingController t3= TextEditingController();
    TextEditingController t4= TextEditingController();
    TextEditingController t5= TextEditingController();
    TextEditingController t6= TextEditingController();


    return Scaffold(
      backgroundColor: kBackgroundColor,
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              mediumHeight(),

               CustomAppBar(title:widget.type == 'investor' ?StringConstants.investorRegistration:
               widget.type == 'company'?
               StringConstants.companyRegistration:StringConstants.verify),
              SizedBox(height: 40,),
              widget.type == 'verifyMyBankAccount'?
              Text(
                StringConstants.verifyBankAccount,
                style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w500),
              ):
              Text(
                'يرجى التحقق من رقم الجوال قبل البدء فى تسجيل الحساب',
                style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16,),
              CustomCompleteInputfield(
                  textfiledTitle: Text(
                    StringConstants.phoneNumber,
                    // style: kTextFieldTitleStyle,
                    style: kTextFieldTitleStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 14),

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
                            fillColor: kPrimaryColor.withOpacity(0.16),

                            // inputFormatters: [
                            //   MobileNumberFormatter(),
                            // ],

                            keyboardType: TextInputType.phone,
                            controller: controller.phoneController,
                            // prefix: prefix,


                            maxLength: 9,
                            focusNode: controller.phoneFocusNode,
                            onSubmitted: (value) => controller.onPhoneSubmitted,
                            onChanged: (value) {
                              // if(value.length == 1){
                              //   print('jjjj');
                              //
                              //   prefix = Padding(
                              //     padding: const EdgeInsets.symmetric(horizontal: 1.0),
                              //     child: Text('5'),
                              //   );
                              //   setState(() {
                              //
                              //   });
                              // }else if(value.length == 0){
                              //   prefix = null;
                              //   setState(() {
                              //
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
                  errorText: controller.phoneError),
              //Send OTP Button
              Directionality(
                textDirection: TextDirection.rtl,
                child: Obx(() => CustomRoundedButton(
                    backgroundColor: kPrimaryColor,
                    height: 0.065.sh,
                    width: 0.5.sw,

                    textColor: kWhiteColor,
                    shadow: true,
                    loading: controller.isOTPsendLoading.value,
                    text: StringConstants.sendOTP,
                    onPressed: () {
                      widget.type == 'verifyMyBankAccount'?
                      controller.getVerifyCodeForMyBankAccount():
                      controller.getVerifyCode();
                    })),
              ),
              SizedBox(height: 24,),

              Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OTPDigitTextFieldBox(first: true, last: false, cont: t1,),
                        OTPDigitTextFieldBox(first: false, last: false,cont: t2,),
                        OTPDigitTextFieldBox(first: false, last: false,cont: t3,),
                        OTPDigitTextFieldBox(first: false, last: false,cont: t4,),
                        OTPDigitTextFieldBox(first: false, last: false,cont: t5,),
                        OTPDigitTextFieldBox(first: false, last: true,cont: t6,),

                      ],
                    )
                  ]),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Obx(() => CustomRoundedButton(
                    backgroundColor: kPrimaryColor,
                    height: 0.065.sh,

                    textColor: kWhiteColor,
                    shadow: true,
                    loading: controller.isVerifyLoading.value,
                    text: StringConstants.verify,
                    onPressed: () {
                      String otp = '${t1.text}${t2.text}${t3.text}${t4.text}${t5.text}${t6.text}';
                      String reversedOtp = otp.split('').reversed.join('');
                      controller.verifyPhone(otp,widget.type,isEditing:widget.isEditing,bankData:widget.myBankData,context: context);

                    })),
              ),

            ],
          ),
        ),
      )
    );
  }
}

class OTPDigitTextFieldBox extends StatelessWidget {
  final bool? first;
  final bool? last;
  final TextEditingController? cont;
  const OTPDigitTextFieldBox(
      { @required this.first, @required this.last,required this.cont})
      : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.6,
        child: TextField(
          controller: cont,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: true,
          cursorColor: kPrimaryColor,
          readOnly: false,
          textAlign: TextAlign.center,
          // style: MyStyles.inputTextStyle,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.all(0),
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: kPrimaryColor),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: kPrimaryColor),
                borderRadius: BorderRadius.circular(10)),
            // hintText: "*",
            // hintStyle:kPrimaryColor,
          ),
        ),
      ),
    );
  }
}