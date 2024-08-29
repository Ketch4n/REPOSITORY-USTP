import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/login_page.dart';
import 'package:repository_ustp/src/auth/signup/signup_page.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/data/user_binary_value.dart';
import 'package:repository_ustp/src/pages/index/index_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String index = '/index';
  static const String duck = '/duck';
  static const String signup = '/signup';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case index:
        final args = settings.arguments as int?;
        return MaterialPageRoute(
            builder: (_) => IndexPage(type: args ?? UserBinary.defaultValue));

      case signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());

      case duck:
        final args = settings.arguments as String?;
        return MaterialPageRoute(
            builder: (_) => Duck(
                status: args ?? "Page not found !",
                content: args ?? "reload the page and try again"));

      default:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
    }
  }
}
