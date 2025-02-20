import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:flutter/material.dart';

Color getStatusColor(String status) {
  switch (int.parse(status)) {
    case 0:
      // return Colors.green;
      return kNeonColor;

    case 1:
      return Colors.green;
    case 2:
      return Colors.blue;
    case 3:
      return Colors.orange;
    case 4:
      return Colors.red;
    default:
      return Colors.grey;
  }
}

String getStatusText(String status) {
  switch (int.parse(status)) {
    case 0:
      return StringConstants.investmentNotCompleted;
    case 1:
      return StringConstants.completed;
    case 2:
      return StringConstants.started;
    case 3:
      return StringConstants.waitingInvestors;
    case 4:
      return StringConstants.rejected;
    default:
      return StringConstants.unknown;
  }
}
