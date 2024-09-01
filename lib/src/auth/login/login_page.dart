import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/components/ustp_logo.dart';
import 'package:repository_ustp/src/auth/login/login_function.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/auth/login/modules/build_footer_textbutton.dart';
import 'package:repository_ustp/src/auth/login/utils/login_style.dart';
import 'package:repository_ustp/src/auth/login/components/main_container.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
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
              top: -50,
              child: Hero(tag: 'Container-0-Hero', child: USTPLogo(size: 120)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: LoginMainContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addTitle("PROJECT REPOSITORY\nSYSTEM", null),
            _buildTextFields(),
            _buildButton(),
            buildFooterTextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            label: "Username or Email",
            controller: usernameController,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            obscure: _isObscure,
            label: "Password",
            controller: passwordController,
            suffix: IconButton(
              icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return CustomButton(
      callback: () {
        final username = usernameController.text.trim();
        final password = passwordController.text.trim();

        LoginFunctions.fetchUserCredentials(context, username, password);
      },
      child: const Text("LOG IN"),
    );
  }
}
