import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/duck_404.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Duck(status: "0", content: "Dashboard"),
    );
  }
}