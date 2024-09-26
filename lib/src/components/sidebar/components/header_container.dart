import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/auth/login/components/ustp_logo.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/utils/palette.dart';
import 'package:repository_ustp/src/utils/text.dart';

class SideBarHeaderContainer extends StatelessWidget {
  const SideBarHeaderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPallete.primary,
      child: SizedBox(
        height: 160,
        width: double.maxFinite,
        child: Consumer<UserSession>(builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                child: USTPLogo(size: 80),
              ),
              ListTile(
                title: Text(
                  value.usernameValue ?? UserSession.username,
                  style: CustomTextStyle.sideBarItems,
                ),
                subtitle: Text(
                  value.emailValue ?? UserSession.email,
                  style: const TextStyle(color: Colors.white),
                  textScaler: const TextScaler.linear(1),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
