import 'package:ecommerce_app/core/colors.dart';
import 'package:ecommerce_app/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: AppColors.white,
          titleTextStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(
            color: AppColors.black,
          ),
          centerTitle: true,
        ),
        useMaterial3: false,
      ),
      home: const SplashPage(),
    );
  }
}
