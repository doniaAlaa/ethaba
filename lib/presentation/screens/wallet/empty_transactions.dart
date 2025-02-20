import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:flutter/material.dart';

class EmptyTransactions extends StatelessWidget {
  const EmptyTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40,),
        Align(
            alignment: Alignment.center,
            child: Container(child: Image.asset(kMoney,scale: 0.6,))),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: Text('لا توجد عمليات مالية سابقة حتى الآن',
                textAlign: TextAlign.center,
                style: ksmallHeadTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w600,color: kBlackColor.withOpacity(0.5))),
          ),
        ),

      ],
    );
  }
}

