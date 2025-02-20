import 'package:ethabah/core/constants/app_theme.dart';
import 'package:ethabah/core/routes/generated_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar', 'SA'),
        theme: ThemeData(
          fontFamily: kFontFamily,
          appBarTheme: AppBarTheme(
              backgroundColor: kPrimaryColor,
              elevation: 0,
              toolbarHeight: GetPlatform.isAndroid ? 60.h : null,
              centerTitle: true),
        ),
        title: 'Ethabah',
        getPages: AppRoutes.routes,
      ),
    );
  }
}
//Company id 
//test@test.com
//test1234

//Investor id 
//test2@test.com
//test1234