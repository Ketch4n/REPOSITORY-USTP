import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/components/ustp_logo.dart';
import 'package:repository_ustp/src/auth/login/login_function.dart';
import 'package:repository_ustp/src/auth/login/utils/login_style.dart';
import 'package:repository_ustp/src/auth/login/components/main_container.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textbutton.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/utils/text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: LoginStyle.bg,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            _buildMainContainer(),
            const Positioned(
              top: -65,
              child: USTPLogo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContainer() {
    return LoginMainContainer(
      height: 470,
      width: 450,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          _buildTextFields(),
          _buildButton(),
          _buildFooterText(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 70, bottom: 20),
      child: Text(
        "PROJECT REPOSITORY\nSYSTEM",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTextFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
          text: "Username or Email",
          controller: usernameController,
        ),
        CustomTextField(
          text: "Password",
          controller: passwordController,
        ),
      ],
    );
  }

  Widget _buildButton() {
    return CustomButton(
      callback: () {
        final username = usernameController.text.trim();
        final password = passwordController.text.trim();
        LoginController.fetchUser(context, username, password);
      },
      child: const Text("LOG IN"),
    );
  }

  Widget _buildFooterText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create new account?",
                style: CustomTextStyle.subtext,
              ),
              CustomTextButton(text: "Sign Up", callback: () {})
            ],
          ),
          CustomTextButton(text: "Forgot Password", callback: () {})
        ],
      ),
    );
  }
}
