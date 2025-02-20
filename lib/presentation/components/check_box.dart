import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ethabah/core/constants/app_theme.dart';

class TermsCheckbox extends StatelessWidget {
  final RxBool agreeToTerms;

  const TermsCheckbox({
    super.key,
    required this.agreeToTerms,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(() => Checkbox(
              value: agreeToTerms.value,
              onChanged: (value) {
                agreeToTerms.value = value!;
              },
              activeColor: kPrimaryColor,
            )),
        Flexible(
          child: RichText(
            text: TextSpan(
              text: "أوافق على ",
              style: kTextFieldTitleStyle.copyWith(
                  color: Colors.black, fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: "الشروط والأحكام",
                  style: kTextFieldTitleStyle.copyWith(color: kPrimaryColor),
                ),
                TextSpan(
                  text: " و ",
                  style: kTextFieldTitleStyle.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text: "سياسة الخصوصية",
                  style: kTextFieldTitleStyle.copyWith(color: kPrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
