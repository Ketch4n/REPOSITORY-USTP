import 'package:flutter/material.dart';

class CapstoneTeamsPage extends StatefulWidget {
  const CapstoneTeamsPage({super.key});

  @override
  State<CapstoneTeamsPage> createState() => _CapstoneTeamsPageState();
}

class _CapstoneTeamsPageState extends State<CapstoneTeamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: 60, width: 60, child: Image.asset("assets/ustp_v2.png")),
      ),
    );
  }
}
