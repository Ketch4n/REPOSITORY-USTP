import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/data/session.dart';
import 'package:repository_ustp/src/routes/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CardTypeClick>(create: (_) => CardTypeClick()),
        ChangeNotifierProvider<UserSession>(create: (_) => UserSession()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'MontserratRegular'),
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      // home: const Auth(),
    );
  }
}

// class Auth extends StatefulWidget {
//   const Auth({super.key});

//   @override
//   State<Auth> createState() => _AuthState();
// }

// class _AuthState extends State<Auth> {
//   bool showLoginScreen = true;
//   String role = "";

//   @override
//   void initState() {
//     super.initState();
//     checkUserSession();
//   }

//   // Check if a user session exists in SharedPreferences
//   Future<void> checkUserSession() async {
//     // final auth = loadPrefData("u_AUTH");
//     final id = loadPrefData("u_ID");

//     // If user session exists, navigate to Home; otherwise, show Login
//     setState(() {
//       showLoginScreen = id == null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: showLoginScreen ? const LoginPage() : const IndexPage());
//   }
// }
