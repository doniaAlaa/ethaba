import 'package:ethabah/core/constants/app_strings.dart';
import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/data/remote/admin_bank_account_provider.dart';
import 'package:ethabah/data/remote/comapny_stats_provider.dart';
import 'package:ethabah/data/remote/contact_support_provider.dart';
import 'package:ethabah/data/remote/request_provider.dart';
import 'package:ethabah/data/remote/wallet_transactions_data_provider.dart';
import 'package:ethabah/models/admin_bank_data_model.dart';
import 'package:ethabah/models/company_stats_model.dart';
import 'package:ethabah/models/investor_model.dart';
import 'package:ethabah/models/project_model.dart';
import 'package:ethabah/models/request_model.dart';
import 'package:ethabah/models/support_model.dart';
import 'package:ethabah/models/wallet_transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class ContactAndSupportController extends GetxController {


  Future<SupportModel> getContactData() async {
    final result = await ContactSupportProvider.getContactSupportData();
    return result;
  }




}
