// import 'dart:developer';
//
// import 'package:ethabah/controller/categories_controller.dart';
// import 'package:ethabah/core/constants/app_routes.dart';
// import 'package:ethabah/core/constants/app_strings.dart';
// import 'package:ethabah/core/constants/app_theme.dart';
// import 'package:ethabah/models/company_stats_model.dart';
// import 'package:ethabah/models/investor_model.dart';
// import 'package:ethabah/presentation/components/funding_req_widget.dart';
// import 'package:ethabah/presentation/screens/company_flow/home/home_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(HomeController());
//     final catController = Get.isRegistered<CategoriesController>()
//         ? Get.find<CategoriesController>()
//         : Get.put(CategoriesController(), permanent: true);
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 50.h,
//               width: double.infinity,
//             ),
//             Text(
//               StringConstants.myDashboard,
//               style: TextStyle(
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.bold,
//                 color: kBlackColor,
//               ),
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             //Create a box with background o metallic kSecondaryColor shine with white color lslight linear radial white light shine in the middle of the box
//             FutureBuilder<CompanyStatsModel>(
//                 future: controller.getCompanyStats(),
//                 builder: (context, snapshot) {
//                   return Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Stack(
//                           children: [
//                             Container(
//                               height: 200.h,
//                               decoration: BoxDecoration(
//                                 color: kSecondaryColor,
//                                 borderRadius: BorderRadius.circular(10.r),
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     kSecondaryColor.withOpacity(1),
//                                     kSecondaryColor,
//                                     kSecondaryColor.withOpacity(1),
//                                   ],
//                                   stops: [0.0, 0.5, 1.0],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.white.withOpacity(0.5),
//                                     spreadRadius: 1,
//                                     blurRadius: 5,
//                                     offset: const Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10.r),
//                                 child: CustomPaint(
//                                   painter: ShinePainter(),
//                                   child: Container(),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: 5,
//                               left: 0,
//                               right: 0,
//                               child: Container(
//                                 height: 200.h,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 15, vertical: 10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(StringConstants.fundingRequired,
//                                         style: kSubHeadingTextStyle.copyWith(
//                                             color: kWhiteColor,
//                                             fontSize: 14.sp)),
//                                     SizedBox(height: 10.h),
//                                     Text(
//                                         "SAR ${snapshot.data?.requestsWithFunds ?? 0}",
//                                         style: kHeadingTextStyle.copyWith(
//                                             color: kWhiteColor,
//                                             fontSize: 34.sp)),
//                                     // Text(StringConstants.increaseThanLastMonth,
//                                     //     style:
//                                     //         ksmallGreyHeadingTextStyle.copyWith(
//                                     //             color: kWhiteColor,
//                                     //             fontSize: 12.sp)),
//                                     SizedBox(height: 20.h),
//                                     // const FundingRequiredWidget(
//                                     //     amount: "80000"),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 10.w),
//                       Column(
//                         children: [
//                           Container(
//                             height: 95.h,
//                             width: 0.25.sw,
//                             decoration: BoxDecoration(
//                               color: Colors.orange[100],
//                               border: Border.all(
//                                 color: Colors.orange.withOpacity(0.5),
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10.r),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(
//                                   Icons.pending_actions,
//                                   color: Colors.orange,
//                                 ),
//                                 SizedBox(height: 5.h),
//                                 Text(
//                                   StringConstants.pendingProjects,
//                                   style: ksmallGreyHeadingTextStyle.copyWith(
//                                     color: Colors.orange,
//                                     fontSize: 12.sp,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 Text(
//                                   snapshot.data?.pendingRequests.toString() ??
//                                       "0",
//                                   style: ksmallGreyHeadingTextStyle.copyWith(
//                                     color: Colors.orange,
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10.h),
//                           Container(
//                             height: 95.h,
//                             width: 0.25.sw,
//                             decoration: BoxDecoration(
//                               color: Colors.green[100],
//                               border: Border.all(
//                                 color: Colors.green.withOpacity(0.5),
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10.r),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(
//                                   Icons.check_circle_outline,
//                                   color: Colors.green,
//                                 ),
//                                 SizedBox(height: 5.h),
//                                 Text(
//                                   StringConstants.approvedProjects,
//                                   style: ksmallGreyHeadingTextStyle.copyWith(
//                                     color: Colors.green,
//                                     fontSize: 12.sp,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 Text(
//                                   snapshot.data?.approvedRequests.toString() ??
//                                       "0",
//                                   style: ksmallGreyHeadingTextStyle.copyWith(
//                                     color: Colors.green,
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 }),
//             SizedBox(
//               height: 20.h,
//             ),
//             Text(
//               StringConstants.myProjects,
//               style: kSubHeadingTextStyle.copyWith(
//                 color: kBlackColor,
//                 fontSize: 20.sp,
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             FutureBuilder(
//                 future: controller.getCompanyRequest(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator(color: kPrimaryColor,));
//                   }
//                   if (!snapshot.hasData ||
//                       snapshot.data!.isEmpty ||
//                       snapshot.data == null ||
//                       snapshot.data?.length == 0) {
//                     return const Expanded(
//                       child: Center(
//                           child: Text(
//                         StringConstants.NoRequestsFound,
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: kPrimaryColor,
//                             fontWeight: FontWeight.bold),
//                       )),
//                     );
//                   }
//                   return Expanded(
//                     child: ListView.builder(
//                         //clipBehavior: Clip.none,
//                         shrinkWrap: true,
//                         // physics: const NeverScrollableScrollPhysics(),
//                         padding: EdgeInsets.zero,
//                         itemBuilder: (context, index) {
//                           final request = snapshot.data![index];
//
//                           return GestureDetector(
//                             onTap: () {
//                               Get.toNamed(
//                                 RoutesConstants.projectDetailsCompany,
//                                 arguments: request,
//                               );
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(bottom: 10.0),
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 height: 140.h,
//                                 width: 0.9.sw,
//                                 decoration: BoxDecoration(
//                                   color: kBackgroundColor,
//                                   borderRadius: BorderRadius.circular(5.r),
//                                   border: Border.all(
//                                     color: kGreyColor.withOpacity(0.5),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         // Container(
//                                         //   height: 45.h,
//                                         //   width: 80.w,
//                                         //   decoration: BoxDecoration(
//                                         //     color: Colors.grey.withOpacity(0.5),
//                                         //     borderRadius:
//                                         //         BorderRadius.circular(5.r),
//                                         //   ),
//                                         // ),
//                                         // SizedBox(
//                                         //   width: 10.w,
//                                         // ),
//                                         //Project Title can be max 2 lines
//                                         Text(
//                                           request.data!.name,
//                                           style: kSubHeadingTextStyle.copyWith(
//                                             color: kBlackColor,
//                                             fontSize: 18.sp,
//                                           ),
//                                           maxLines: 2,
//                                         ),
//                                         //Icon 3 dot menu at the end
//
//                                         //Container to show category
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 5, vertical: 2),
//                                           decoration: BoxDecoration(
//                                             color: kNeonColor,
//                                             borderRadius:
//                                                 BorderRadius.circular(5.r),
//                                           ),
//                                           child: Text(
//                                             catController.getCategoryName(
//                                                 int.parse(request.data!.category)),
//                                             style: ksmallGreyHeadingTextStyle
//                                                 .copyWith(
//                                               color: kPrimaryColor,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 12.sp,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 8.h,
//                                     ),
//                                     //Funds Required
//                                     FundingRequiredWidget(
//                                         amount: request.data!.totalFunds),
//                                     const Spacer(),
//                                     //divider
//                                     Container(
//                                       height: 1.h,
//                                       width: 0.9.sw,
//                                       color: kGreyColor.withOpacity(0.5),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         //Last Viewed Text Insdie a Container with kNeowColor
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 5, vertical: 2),
//                                           decoration: BoxDecoration(
//                                             color: kNeonColor,
//                                             borderRadius:
//                                                 BorderRadius.circular(5.r),
//                                           ),
//                                           child: Text(
//                                             StringConstants.lastViewed,
//                                             style: ksmallGreyHeadingTextStyle
//                                                 .copyWith(
//                                               color: kPrimaryColor,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 12.sp,
//                                             ),
//                                           ),
//                                         ),
//
//                                         //Date here
//                                         Text(
//                                           formatDate(request.data!.updatedAt!),
//                                           style: ksmallGreyHeadingTextStyle
//                                               .copyWith(
//                                             color: kBlackColor,
//                                             fontSize: 12.sp,
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         itemCount: snapshot.data!.length),
//                   );
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // dd/mm/yyyy format
// String formatDate(DateTime date) {
//   return "${date.day}/${date.month}/${date.year}";
// }
//
// class ShinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..shader = LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [
//           Colors.white.withOpacity(0.0),
//           Colors.white.withOpacity(0.25),
//           Colors.white.withOpacity(0.0),
//         ],
//         stops: [0.0, 0.5, 1.0],
//       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
//
//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
