import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/components/ustp_logo.dart';
import 'package:repository_ustp/src/data/binary_value.dart';

Widget addCornerUserType() {
  const EdgeInsets thisFile = EdgeInsets.only(top: 7.0, left: 8);
  return Positioned(
    top: -25,
    left: -30,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Hero(tag: 'Container-0-Hero', child: USTPLogo(size: 70)),
        Padding(
          padding: thisFile,
          child: Text(
            userBinaryValue(2).toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: thisFile,
          child: Icon(
            Icons.circle,
            color: Colors.green,
            size: 15,
          ),
        ),
      ],
    ),
  );
}
