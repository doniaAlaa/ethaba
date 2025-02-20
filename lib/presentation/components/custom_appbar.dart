import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Color iconColor;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.titleColor = Colors.black,
    this.iconColor = Colors.black,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 0.0),

        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: onBackPressed ?? () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: iconColor,
                //
                size: 22,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    // fontSize: 20,
                    fontSize: 16,

                    // fontWeight: FontWeight.bold,
                    fontWeight: FontWeight.w800,

                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
