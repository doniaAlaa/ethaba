import 'package:ethabah/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool enabled;
  final TextInputType keyboardType;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final bool filled;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final bool? readOnly;
  final Function()? onTapFunc;
  final Widget? suffixIcon;
  final Widget? prefix;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.onChanged,
    this.focusNode,
    this.onSubmitted,
    this.inputFormatters,
    this.maxLength,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.hintStyle,
    this.fillColor,
    this.filled = true,
    this.borderRadius,
    this.borderSide,
    this.onTapFunc,
    this.readOnly = false,
    this.suffixIcon,
    this.prefix
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxBool isObscure = obscureText.obs;

    return Obx(() {
      return TextField(

        onTap: onTapFunc,
        obscureText: isObscure.value,
        readOnly: readOnly??false,
        controller: controller,
        onChanged: onChanged,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        enabled: enabled,

        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          counterText: "",

          hintStyle: hintStyle ?? kHintTextStyle,
          fillColor: fillColor ?? kTextFieldFillColor,
          filled: filled,

          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            borderSide: borderSide ?? BorderSide.none,
          ),
          prefix: prefix ,

          suffixIcon: obscureText
              ? IconButton(
                  icon: Icon(
                    isObscure.value ? Icons.visibility_off : Icons.visibility,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    isObscure.value = !isObscure.value;
                  },
                )
              : suffixIcon,
        ),
      );
    });
  }
}
