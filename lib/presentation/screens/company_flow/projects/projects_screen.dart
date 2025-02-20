import 'dart:developer';

import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/utils/date_helper.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:ethabah/main.dart';
import 'package:ethabah/models/project_doc.dart';
import 'package:ethabah/presentation/screens/company_flow/financial_returns/financial_returns_screen.dart';
import 'package:ethabah/presentation/screens/company_flow/projects/project_screen_controller.dart';
import 'package:ethabah/presentation/screens/company_flow/request_update_screen.dart/request_updates_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> with RouteAware {
  final controller = Get.put(ProjectScreenController());
  final catController = Get.isRegistered<CategoriesController>()
      ? Get.find<CategoriesController>()
      : Get.put(CategoriesController());
  RxString comapnyName = "".obs;

  String getDateFormatted() {
    final DateTime now = DateTime.now();
    final intl.DateFormat formatter = intl.DateFormat('dd MMM yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCompanyName();
  }

  getCompanyName() async {
    final user = await SharedPref.getUser();
    comapnyName.value = user?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Company Name and Current Live Date (like format 25 Oct 2024)
                Obx(
                  () => Text(
                    comapnyName.value == ""
                        ? StringConstants.companyName
                        : comapnyName.value,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: kBlackColor,
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    getDateFormatted(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: kBlackColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 const FinancialReturnsScreen()));
                //   },
                //   child: Container(
                //     height: 0.3.sh,
                //     width: 0.44.sw,
                //     decoration: BoxDecoration(
                //       color: kSecondaryColor,
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Column(
                //       children: [
                //         Expanded(
                //           child: Icon(
                //             Icons.query_stats_outlined,
                //             color: kNeonColor,
                //             size: 0.2.sw,
                //           ),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           children: [
                //             SizedBox(
                //               width: 5.w,
                //             ),
                //             Expanded(
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 mainAxisSize: MainAxisSize.max,
                //                 children: [
                //                   Text(
                //                     StringConstants.projectUpdates,
                //                     style: TextStyle(
                //                       fontSize: 12.sp,
                //                       fontWeight: FontWeight.bold,
                //                       color: kNeonColor,
                //                     ),
                //                   ),
                //                   Text(
                //                     "${StringConstants.lastUpdated} 2 ${StringConstants.daysAgo}",
                //                     style: kSubtitleTextStyle.copyWith(
                //                         fontSize: 10.sp, color: Colors.white),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             IconButton(
                //                 onPressed: () {},
                //                 icon: Icon(
                //                   Icons.arrow_forward_ios,
                //                   color: kWhiteColor,
                //                   size: 16.sp,
                //                 ))
                //           ],
                //         ),
                //         SizedBox(
                //           height: 10.h,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RequestUpdatesScreen()));
                    setState(() {});
                  },
                  child: Container(
                    height: 0.3.sh,
                    width: 0.44.sw,
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.attach_money_outlined,
                            color: kNeonColor,
                            size: 0.2.sw,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    StringConstants.financialReturns,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: kNeonColor,
                                    ),
                                  ),
                                  Text(
                                    "${StringConstants.lastUpdated} 3 ${StringConstants.daysAgo}",
                                    style: kSubtitleTextStyle.copyWith(
                                        fontSize: 10.sp, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: kWhiteColor,
                                  size: 16.sp,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              StringConstants.projects,
              style: kHeadingTextStyle,
            ),
            // FutureBuilder(
            //     future: controller.getProjects(),
            //     builder: (context, snapshot) {
            //       log(snapshot.data.toString());
            //       if (ConnectionState.waiting == snapshot.connectionState) {
            //         return const Center(
            //           child: CircularProgressIndicator(color: kPrimaryColor),
            //         );
            //       }
            //       if (snapshot.data == null ||
            //           snapshot.data == [] ||
            //           snapshot.data!.isEmpty) {
            //         return Expanded(
            //           child: Center(
            //             child: Text(
            //               StringConstants.noProjectsUpdate,
            //               style: kHeadingTextStyle.copyWith(
            //                 color: kPrimaryColor,
            //                 fontSize: 16.sp,
            //                 fontWeight: FontWeight.w700,
            //               ),
            //             ),
            //           ),
            //         );
            //       }
            //       // List<ProjectDocument> projects = snapshot.data!;
            //       // return Expanded(
            //       //   child: ListView.builder(
            //       //       padding: EdgeInsets.zero,
            //       //       shrinkWrap: true,
            //       //       itemCount: projects!.length,
            //       //       itemBuilder: (context, index) {
            //       //         return Padding(
            //       //           padding: const EdgeInsets.symmetric(vertical: 10),
            //       //           child: Container(
            //       //             padding: const EdgeInsets.symmetric(
            //       //                 horizontal: 10, vertical: 15),
            //       //             decoration: BoxDecoration(
            //       //               color: kSecondaryColor,
            //       //               borderRadius: BorderRadius.circular(10),
            //       //             ),
            //       //             child: Row(
            //       //               children: [
            //       //                 Column(
            //       //                   crossAxisAlignment:
            //       //                       CrossAxisAlignment.start,
            //       //                   mainAxisAlignment: MainAxisAlignment.center,
            //       //                   children: [
            //       //                     Text(
            //       //                       projects[index].updateName,
            //       //                       style: kSubtitleTextStyle.copyWith(
            //       //                           fontWeight: FontWeight.bold,
            //       //                           color: kNeonColor,
            //       //                           fontSize: 14.sp),
            //       //                     ),
            //       //                     SizedBox(
            //       //                       height: 5.h,
            //       //                     ),
            //       //                     Text(
            //       //                       catController.getProjectName(int.parse(
            //       //                           projects[index].requestId)),
            //       //                       style: kSubtitleTextStyle.copyWith(
            //       //                           fontWeight: FontWeight.bold,
            //       //                           color: kWhiteColor,
            //       //                           fontSize: 14.sp),
            //       //                     ),
            //       //                     SizedBox(
            //       //                       height: 5.h,
            //       //                     ),
            //       //                     //updated date
            //       //                     Text(
            //       //                       "${StringConstants.lastUpdated} ${formatDate(projects[index].updatedAt.toString())}",
            //       //                       style: kSubtitleTextStyle.copyWith(
            //       //                           fontSize: 10.sp,
            //       //                           color: Colors.white),
            //       //                     ),
            //       //                   ],
            //       //                 ),
            //       //                 const Spacer(),
            //       //                 Column(
            //       //                   mainAxisAlignment: MainAxisAlignment.center,
            //       //                   crossAxisAlignment:
            //       //                       CrossAxisAlignment.center,
            //       //                   children: [
            //       //                     InkWell(
            //       //                       onTap: () {
            //       //                         _launchURL(
            //       //                             projects[index].documentUrl);
            //       //                       },
            //       //                       child: Container(
            //       //                         padding: EdgeInsets.symmetric(
            //       //                             horizontal: 10.w, vertical: 5.h),
            //       //                         decoration: BoxDecoration(
            //       //                           color: kPrimaryColor,
            //       //                           borderRadius:
            //       //                               BorderRadius.circular(5),
            //       //                         ),
            //       //                         child: Center(
            //       //                           child: Text(
            //       //                             StringConstants.download,
            //       //                             style: TextStyle(
            //       //                               color: kNeonColor,
            //       //                               fontSize: 12.sp,
            //       //                               fontWeight: FontWeight.bold,
            //       //                             ),
            //       //                           ),
            //       //                         ),
            //       //                       ),
            //       //                     )
            //       //                   ],
            //       //                 )
            //       //               ],
            //       //             ),
            //       //           ),
            //       //         );
            //       //       }),
            //       // );
            //     })
          ],
        ),
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> _downloadAllFiles(List<String> urls) async {
  for (String url in urls) {
    await _launchURL(url);
  }
}
