import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/modules/categories/categories_page.dart';
import 'package:quiosque/app/modules/home/home_page.dart';
import 'package:quiosque/app/modules/printer_setup/printer_setup_page.dart';
import 'package:quiosque/app/modules/products/pages/product_management_page.dart';
import 'package:quiosque/app/modules/products/products_page.dart';
import 'package:quiosque/app/modules/splash/splash_screen.dart';
import 'package:quiosque/app/modules/table_order/pages/receipt/receipt_page.dart';
import 'package:quiosque/app/modules/table_order/table_order_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_BR';
    initializeDateFormatting('pt_BR', null);
    const Color _primaryColor = Color(0xFFF70106);
    return MaterialApp(
      title: 'Kiosque Tô na Praia',
      theme: ThemeData(
        primaryColor: _primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: _primaryColor,
        ),
        disabledColor: _primaryColor.withAlpha(120),
        checkboxTheme: CheckboxThemeData(
          side: const BorderSide(color: Colors.black),
          fillColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return _primaryColor.withAlpha(120);
            }
            return _primaryColor;
          }),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: _primaryColor,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: _primaryColor,
            side: const BorderSide(
              color: _primaryColor,
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: _primaryColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: _primaryColor,
            ),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: _primaryColor,
          selectionHandleColor: _primaryColor,
          selectionColor: _primaryColor.withAlpha(60),
        ),
        listTileTheme: const ListTileThemeData(
          selectedTileColor: _primaryColor,
          selectedColor: _primaryColor,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _primaryColor,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: _primaryColor,
        ),
      ),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        HomePage.route: (context) => const HomePage(),
        TableOrderPage.route: (context) => const TableOrderPage(),
        ProductsPage.route: (context) => const ProductsPage(),
        CategoriesPage.route: (context) => const CategoriesPage(),
        ProductManagementPage.route: (context) {
          final routeArgument = ModalRoute.of(context)?.settings.arguments;
          if (routeArgument != null) {
            final ProductModel? product = routeArgument as ProductModel?;
            return ProductManagementPage(
              product: product,
            );
          } else {
            return const ProductManagementPage();
          }
        },
        ReceiptPage.route: (context) {
          final routeArguments = ModalRoute.of(context)!.settings.arguments;
          final int tableNumber = routeArguments as int;
          return ReceiptPage(tableNumber: tableNumber);
        },
        PrinterSetupPage.route: (context) {
          final routeArguments = ModalRoute.of(context)?.settings.arguments;
          final bool? fromSnackbar = routeArguments as bool?;
          return PrinterSetupPage(fromSnackbar: fromSnackbar);
        },
      },
    );
  }
}
