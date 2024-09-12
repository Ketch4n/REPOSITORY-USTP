import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';
import 'package:repository_ustp/src/data/provider/click_event_keyword.dart';
import 'package:repository_ustp/src/data/provider/switch_role_signup.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/routes/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CLickEventProjectType>(
            create: (_) => CLickEventProjectType()),
        ChangeNotifierProvider<ClickEventProjectKeyword>(
            create: (_) => ClickEventProjectKeyword()),
        ChangeNotifierProvider<UserSession>(create: (_) => UserSession()),
        ChangeNotifierProvider<SwitchRoleSignup>(
            create: (_) => SwitchRoleSignup()),
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
      initialRoute: AppRoutes.index,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      // home: const Auth(),
    );
  }
}
