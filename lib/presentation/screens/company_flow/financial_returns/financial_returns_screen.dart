import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/shared/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class FinancialReturnsScreen extends StatelessWidget {
  const FinancialReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FinancialReturnsController());

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'العوائد المالية',
          style: TextStyle(color: kNeonColor, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kNeonColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 5, top: 20),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    // getDrawingHorizontalLine: (value) {
                    //   return FlLine(
                    //     color: Colors.grey.withOpacity(0.2),
                    //     strokeWidth: 1,
                    //   );
                    // },
                    // getDrawingVerticalLine: (value) {
                    //   return FlLine(
                    //     color: Colors.grey.withOpacity(0.2),
                    //     strokeWidth: 1,
                    //   );
                    // },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35.w,
                        // interval: controller.getInterval(),
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              controller.formatNumber(value),
                              style: TextStyle(
                                color: kHintTextColor,
                                fontSize: 10.sp,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        // maxIncluded: false,
                        // minIncluded: false,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            controller.months[value.toInt()],
                            style: TextStyle(
                              color: kHintTextColor,
                              fontSize: 10.sp,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    //only bottom and left borders
                    border: const Border(
                      bottom: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                      left: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: controller.financialReturns.entries
                          .map((e) => FlSpot(
                              controller.months.indexOf(e.key).toDouble(),
                              e.value.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: kPrimaryColor,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        // color: kPrimaryColor.withOpacity(0.2),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            kPrimaryColor.withOpacity(0.6),
                            kPrimaryColor.withOpacity(0.3),
                            kPrimaryColor.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: const LineTouchTooltipData(),
                    touchCallback:
                        (FlTouchEvent event, LineTouchResponse? response) {
                      if (response != null && response.lineBarSpots != null) {
                        final spot = response.lineBarSpots!.first;
                        final month = controller.months[spot.x.toInt()];
                        final funding = spot.y.toInt();
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text('$month: $funding SAR'),
                        //   ),
                        // );
                      }
                    },
                    handleBuiltInTouches: true,
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> indicators) {
                      return indicators.map((int index) {
                        const line = FlLine(
                          color: Colors.grey,
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        );
                        return const TouchedSpotIndicatorData(
                          line,
                          FlDotData(show: true),
                        );
                      }).toList();
                    },
                  ),
                ),
                // curve: Curves.bounceInOut,
                // duration: const Duration(milliseconds: 250),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 30.h),
              child: Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                height: 100.h,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //show min and max funding with months also CompanyName from SharedPref.getUser
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(StringConstants.returnOfInvestment,
                                  style: kHeadingTextStyle.copyWith(
                                      color: kPrimaryColor)),
                              FutureBuilder(
                                  future: SharedPref.getUser(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                          snapshot.data?.name ?? "Loading...",
                                          style: kHeadingTextStyle.copyWith(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500,
                                              color: kBlackColor));
                                    }
                                    return Text("Loading...",
                                        style: kSubtitleTextStyle.copyWith(
                                            color: kBlackColor));
                                  }),
                              SizedBox(
                                height: 10.h,
                              ),
                              //Total Funds for Investments

                              Text(
                                  "SAR ${controller.maxFunding.toStringAsFixed(2)}",
                                  style: kHeadingTextStyle.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      wordSpacing: 2,
                                      color: kBlackColor)),
                            ],
                          ),
                          // Spacer(),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 16.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children:
                    //         controller.getPercentageChanges().map((change) {
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(vertical: 2.0),
                    //         child: Row(
                    //           children: [
                    //             Icon(
                    //               change['percentage'] >= 0
                    //                   ? Icons.keyboard_arrow_up
                    //                   : Icons.keyboard_arrow_down,
                    //               color: change['percentage'] >= 0
                    //                   ? Colors.green
                    //                   : Colors.red,
                    //               size: 16.sp,
                    //             ),
                    //             SizedBox(width: 5.w),
                    //             Directionality(
                    //               textDirection: TextDirection.ltr,
                    //               child: Row(
                    //                 children: [
                    //                   Text(
                    //                     "${change['month']}: ",
                    //                     style: kSubtitleTextStyle.copyWith(
                    //                       fontWeight: FontWeight.bold,
                    //                       color: Colors.black,
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     "${change['percentage'].toStringAsFixed(2)}%",
                    //                     style: kSubtitleTextStyle.copyWith(
                    //                       fontWeight: FontWeight.bold,
                    //                       color: change['percentage'] >= 0
                    //                           ? Colors.green
                    //                           : Colors.red,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                  ],
                ),
                // Add any additional content here
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FinancialReturnsController extends GetxController {
  Map<String, dynamic> financialReturns = {
    "JAN": 1000.00,
    "FEB": 1200.00,
    "MAR": 800.00,
    "APR": 1500.00,
    "MAY": 1000.00,
    "JUN": 1800.00,
    "JUL": 2000.00,
    "AUG": 2500.00,
    "SEP": 900.00,
  };

  List<String> months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP"
  ];

  double get maxFunding =>
      financialReturns.values.reduce((a, b) => a > b ? a : b);
  double get minFunding =>
      financialReturns.values.reduce((a, b) => a < b ? a : b);

  double getInterval() {
    final diff = maxFunding - minFunding;
    return diff / 4;
  }

  String formatNumber(double value) {
    if (value >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(1)}B';
    } else if (value >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(1)}M';
    } else if (value >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(1)}K';
    } else {
      return value.toStringAsFixed(0);
    }
  }

  List<Map<String, dynamic>> getPercentageChanges() {
    List<Map<String, dynamic>> changes = [];
    for (int i = 1; i < months.length; i++) {
      double previous = financialReturns[months[i - 1]];
      double current = financialReturns[months[i]];
      double percentageChange = ((current - previous) / previous) * 100;
      changes.add({
        'month': months[i - 1],
        'percentage': percentageChange,
      });
    }
    return changes;
  }
}
