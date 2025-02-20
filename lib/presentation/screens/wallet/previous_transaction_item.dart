import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/models/wallet_transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviousTransactionItem extends StatelessWidget {
  final TransactionData transactionData;
  const PreviousTransactionItem({super.key,required this.transactionData});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child:Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('october 20,2025',style: ksmallHeadTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w500,color:kBlackColor.withOpacity(0.5))),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.inventory,color:kPrimaryColor),
                    SizedBox(width: 10,),
                    Container(
                        width: MediaQuery.of(context).size.width *0.3,
                        child: Text(transactionData.name??'',style: ksmallHeadTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w700,))),
                  ],
                ),
                Text('${transactionData.amount_paid}'+' '+'ر.س',style: kSubtitleTextStyle.copyWith(color:kPrimaryColor,fontWeight: FontWeight.w600)),

              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Divider(color: kBlackColor.withOpacity(0.1),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.monetization_on_sharp,color:kPrimaryColor),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('نسبة الربح',style: ksmallHeadTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w700,color: kBlackColor.withOpacity(0.4))),
                        SizedBox(height: 4,),
                        Container(
                            width: MediaQuery.of(context).size.width *0.2,
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${transactionData.profit_percentage}'+' '+'ر.س',style: ksmallHeadTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w600,))),

                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.money,color:kPrimaryColor),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('المبلغ المسترد',style: ksmallHeadTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w700,color: kBlackColor.withOpacity(0.4))),
                        SizedBox(height: 4,),
                        Text('${transactionData.recieved}'+' '+'ر.س',style: ksmallHeadTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w600,)),

                      ],
                    ),
                  ],
                ),


              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(12)
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                  child: Text('الإيصال',style: ksmallHeadTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w700,color: kWhiteColor)),
                ),

              ),
            )
          ],
        ),
      ) ,
    );
  }
}

