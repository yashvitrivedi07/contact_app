import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/contact_page/contact_page.dart';
import 'package:flutter_application_1/views/hide_screen/views/hidescree.dart';
import 'package:flutter_application_1/views/home_screen/views/home_page.dart';
import 'package:flutter_application_1/views/splash_screen.dart';
import 'package:flutter_application_1/views/update_page/views/update_page.dart';

class AppRoutes{

  static Map<String, WidgetBuilder> routes = {
    '/': (context) => SplashScreen(),
    '/home_page': (context) => HomePage(),
    '/contact_page': (context) => ContactPage(),
    '/update_page': (context) => UpdatePage(),
    '/hide_page': (context) => Hidescree()
  };
}