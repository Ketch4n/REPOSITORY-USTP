// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/components/main_container.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/auth/signup/modules/add_bottom_content.dart';
import 'package:repository_ustp/src/auth/signup/signup_function.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/index/user_type_value.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  // int _selectedValue = 0;

  int? _selectedItem;

  final List<int> _items = [1, 2];

  callback() async {
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _roleController.text.isEmpty) {
      customSnackBar(context, 1, "Fields cannot be Empty !");
    } else {
      await signupFunction(context, _usernameController.text,
          _emailController.text, _passwordController.text, _selectedItem!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.skyblueLite,
      body: Center(
        child: Padding(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: addTitle("CREATE NEW ACCOUNT", 20),
                      ),
                      CustomTextField(
                        controller: _usernameController,
                        label: "Username",
                        readOnly: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _emailController,
                        label: "Email",
                        readOnly: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _passwordController,
                        label: "Password",
                        readOnly: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _roleController,
                        label: "Role",
                        readOnly: true,
                        suffix: PopupMenuButton<int>(
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          onSelected: (int value) {
                            setState(() {
                              _selectedItem = value;
                              _roleController.text = userBinaryValue(value);
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return _items.map((int type) {
                              return PopupMenuItem<int>(
                                value: type,
                                child: Text(userBinaryValue(type)),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      // CustomTextField(
                      //   controller: _roleController,
                      //   label: "Role",
                      // ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                        width: 250, child: addBottomContent(context, callback)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
