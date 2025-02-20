import 'package:ethabah/core/constants/app_theme.dart';
import 'package:flutter/material.dart';

class HomeAppBarIcon extends StatelessWidget {
  final String iconImage;
  final Function() onTapFunc;
  const HomeAppBarIcon({super.key,required this.iconImage,required this.onTapFunc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        onTapFunc();
      },
      child: PhysicalModel(
        color: kWhiteColor.withOpacity(0.2),
        elevation: 0,
        shadowColor: kSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 40,width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                // Color(0xFF1D3E37),
                kSecondaryColor,

                // Color(0xFF178B7B),
                kWhiteColor.withOpacity(0.1)
                // kBackgroundColor,

              ],
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
            ) ,
            // border: Border.all(color: kWhiteColor.withOpacity(0.2),width: 2)
          ),

          child:
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor,

                    shape: BoxShape.circle
                ),
                child: Center(child: Image.asset(iconImage,scale: 2.2,))),
          )
          ,)
      ),
    );
  }

}
