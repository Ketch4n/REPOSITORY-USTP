import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/access_controller_instance.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/bottom_buttons.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/upload_files.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/modules/pages_title.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key, required this.backward, required this.forward});
  final Future<void> Function() backward;
  final Future<void> Function() forward;

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const PagesTitle(),
          SizedBox(
            child: Column(
              children: [
                CustomTextField(
                  controller: pages.manuscript,
                  label: "Manuscript - (PDF/DOCX)",
                  readOnly: true,
                  suffix: IconButton(
                      icon: const Icon(Icons.file_upload_sharp),
                      onPressed: () {
                        PagesUploadFiles.selectDoc(context);
                      }),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: pages.poster,
                  label: "Poster - (JPG/PNG)",
                  readOnly: true,
                  suffix: IconButton(
                      icon: const Icon(Icons.file_upload_sharp),
                      onPressed: () {
                        PagesUploadFiles.selectImg(context);
                      }),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: pages.video,
                  label: "Video Clip - (MP4)",
                  readOnly: true,
                  suffix: IconButton(
                    icon: const Icon(Icons.file_upload_sharp),
                    onPressed: () {
                      PagesUploadFiles.selectClip(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          PageViewButtons(
            flabel: "NEXT",
            blabel: 'PREVIOUS',
            ffunction: () => widget.forward(),
            bfunction: () => widget.backward(),
          ),
        ],
      ),
    );
  }
}
