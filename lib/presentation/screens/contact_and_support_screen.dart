import 'package:ethabah/controller/contact_and_support_controller.dart';
import 'package:ethabah/core/constants/app_icons.dart';
import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/widget/home_app_bar_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactAndSupportScreen extends StatelessWidget {
  const ContactAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {

    ContactAndSupportController controller = Get.put(ContactAndSupportController());
    controller.getContactData();

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
          StringConstants.contactAndSupport,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                'مرحبا ،',
                textAlign: TextAlign.start,
                style: kHeadingTextStyle.copyWith(
                  color: kBlackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),),
              ),
              SizedBox(height: 16,),
              Text(
                'نحن هنا للرد على إستفساراتكم.',
                textAlign: TextAlign.start,

                style: kHeadingTextStyle.copyWith(
                  color: kBlackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 40,),
              FutureBuilder(
                  future: controller.getContactData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: kPrimaryColor,));
                    }
                    // if (!snapshot.hasData ||
                    //     snapshot.data!.isEmpty ||
                    //     snapshot.data == null ||
                    //     snapshot.data?.length == 0) {
                    //   return T;
                    //
                    // }
                    return Column(
                      children: [
                        InkWell(
                          onTap: (){
                            launchUrlString('tel:${snapshot.data?.data?.phone1}');

                          },
                          child: Center(
                            child: Container(
                              height: 100,width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Icon(Icons.phone_android,color: kWhiteColor,size: 70,),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            launchUrlString('${snapshot.data?.data?.whatsapp}');

                          },
                          child: Center(
                            child: Container(
                                height: 100,width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    border: Border.all(color: kPrimaryColor,width: 4),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.all(10.h),
                                  child: Image.asset(whatsApp),
                                )

                            ),
                          ),
                        ),
                        SizedBox(height: 20,),

                        InkWell(
                          onTap: (){
                            launchUrl(Uri.parse('mailto:${snapshot.data?.data?.email}'));

                          },
                          child: Center(
                            child: Container(
                              height: 100,width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Icon(Icons.email,color: kWhiteColor,size: 70,),
                            ),
                          ),
                        ),
                      ],
                    );

                  }),


            ],
          )
        ),
      ),
    );
  }
}

