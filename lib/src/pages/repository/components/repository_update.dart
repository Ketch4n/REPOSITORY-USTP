import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/components/main_container.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/author_list.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/text_editing_controller.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/get_files.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/page1.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/page2.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/page4_confirm.dart';
import 'package:repository_ustp/src/utils/palette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RepositoryUpdate extends StatefulWidget {
  const RepositoryUpdate({
    super.key,
    required this.reload,
    required this.instance,
  });
  final Function reload;
  final ProjectModel instance;

  @override
  State<RepositoryUpdate> createState() => _RepositoryUpdateState();
}

class _RepositoryUpdateState extends State<RepositoryUpdate> {
  final PageController pageController = PageController();
  final pages = PagesTextEditingController();

  @override
  void initState() {
    PagesGetFiles.getFileRef(widget.instance.id);
    setState(() {
      pages.capstoneTitle.text = widget.instance.title;
      pages.projectType.text =
          projectTypeBinaryValue(widget.instance.project_type);
      pages.yearPublished.text = widget.instance.year_published;
      pages.groupName.text = widget.instance.group_name;
      AuthorList.lines = widget.instance.authors;
      pages.authors.text = AuthorList.lines.join('\n');
    });
    super.initState();
  }

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
                    RepositoryConfirm(
                      backward: () => pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                      reload: () => widget.reload(),
                      purposeID: widget.instance.id,
                    )
                  ],
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: 3,
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
