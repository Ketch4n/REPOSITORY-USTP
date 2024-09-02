import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/binary_value.dart';
import 'package:repository_ustp/src/data/session.dart';
import 'package:repository_ustp/src/utils/text.dart';

ListTile addUserType() {
  return ListTile(
    title: Text(
      userBinaryValue(UserSession.type ?? UserBinary.defaultValue)
          .toUpperCase(),
      style: CustomTextStyle.sideBarItems,
    ),
    trailing: const Icon(
      Icons.circle,
      color: Colors.green,
    ),
  );
}
