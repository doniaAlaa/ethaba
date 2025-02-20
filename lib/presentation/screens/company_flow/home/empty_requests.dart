import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:flutter/material.dart';

class EmptyRequests extends StatelessWidget {
  const EmptyRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(kEmptyBox),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    'لا يوجد صناديق استثمارية قامت الشركة بالتسجيل بها',
                    style: TextStyle(

                        fontSize: 16,

                        color: kPrimaryColor,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 16.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         // height: 70,width: 70,
              //         decoration: BoxDecoration(
              //             color: kPrimaryColor,
              //             borderRadius: BorderRadius.circular(12),
              //             border: Border.all(color: kPrimaryColor)
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16),
              //           child: Row(
              //             children: [
              //               Icon(Icons.app_registration,color: kWhiteColor,size: 20,),
              //               SizedBox(width: 10,),
              //               Text(
              //                 'قم بالتسجيل',
              //                 style: TextStyle(
              //                     fontSize: 18,
              //                     color: kWhiteColor,
              //                     fontWeight: FontWeight.w600),
              //               )
              //             ],
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          )),
    );
  }
}

