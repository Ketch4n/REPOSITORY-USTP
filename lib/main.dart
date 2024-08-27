import 'package:flutter/material.dart';
import 'package:repository_ustp/src/routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'MontserratRegular'),
      initialRoute: AppRoutes.index,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      // home: const LoginPage(),
    );
  }
}
