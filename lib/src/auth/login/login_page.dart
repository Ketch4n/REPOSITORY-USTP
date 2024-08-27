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
              top: -65,
              child: USTPLogo(size: 125),
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
          addTitle(),
          _buildTextFields(),
          _buildButton(),
          buildFooterTextButton(),
        ],
      ),
    );
  }

  Widget _buildTextFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
          obscure: false,
          text: "Username or Email",
          controller: usernameController,
        ),
        CustomTextField(
          obscure: _isObscure,
          text: "Password",
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
}
