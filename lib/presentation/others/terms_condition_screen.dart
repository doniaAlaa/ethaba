import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/remote/terms_condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TermsConditionProvider.getTerms();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1D3E37),
                  Color(0xFF178B7B),
                  Color(0xFF178B7B),
                  Color(0xFF178B7B),
                  Color(0xFF178B7B),
                  // Color(0xFF178B7B),
                  // Color(0xFF178B7B),


                  // kBackgroundColor,


                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )

          ),
        ),
        title: Text(
          StringConstants.termsAndConditions,
          style: kSubtitleTextStyle.copyWith(
           // color: kNeonColor,
            color: kWhiteColor,

            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            // color: kNeonColor,
            color: kWhiteColor,

          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
          FutureBuilder(
              future: TermsConditionProvider.getTerms(),
              builder: (context, snapshot) {
                //log('Data: ${snapshot.data}');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return SizedBox(
                    height: 250.h,
                    child: Center(
                      child: Text(
                        StringConstants.somethingWentWrong,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            fontSize: 20.sp),
                      ),
                    ),
                  );
                }
                // if (snapshot.data == [] ||
                //     snapshot.data == null ||
                //     snapshot.data!.data.isEmpty) {
                //   return SizedBox(
                //     height: 200.h,
                //     child: Center(
                //       child: Text(
                //         StringConstants.noInvestmentFundsAvailble,
                //         style: TextStyle(
                //           color: kPrimaryColor,
                //           fontSize: 14.sp,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   );
                // }
                //log('Data length: ${snapshot.data!.length}');
                return    Column(
                  children: [

                    HtmlWidget(
                      // the first parameter (`html`) is required
                      '''
                  ${snapshot.data?.data.terms}
                      ''',

                      // all other parameters are optional, a few notable params:

                      // specify custom styling for an element
                      // see supported inline styling below
                      customStylesBuilder: (element) {
                        if (element.classes.contains('foo')) {
                          return {'color': 'red'};
                        }

                        return null;
                      },

                      customWidgetBuilder: (element) {
                        // if (element.attributes['foo'] == 'bar') {
                        //   // render a custom block widget that takes the full width
                        //   return FooBarWidget();
                        // }
                        //
                        // if (element.attributes['fizz'] == 'buzz') {
                        //   // render a custom widget inline with surrounding text
                        //   return InlineCustomWidget(
                        //     child: FizzBuzzWidget(),
                        //   )
                        // }
                        //
                        // return null;
                      },

                      textStyle: TextStyle(fontSize: 14),
                    ),
                  ],
                );
              })

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       'الشروط والأحكام',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 20.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'مرحبًا بكم في تطبيق المستثمر والشركة. توضح هذه الشروط والأحكام القواعد واللوائح لاستخدام تطبيقنا. باستخدام هذا التطبيق، نفترض أنك تقبل هذه الشروط والأحكام بالكامل. لا تستمر في استخدام التطبيق إذا كنت لا توافق على جميع الشروط والأحكام المذكورة في هذه الصفحة.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'استخدام التطبيق:',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     SizedBox(height: 10.h),
          //     Text(
          //       'يجب أن تستخدم التطبيق فقط للأغراض القانونية وبطريقة لا تنتهك حقوق الآخرين أو تقيد أو تمنع استخدامهم واستمتاعهم بالتطبيق. يجب ألا تستخدم التطبيق لإرسال أو نشر أي مواد غير قانونية أو ضارة أو تهديدية أو مسيئة أو تشهيرية أو فاحشة أو غير مقبولة بأي شكل من الأشكال.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'الملكية الفكرية:',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     SizedBox(height: 10.h),
          //     Text(
          //       'جميع حقوق الملكية الفكرية المتعلقة بالتطبيق ومحتوياته (بما في ذلك على سبيل المثال لا الحصر النصوص والرسومات والشعارات والصور) مملوكة لنا أو مرخصة لنا. لا يجوز لك إعادة إنتاج أو توزيع أو تعديل أو إنشاء أعمال مشتقة من أي جزء من التطبيق دون الحصول على إذن كتابي صريح منا.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'التعديلات على الشروط:',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     SizedBox(height: 10.h),
          //     Text(
          //       'نحتفظ بالحق في تعديل هذه الشروط والأحكام في أي وقت. ستكون التعديلات سارية فور نشرها على التطبيق. يُعتبر استمرارك في استخدام التطبيق بعد نشر التعديلات قبولًا منك لهذه التعديلات.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'إنهاء الاستخدام:',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     SizedBox(height: 10.h),
          //     Text(
          //       'نحتفظ بالحق في إنهاء أو تعليق وصولك إلى التطبيق في أي وقت دون إشعار مسبق ولأي سبب، بما في ذلك على سبيل المثال لا الحصر انتهاك هذه الشروط والأحكام.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'الاتصال بنا:',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     SizedBox(height: 10.h),
          //     Text(
          //       'إذا كان لديك أي أسئلة أو استفسارات حول هذه الشروط والأحكام، يرجى الاتصال بنا عبر البريد الإلكتروني أو الهاتف.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
