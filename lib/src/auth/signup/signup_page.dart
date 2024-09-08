import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/components/main_container.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/auth/signup/modules/add_bottom_content.dart';
import 'package:repository_ustp/src/auth/signup/modules/add_corner_usertype.dart';
import 'package:repository_ustp/src/auth/signup/signup_function.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/provider/switch_role_signup.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwrodController = TextEditingController();
  void callback() async {
    await signupFunction(context, _usernameController.text,
        _emailController.text, _passwrodController.text, SwitchRoleSignup.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.secondary,
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: LoginMainContainer(
                radius: 10.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          addTitle("CREATE NEW ACCOUNT", 20),
                          CustomTextField(
                            controller: _usernameController,
                            label: "Username",
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _emailController,
                            label: "Email",
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _passwrodController,
                            label: "Password",
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    addBottomContent(context, callback),
                  ],
                ),
              ),
            ),
            addCornerUserType(),
          ],
        ),
      ),
    );
  }
}
