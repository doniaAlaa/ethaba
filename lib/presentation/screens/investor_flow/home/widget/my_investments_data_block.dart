import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:flutter/material.dart';

class MyInvestmentsDataBlock extends StatelessWidget {
  final IconData itemIcon;
  final String title;
  final String subTitle;
  const MyInvestmentsDataBlock({
    required this.title,
    required this.subTitle,
    required this.itemIcon,super.key});


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PhysicalModel(
         color: kWhiteColor.withOpacity(0.2),
        elevation: 0,
        shadowColor: kSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // Color(0xFF1D3E37),
                  Color(0xFF178B7B),
                  kWhiteColor.withOpacity(0.1)
                  // kBackgroundColor,

                ],
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
              ) ,
              borderRadius: BorderRadius.circular(16),
              // border: Border.all(color: kWhiteColor.withOpacity(0.2),width: 2)
          ),

          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
               // Color(0xFF1D3E37),
               Color(0xFF178B7B),
              Color(0xFF178B7B),



              // kBackgroundColor,


              ],
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            ) ,
                  borderRadius: BorderRadius.circular(16),
                  // border: Border.all(color: kWhiteColor.withOpacity(0.2),width: 2)
              ),
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(itemIcon,color: kWhiteColor,),
                    SizedBox(width: 10,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,style: ksmallHeadTextStyle.copyWith(color: kWhiteColor.withOpacity(0.9),fontSize: 14,fontWeight: FontWeight.w800),),
                        SizedBox(height: 2,),
                        Text(subTitle,style: ksmallGreyHeadingTextStyle.copyWith(color: kWhiteColor.withOpacity(0.9),fontSize: 10),)

                      ],
                    )
                  ],
                ),
              ) ,
            ),
          ),
        ),
      ),
    );
  }
}
