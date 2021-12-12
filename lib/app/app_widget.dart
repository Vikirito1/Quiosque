import 'package:flutter/material.dart';
import 'package:quiosque/app/modules/home/home_page.dart';
import 'package:quiosque/app/modules/splash/splash_screen.dart';
import 'package:quiosque/app/modules/table_order/table_order_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color _primaryColor = Color(0xFFF70106);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: _primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: _primaryColor,
        ),
        disabledColor: _primaryColor.withAlpha(120),
      ),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        HomePage.route: (context) => const HomePage(),
        TableOrderPage.route: (context) => const TableOrderPage(),
      },
    );
  }
}
