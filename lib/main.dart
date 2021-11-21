import 'package:flutter/material.dart';
import 'package:quiosque/app/app_widget.dart';
import 'package:quiosque/app/core/config/service_locator_config.dart';

void main() {
  configureDependencies();
  runApp(const AppWidget());
}
