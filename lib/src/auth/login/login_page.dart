import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/components/ustp_logo.dart';
import 'package:repository_ustp/src/auth/login/login_function.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/auth/login/modules/build_footer_textbutton.dart';
import 'package:repository_ustp/src/auth/login/utils/login_style.dart';
import 'package:repository_ustp/src/auth/login/components/main_container.dart';
import 'package:repository_ustp/src/components/button.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/utils/screen_breakpoint.dart';

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
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBody(height),
    );
  }

  Widget _buildBody(heigth) {
    final height = heigth;
    return Container(
      decoration: LoginStyle.bg,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            _buildMainContainer(),
            Positioned(
              top: height <= tabletBreakpoint ? -40 : -50,
              child: USTPLogo(size: height <= tabletBreakpoint ? 100 : 120),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '" Updated Projects and\nRepository for Accumulated\nDocumentations and Researches "',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            addTitle("UpPARADoR", null, null),
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
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            label: "Username",
            controller: usernameController,
            readOnly: false,
          ),
          CustomTextField(
            obscure: _isObscure,
            label: "Password",
            readOnly: false,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: CustomButton(
        callback: () {
          final username = usernameController.text.trim();
          final password = passwordController.text.trim();

          LoginFunctions.fetchUserCredentials(context, username, password);
        },
        child: const Text("LOG IN"),
      ),
    );
  }
}
