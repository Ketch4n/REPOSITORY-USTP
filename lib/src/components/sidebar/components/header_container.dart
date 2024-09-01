import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/components/ustp_logo.dart';
import 'package:repository_ustp/src/data/session.dart';
import 'package:repository_ustp/src/data/binary_value.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: USTPLogo(size: 80),
            ),
            ListTile(
              title: Text(
                UserSession.auth ? UserSession.username : UserBinary.username,
                style: CustomTextStyle.sideBarItems,
              ),
              subtitle: Text(
                UserSession.auth ? UserSession.email : UserBinary.email,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
