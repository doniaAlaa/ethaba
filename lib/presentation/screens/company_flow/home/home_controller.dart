import 'package:ethabah/data/remote/comapny_stats_provider.dart';
import 'package:ethabah/data/remote/request_provider.dart';
import 'package:ethabah/models/company_stats_model.dart';
import 'package:ethabah/models/investment_company_model.dart';
import 'package:ethabah/models/investor_model.dart';
import 'package:ethabah/models/project_model.dart';
import 'package:ethabah/models/request_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {

  RxString totalFunds = '0'.obs;
  RxString acceptedReq = '0'.obs;
  RxString rejectedReq = '0'.obs;
  RxString pendingReq = '0'.obs;

  Future<RequestModel?> getCompanyRequest() async {
    final result = await RequestProvider.getRequests();
    totalFunds.value = result!.total!.requests_with_funds.toString();
    acceptedReq.value = result.total!.approved_requests.toString();
    rejectedReq.value = result.total!.rejected_requests.toString();
    pendingReq.value = result.total!.pending_requests.toString();

    return result;
  }

  Future<CompanyStatsModel> getCompanyStats() async {
    final result = await CompanyStatsProvider.getCompanyStats();
    return result;
  }

  Future<List<InvestmentFundCompany>?> getCompanyFund() async {
    final result = await RequestProvider.getCompanyFunds();
    return result;
  }
}
