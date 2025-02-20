import 'package:ethabah/core/constants/app_routes.dart';
import 'package:ethabah/presentation/screens/company_flow/account_verification/account_verification_screen.dart';
import 'package:ethabah/presentation/screens/company_flow/company_registration/company_registration_screen.dart';
import 'package:ethabah/presentation/screens/company_flow/company_requests/company_request_details.dart';
import 'package:ethabah/presentation/screens/company_flow/home/company_requests_screen.dart';
import 'package:ethabah/presentation/screens/company_flow/profile/profile_screen.dart';
import 'package:ethabah/presentation/screens/company_flow/project_details/project_details_com_screen.dart';
import 'package:ethabah/presentation/screens/company_flow/submit_request/submit_request_screen.dart';
import 'package:ethabah/presentation/screens/company_flow/dashboard/dashboard_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/all_investmentfund/all_investment_fund_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/home/inv_home_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/inv_dashboard/inv_dashboard_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/investment_fund_details/investment_details_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/investor_auth/investor_registration/investor_registration_screen.dart';
import 'package:ethabah/presentation/screens/investor_flow/invstor_profile/investor_profile.dart';
import 'package:ethabah/presentation/screens/onboard/auth_onboard_screen.dart';
import 'package:ethabah/presentation/screens/sign-in/sign_in_screen.dart';
import 'package:ethabah/presentation/screens/splash/splash_screen.dart';
import 'package:ethabah/presentation/screens/under_review/under_review_screen.dart';
import 'package:ethabah/presentation/screens/wallet/add_bank_account_screen.dart';
import 'package:ethabah/presentation/screens/wallet/bank_account_data_screen.dart';
import 'package:ethabah/presentation/screens/wallet/my_bank_account_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: RoutesConstants.splash,
      page: () => const SplashScreen(),
      // page: () => const SignInScreen(),

      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.authOnboard,
      page: () => const AuthOnboardScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.companyRegister,
      page: () => const CompanyRegistrationScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.accountVerification,
      page: () => AccountVerificationScreen(
        fullCompanyName: Get.arguments['fullCompanyName'],
        companyRegistration: Get.arguments['companyRegistration'],
        phoneNumber: Get.arguments['phoneNumber'],
        address: Get.arguments['address'],
        email: Get.arguments['email'],
        password: Get.arguments['password'],
      ),
      arguments: Get.arguments,
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.underReview,
      page: () => const UnderReviewScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.investorRegister,
      page: () => const InvestorRegistrationScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.signIn,
      page: () =>  SignInScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.dashboard,
      page: () => const DashboardScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.submitRequest,
      page: () => const SubmitRequestScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    // GetPage(
    //   name: RoutesConstants.projectDetailsCompany,
    //   page: () => ProjectDetailsComScreen(projectModel: Get.arguments),
    //   arguments: Get.arguments,
    //   transition: Transition.fade,
    //   transitionDuration: const Duration(milliseconds: 1000),
    // ),
    GetPage(
      name: RoutesConstants.investorDashboard,
      page: () => const InvDashboardScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.invHomeScreen,
      page: () => const MyInvestments(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.allInvestmentFundScreen,
      page: () => const AllInvestmentFundScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.profileScreen,
      page: () => const ProfileScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    // GetPage(
    //   name: RoutesConstants.addBankAccountScreen,
    //   page: () =>  AddBankAccountScreen(),
    //   transition: Transition.fade,
    //   transitionDuration: const Duration(milliseconds: 1000),
    // ),
    GetPage(
      name: RoutesConstants.bankAccountDataScreen,
      page: () => const AdminBankAccountDataScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.invProfileScreen,
      page: () => const InvProfileScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.companyRequestsScreen,
      page: () => const CompanyRequestsScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RoutesConstants.myBankAccountScreen,
      page: () => const MyBankAccountScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),

  ];
}
