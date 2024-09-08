import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/index/user_type_value.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/utils/text.dart';

ListTile addUserType() {
  return ListTile(
    title: Text(
      userBinaryValue(UserSession.type).toUpperCase(),
      style: CustomTextStyle.sideBarItems,
    ),
    trailing: const Icon(
      Icons.circle,
      color: Colors.green,
    ),
  );
}
