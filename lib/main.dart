import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/data/provider/adding_repo_controllers.dart';
import 'package:repository_ustp/src/data/provider/author_list.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';
import 'package:repository_ustp/src/data/provider/click_event_keyword.dart';
import 'package:repository_ustp/src/data/provider/index_menu_item.dart';
import 'package:repository_ustp/src/data/provider/project_type_add.dart';
import 'package:repository_ustp/src/data/provider/switch_role_signup.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDm_FRnemcT4536tGlkmKyQPrfHx4FFPOQ",
      authDomain: "repository-ustp.firebaseapp.com",
      projectId: "repository-ustp",
      storageBucket: "repository-ustp.appspot.com",
      messagingSenderId: "357457955703",
      appId: "1:357457955703:web:74eff539489c9e438daf72",
      measurementId: "G-1YE5PGQRX5",
    ),
  );
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
        ChangeNotifierProvider<IndexMenuItem>(create: (_) => IndexMenuItem()),
        ChangeNotifierProvider(create: (_) => AddingRepo()),
        ChangeNotifierProvider(create: (_) => ProjectTypeAdd()),
        ChangeNotifierProvider(create: (_) => AuthorList())
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
