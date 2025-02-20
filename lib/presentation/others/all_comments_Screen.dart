// import 'package:flutter/material.dart';
// import 'package:ethabah/models/investor_model.dart';
// import 'package:ethabah/core/constants/app_theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AllCommentsScreen extends StatelessWidget {
//   final List<Investor> investors;

//   const AllCommentsScreen({Key? key, required this.investors})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       appBar: AppBar(
//         title: const Text('Investors'),
//         backgroundColor: kPrimaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: investors.length,
//           itemBuilder: (context, index) {
//             final investor = investors[index];
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 10.0),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: kPrimaryColor.withOpacity(0.4),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       investor.name,
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: kBlackColor,
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       'Amount: SAR ${investor.amount}',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: kBlackColor,
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     // Text(
//                     //   investor.comment,
//                     //   style: TextStyle(
//                     //     fontSize: 14.sp,
//                     //     color: kBlackColor,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
