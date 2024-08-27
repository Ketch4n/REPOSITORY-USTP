import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/user_binary_value.dart';
import 'package:repository_ustp/src/utils/text.dart';

ListTile addUserType() {
  return ListTile(
    title: Text(
      userBinaryValue(UserBinary.defaultValue).toUpperCase(),
      style: CustomTextStyle.sideBarItems,
    ),
    trailing: const Icon(
      Icons.circle,
      color: Colors.green,
    ),
  );
}
