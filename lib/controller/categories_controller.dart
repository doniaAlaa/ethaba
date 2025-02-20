import 'dart:developer';

import 'package:ethabah/data/remote/categories_proivder.dart';
import 'package:ethabah/data/remote/invesment_fund.dart';
import 'package:ethabah/data/remote/request_provider.dart';
import 'package:ethabah/models/categories_model.dart';
import 'package:ethabah/models/investment_dropdown_model.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  List<CategoryModel> categories = [];
  RxBool isCategoriesLoaded = false.obs;
  RxString errorMessage = ''.obs;
  Map<int, String> projectNames = {};
  List<InvestmentDropdownItem> investmentNames = [];

  @override
  void onInit() {
    loadCategories();
    // loadProjectNames();
    loadInvestmentNames();
    super.onInit();
  }

  void loadCategories() async {
    try {
      categories = await CategoriesProivder.loadCategories();
      //log('Categories: $categories');
      isCategoriesLoaded.value = true;
    } catch (error) {
      errorMessage.value = error.toString();
    }
  }

  // void loadProjectNames() async {
  //   try {
  //     final response = await RequestProvider.getRequests();
  //     if (response != null) {
  //       for (final request in response) {
  //         projectNames[request.data!.id] = request.data!.name;
  //       }
  //     }
  //     //log('Project Names: $projectNames');
  //   } catch (error) {
  //     errorMessage.value = error.toString();
  //   }
  // }

  void loadInvestmentNames() async {
    try {
      final response = await InvestmentFundProvider.getInvestmentFundDropdown();
      investmentNames = response.data;
      log('Investment Names: $investmentNames');
    } catch (error) {
      errorMessage.value = error.toString();
    }
  }

  String getCategoryName(int id) {
    try {
      return categories.firstWhere((element) => element.id == id).name;
    } catch (e) {
      return 'N/A';
    }
  }

  String? getInvestmentName(int id) {
    try {
      return investmentNames.firstWhere((element) => element.id == id).name;
    } catch (e) {
      loadInvestmentNames();

      return 'N/A';
    }
  }

  String getProjectName(int requestId) {
    try {
      return projectNames[requestId] ?? 'N/A';
    } catch (e) {
      return 'N/A';
    }
  }
}
