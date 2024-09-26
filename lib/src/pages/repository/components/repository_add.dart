import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/components/main_container.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/page1.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/page2.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/page3.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/page4_confirm.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: LoginMainContainer(
                radius: 20,
                child: PageView(
                  controller: pageController,
                  children: [
                    Page1(
                      forward: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                      reload: () => widget.reload(),
                    ),
                    Page2(
                      forward: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                      backward: () => pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                    ),
                    Page3(
                      backward: () => pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                      forward: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                    ),
                    RepositoryConfirm(
                      backward: () => pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                      reload: () => widget.reload(),
                      purposeID: 0,
                    )
                  ],
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: 4,
              // onDotClicked: (index) {
              //   pageController.jumpToPage(index);
              // },
            ),
          ],
        ),
      ),
    );
  }
}
