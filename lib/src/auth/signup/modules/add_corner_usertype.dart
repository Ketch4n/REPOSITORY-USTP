// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:repository_ustp/src/auth/login/components/ustp_logo.dart';
// import 'package:repository_ustp/src/data/index/user_type_value.dart';
// import 'package:repository_ustp/src/data/provider/switch_role_signup.dart';

// Widget addCornerUserType() {
//   const EdgeInsets thisFile = EdgeInsets.only(top: 7.0, left: 8);
//   return Positioned(
//     top: -15,
//     left: 0,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         const Hero(tag: 'Container-0-Hero', child: USTPLogo(size: 70)),
//         Padding(
//           padding: thisFile,
//           child: Consumer<SwitchRoleSignup>(builder: (context, value, child) {
//             return Text(
//               userBinaryValue(value.typeNew ? 1 : 2).toString(),
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             );
//           }),
//         ),
//         Padding(
//           padding: thisFile,
//           child: Consumer<SwitchRoleSignup>(
//             builder: (context, switchRole, child) {
//               return IconButton(
//                 color: Colors.green,
//                 onPressed: () {
//                   switchRole.toggleType(); // Use method to toggle
//                 },
//                 icon: const Icon(Icons.swap_horizontal_circle_rounded),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }
