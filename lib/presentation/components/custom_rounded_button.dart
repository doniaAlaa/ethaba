import 'package:ethabah/core/constants/app_theme.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final bool loading;
  final String text;
  final Function onPressed;
  final Color? backgroundColor; // if no then transparent
  final Color? textColor; // if no then black
  final Color? borderColor; // if no then no border needed
  final double? width; // if no then 0.8
  final double? height; // if no then 0.06
  final bool shadow; // if no then false
  final LinearGradient? gradient; // if true then no color only gradient

  const CustomRoundedButton({
    super.key,
    required this.loading,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.shadow = false,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : () => onPressed(),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: (gradient != null)
              ? null
              : (backgroundColor ?? Colors.transparent),
          gradient: (gradient != null)
              ? const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                )
              : null,
          borderRadius: BorderRadius.circular(16),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          boxShadow: shadow
              ? [
                  const BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 5.0,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(textColor ?? Colors.black),
                )
              : Text(
                  text,
                  style: kButtonTextStyle.copyWith(
                      color: textColor ?? Colors.black),
                ),
        ),
      ),
    );
  }
}
