import 'dart:developer';

import 'package:ethabah/controller/categories_controller.dart';
import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/remote/request_provider.dart';
import 'package:ethabah/models/investment_fund_update_model.dart';
import 'package:ethabah/presentation/screens/investor_flow/project_update/projectupdate_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProjectUpdateScreen extends StatelessWidget {
  const ProjectUpdateScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final catController = Get.isRegistered<CategoriesController>()
        ? Get.find<CategoriesController>()
        : Get.put(CategoriesController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60,bottom: 40),
            child: Text(
              StringConstants.projectUpdates,
              style: kHeadingTextStyle.copyWith(
                color: kPrimaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FutureBuilder(
            future: RequestProvider.getInvestorUpdate(),
            builder: (context, snapshot) {
              log(snapshot.data.toString(), name: "Project Update Screen");
              if (ConnectionState.waiting == snapshot.connectionState) {
                return const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              }
              if (snapshot.data?.data.length.toString() == "0" ||
                  snapshot.data == null ||
                  snapshot.data == [] ||
                  snapshot.data?.data == [] ||
                  snapshot.data?.data == null) {
                return SizedBox(
                  height: 200.h,
                  child: Center(
                    child: Text(
                      StringConstants.noInvestmentFundsAvailble,
                      style: kHeadingTextStyle.copyWith(
                        color: kPrimaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }
              log(snapshot.data!.data.length.toString());
              final List<RequestInvestmentFundUpdate>? fund =
                  snapshot.data?.data;
              final List<ProjectUpdate>? projects = snapshot.data?.projects;
              return SizedBox();
              // return Expanded(
              //   child: ListView.builder(
              //     padding: EdgeInsets.zero,
              //     physics: ScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: fund?.length,
              //     itemBuilder: (context, index) {
              //       final payments = fund![index].investmentFund.payments;
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 10),
              //         child: GestureDetector(
              //           onTap: () => Get.to(
              //             () => ProjectupdateDetailScreen(
              //               fund: fund[index],
              //               projects: projects,
              //             ),
              //           ),
              //           child: Container(
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 10, vertical: 15),
              //             decoration: BoxDecoration(
              //               color: kSecondaryColor,
              //
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Column(
              //               children: [
              //                 Row(
              //                   children: [
              //                     Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         Text(
              //                           fund[index].investmentFund.name,
              //                           style: kSubtitleTextStyle.copyWith(
              //                               fontWeight: FontWeight.bold,
              //                               color: kNeonColor,
              //                               fontSize: 14.sp),
              //                         ),
              //                         SizedBox(
              //                           height: 5.h,
              //                         ),
              //                         Text(
              //                           catController.getCategoryName(fund[index]
              //                               .investmentFund
              //                               .categoryId),
              //                           style: kSubtitleTextStyle.copyWith(
              //                               fontWeight: FontWeight.bold,
              //                               color: kWhiteColor,
              //                               fontSize: 14.sp),
              //                         ),
              //                         SizedBox(
              //                           height: 5.h,
              //                         ),
              //                       ],
              //                     ),
              //                     const Spacer(),
              //                     Column(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       crossAxisAlignment: CrossAxisAlignment.center,
              //                       children: [
              //                         InkWell(
              //                           child: Container(
              //                             padding: EdgeInsets.symmetric(
              //                                 horizontal: 10.w, vertical: 5.h),
              //                             decoration: BoxDecoration(
              //                               color: kPrimaryColor,
              //                               borderRadius:
              //                                   BorderRadius.circular(5),
              //                             ),
              //                             child: Center(
              //                               child: Text(
              //                                 StringConstants.viewMore,
              //                                 style: TextStyle(
              //                                 //  color: kNeonColor,
              //                                   color: kWhiteColor,
              //
              //                                   fontSize: 12.sp,
              //                                   fontWeight: FontWeight.w500,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         )
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //                 if (payments.isNotEmpty) ...[
              //                   SizedBox(height: 10.h),
              //                   Text(
              //                     StringConstants.payments,
              //                     style: kHeadingTextStyle.copyWith(
              //                       color: kPrimaryColor,
              //                       fontSize: 14.sp,
              //                       fontWeight: FontWeight.w700,
              //                     ),
              //                   ),
              //                   ListView.builder(
              //                     padding: EdgeInsets.zero,
              //                     physics: const NeverScrollableScrollPhysics(),
              //                     shrinkWrap: true,
              //                     itemCount:
              //                         payments.length > 3 ? 3 : payments.length,
              //                     itemBuilder: (context, paymentIndex) {
              //                       final payment = payments[paymentIndex];
              //                       return Padding(
              //                         padding:
              //                             const EdgeInsets.symmetric(vertical: 5),
              //                         child: Container(
              //                           padding: const EdgeInsets.symmetric(
              //                               horizontal: 10, vertical: 10),
              //                           decoration: BoxDecoration(
              //                             color: kPrimaryColor.withOpacity(0.2),
              //                             borderRadius: BorderRadius.circular(5),
              //                           ),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               Text(
              //                                 "Payment ID: ${payment.id}",
              //                                 style: kSubtitleTextStyle.copyWith(
              //                                   color: kWhiteColor,
              //                                   fontSize: 12.sp,
              //                                 ),
              //                               ),
              //                               Text(
              //                                 "Amount: SAR ${payment.amount}",
              //                                 style: kSubtitleTextStyle.copyWith(
              //                                   color: kWhiteColor,
              //                                   fontSize: 12.sp,
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                   ),
              //                 ] else ...[
              //                   SizedBox(height: 10.h),
              //                   Text(
              //                     StringConstants.noPaymentsInitiated,
              //                     style: kSubtitleTextStyle.copyWith(
              //                       color: kPrimaryColor,
              //                       fontSize: 14.sp,
              //                       fontWeight: FontWeight.w700,
              //                     ),
              //                   ),
              //                 ],
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
