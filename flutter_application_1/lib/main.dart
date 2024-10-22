import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_routes/routes.dart';
import 'package:flutter_application_1/views/home_screen/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()), 
      ],
      child: const MyApp(), 
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.white,
        cardTheme: CardTheme(
          shadowColor: Colors.grey.shade300,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.amber), // Fixed here to use MaterialStateProperty
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: '/',
    );
  }
}
