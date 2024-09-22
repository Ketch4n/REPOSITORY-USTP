import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/components/main_container.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/page1.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/page2.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/page3.dart';
import 'package:repository_ustp/src/utils/palette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RepositoryAdd extends StatefulWidget {
  const RepositoryAdd({super.key, required this.reload});
  final Function reload;

  @override
  State<RepositoryAdd> createState() => _RepositoryAddState();
}

class _RepositoryAddState extends State<RepositoryAdd> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.skyblueLite,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: LoginMainContainer(
                radius: 20,
                child: PageView(
                  controller: pageController,
                  children: const [
                    Page1(),
                    Page2(),
                    Page3(),
                  ],
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: 3,
              onDotClicked: (index) {
                pageController.jumpToPage(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
