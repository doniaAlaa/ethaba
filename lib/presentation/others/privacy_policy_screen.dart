import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/remote/terms_condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
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
        backgroundColor: kPrimaryColor,
        title: Text(
          StringConstants.privacyPolicy,
          style: kSubtitleTextStyle.copyWith(
            // color: kNeonColor,
            color: kWhiteColor,

            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
           color: kWhiteColor,
           // color: kNeonColor,
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
                  ${snapshot.data?.data.privacy}
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
          //       'سياسة الخصوصية',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 20.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'مرحبًا بكم في تطبيق المستثمر والشركة. نحن ملتزمون بحماية خصوصيتك وضمان أمان معلوماتك الشخصية. توضح سياسة الخصوصية هذه كيفية جمع واستخدام وحماية المعلومات التي تقدمها عند استخدام تطبيقنا.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'جمع المعلومات:',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     SizedBox(height: 10.h),
          //     Text(
          //       'نقوم بجمع المعلومات الشخصية التي تقدمها عند التسجيل في التطبيق، مثل الاسم وعنوان البريد الإلكتروني ورقم الهاتف. كما نقوم بجمع المعلومات المالية اللازمة لإدارة استثماراتك.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'استخدام المعلومات:',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     SizedBox(height: 10.h),
          //     Text(
          //       'نستخدم المعلومات التي نجمعها لتقديم الخدمات التي تطلبها، مثل إدارة حساباتك الاستثمارية وتزويدك بالتحديثات المالية. كما نستخدم المعلومات لتحسين تجربتك في التطبيق وتطوير خدماتنا.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'حماية المعلومات:',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     SizedBox(height: 10.h),
          //     Text(
          //       'نحن نتخذ إجراءات أمان مناسبة لحماية معلوماتك الشخصية من الوصول غير المصرح به أو التعديل أو الكشف أو التدمير. نحن نستخدم تقنيات التشفير والتدابير الأمنية الأخرى لضمان أمان بياناتك.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'مشاركة المعلومات:',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     SizedBox(height: 10.h),
          //     Text(
          //       'نحن لا نشارك معلوماتك الشخصية مع أطراف ثالثة إلا بموافقتك أو كما هو مطلوب بموجب القانون. قد نشارك المعلومات مع مزودي الخدمات الذين يساعدوننا في تشغيل التطبيق وتقديم الخدمات.',
          //       style: kSubtitleTextStyle.copyWith(
          //         color: kBlackColor,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     SizedBox(height: 20.h),
          //     Text(
          //       'تحديثات سياسة الخصوصية:',
          //       style: kHeadingTextStyle.copyWith(
          //         color: kPrimaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     SizedBox(height: 10.h),
          //     Text(
          //       'قد نقوم بتحديث سياسة الخصوصية هذه من وقت لآخر. سنقوم بإعلامك بأي تغييرات من خلال نشر السياسة المحدثة على التطبيق. نوصي بمراجعة السياسة بانتظام للبقاء على اطلاع على كيفية حماية معلوماتك.',
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
          //       'إذا كان لديك أي أسئلة أو استفسارات حول سياسة الخصوصية هذه، يرجى الاتصال بنا عبر البريد الإلكتروني أو الهاتف.',
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
