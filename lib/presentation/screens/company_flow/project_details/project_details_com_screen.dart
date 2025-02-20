// import 'dart:developer';
//
// import 'package:ethabah/controller/categories_controller.dart';
// import 'package:ethabah/core/constants/app_icons.dart';
// import 'package:ethabah/core/constants/app_spacing.dart';
// import 'package:ethabah/core/constants/app_strings.dart';
// import 'package:ethabah/core/constants/app_theme.dart';
// import 'package:ethabah/models/project_model.dart';
// import 'package:ethabah/models/request_model.dart';
// import 'package:ethabah/presentation/components/funding_rec_widget.dart';
// import 'package:ethabah/presentation/components/funding_req_widget.dart';
// import 'package:ethabah/presentation/others/all_comments_Screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ProjectDetailsComScreen extends StatefulWidget {
//   final RequestModel projectModel;
//   const ProjectDetailsComScreen({Key? key, required this.projectModel, q})
//       : super(key: key);
//
//   @override
//   _ProjectDetailsComScreenState createState() =>
//       _ProjectDetailsComScreenState();
// }
//
// class _ProjectDetailsComScreenState extends State<ProjectDetailsComScreen> {
//   bool isExpanded = false;
//
//   void toggleExpansion() {
//     setState(() {
//       isExpanded = !isExpanded;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final catController = Get.isRegistered<CategoriesController>()
//         ? Get.find<CategoriesController>()
//         : Get.put(CategoriesController());
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       appBar: AppBar(
//         title: Text(
//           StringConstants.details,
//           style:
//               kSubtitleTextStyle.copyWith(color: kNeonColor, fontSize: 18.sp),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_rounded,
//             color: kNeonColor,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                     height: 140.h,
//                     width: 130.w,
//                     decoration: const BoxDecoration(
//                       color: kPrimaryColor,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Image.asset(kSplashLogo)),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.projectModel.data!.name,
//                         style: TextStyle(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: kFontFamily,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         widget.projectModel.data!.user!.name,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: kFontFamily,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       FundingRequiredWidget(
//                           amount: widget.projectModel.data!.totalFunds),
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       // FundingRecievedWidget(
//                       //     amount: widget.projectModel.fundsReceived),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             // Project Description (show 3 lines with ellipses initially) with the More Info Button (if clicked expand the description)
//             Row(
//               children: [
//                 Text(StringConstants.projectDescription,
//                     style: ksmallHeadTextStyle),
//                 const Spacer(),
//                 TextButton(
//                   onPressed: toggleExpansion,
//                   child: Text(
//                     isExpanded
//                         ? StringConstants.seeLess
//                         : StringConstants.seeAll,
//                     style: kTextFieldTitleStyle.copyWith(
//                       fontWeight: FontWeight.w300,
//                       color: kPrimaryColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Text(widget.projectModel.data!.description,
//                 maxLines: isExpanded ? null : 3,
//                 overflow:
//                     isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
//                 style: ksmallDescTextStyle),
//             SizedBox(
//               height: 10.h,
//             ),
//             Container(
//               height: 1.h,
//               color: kGreyColor.withOpacity(0.5),
//             ),
//             SizedBox(
//               height: 15.h,
//             ),
//             // Project Category
//             Text(StringConstants.typeOfProject, style: ksmallHeadTextStyle),
//             SizedBox(
//               height: 5.h,
//             ),
//             Text(
//                 catController
//                     .getCategoryName(int.parse(widget.projectModel.data!.category)),
//                 style: ksmallDescTextStyle),
//             SizedBox(
//               height: 10.h,
//             ),
//             //dividing line
//             Container(
//               height: 1.h,
//               color: kGreyColor.withOpacity(0.5),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             //Purpose of Funding
//             Text(StringConstants.purposeOfFunding, style: ksmallHeadTextStyle),
//             SizedBox(
//               height: 5.h,
//             ),
//             Text(widget.projectModel.data!.purposeOfFunding,
//                 style: ksmallDescTextStyle),
//             SizedBox(
//               height: 10.h,
//             ),
//             //dividing line
//             Container(
//               height: 1.h,
//               color: kGreyColor.withOpacity(0.5),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             //Required Funds
//             Text(StringConstants.fundingRequired, style: ksmallHeadTextStyle),
//             SizedBox(
//               height: 5.h,
//             ),
//             Text('SAR ${widget.projectModel.data!.totalFunds}',
//                 style: ksmallDescTextStyle),
//             SizedBox(
//               height: 10.h,
//             ),
//             if (widget.projectModel.data!.url != null &&
//                 widget.projectModel.data!.url!.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 1.h,
//                     color: kGreyColor.withOpacity(0.5),
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   // Required Funds
//                   Text(StringConstants.documents, style: ksmallHeadTextStyle),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   // Download buttons
//                   ...widget.projectModel.data!.imageUrls.map((imageUrl) {
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 10.h),
//                       child: GestureDetector(
//                         onTap: () {
//                           log('url: $imageUrl');
//                           launchUrl(Uri.parse(imageUrl));
//                         },
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 20.w, vertical: 10.h),
//                           decoration: BoxDecoration(
//                             color: kPrimaryColor,
//                             borderRadius: BorderRadius.circular(15.r),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 StringConstants.download,
//                                 style: kTextFieldTitleStyle.copyWith(
//                                     color: kWhiteColor),
//                               ),
//                               smallWidth(),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 0.w, vertical: 0.h),
//                                 decoration: const BoxDecoration(
//                                   color: kWhiteColor,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(
//                                   Icons.download,
//                                   color: kPrimaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ],
//               )
//             //Comments of Investors
//             // Row(
//             //   children: [
//             //     Text(StringConstants.investor, style: ksmallHeadTextStyle),
//             //     const Spacer(),
//             //     TextButton(
//             //       onPressed: () {
//             //         Navigator.push(
//             //           context,
//             //           MaterialPageRoute(
//             //             builder: (context) => AllCommentsScreen(
//             //               investors: widget.projectModel.investors ?? [],
//             //             ),
//             //           ),
//             //         );
//             //       },
//             //       child: Text(
//             //         StringConstants.seeAll,
//             //         style: kTextFieldTitleStyle.copyWith(
//             //           fontWeight: FontWeight.w300,
//             //           color: kPrimaryColor,
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             // SizedBox(
//             //   height: 5.h,
//             // ),
//             // (widget.projectModel.investors == null ||
//             //         widget.projectModel.investors!.isEmpty)
//             //     ? Text(StringConstants.noComments, style: ksmallDescTextStyle)
//             //     : ListView.builder(
//             //         padding: EdgeInsets.zero,
//             //         shrinkWrap: true,
//             //         physics: const NeverScrollableScrollPhysics(),
//             //         itemCount: widget.projectModel.investors!.length > 3
//             //             ? 3
//             //             : widget.projectModel.investors!.length,
//             //         itemBuilder: (context, index) {
//             //           return Padding(
//             //             padding: const EdgeInsets.only(bottom: 10.0),
//             //             child: Container(
//             //               padding: const EdgeInsets.symmetric(
//             //                   vertical: 10, horizontal: 10),
//             //               decoration: BoxDecoration(
//             //                 color: kPrimaryColor.withOpacity(0.4),
//             //                 borderRadius: BorderRadius.circular(10),
//             //               ),
//             //               child: Row(
//             //                 mainAxisAlignment: MainAxisAlignment.start,
//             //                 crossAxisAlignment: CrossAxisAlignment.center,
//             //                 children: [
//             //                   Container(
//             //                     height: 40.h,
//             //                     width: 40.w,
//             //                     decoration: const BoxDecoration(
//             //                       color: kPrimaryColor,
//             //                       shape: BoxShape.circle,
//             //                     ),
//             //                   ),
//             //                   SizedBox(
//             //                     width: 10.w,
//             //                   ),
//             //                   Flexible(
//             //                       child: Column(
//             //                     crossAxisAlignment: CrossAxisAlignment.start,
//             //                     children: [
//             //                       // Investor Name
//             //                       Text(
//             //                         widget.projectModel.investors![index].name,
//             //                         style: TextStyle(
//             //                           fontSize: 16.sp,
//             //                           fontWeight: FontWeight.bold,
//             //                           color: kBlackColor,
//             //                         ),
//             //                       ),
//             //                       //Amount
//             //                       SizedBox(height: 5.h),
//             //                       Text(
//             //                         'SAR ${widget.projectModel.investors![index].amount}',
//             //                         style: TextStyle(
//             //                           fontSize: 14.sp,
//             //                           fontWeight: FontWeight.w700,
//             //                           color: kSecondaryColor,
//             //                         ),
//             //                       ),
//             //                     ],
//             //                   )),
//             //                 ],
//             //               ),
//             //             ),
//             //           );
//             //         },
//             //       )
//           ],
//         ),
//       ),
//     );
//   }
// }
