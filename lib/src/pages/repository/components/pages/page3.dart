import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/class/text_editing_controller.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/components/bottom_buttons.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key, required this.backward, required this.forward});
  final Future<void> Function() backward;
  final Future<void> Function() forward;

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final pages = PagesTextEditingController();
  PlatformFile? _selectedImg;
  PlatformFile? _selectedDoc;
  PlatformFile? _selectedClip;

  Future<void> _selectImg() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _selectedImg = result.files.first;

      final fileExtension = _selectedImg!.extension?.toLowerCase();
      if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
        customSnackBar(context, 0, "Added");
        pages.poster.text = _selectedImg!.name;
      } else {
        customSnackBar(context, 1, "Invalid Image format");
        pages.poster.clear();
      }
    }
  }

  Future<void> _selectDoc() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _selectedDoc = result.files.first;

      final fileExtension = _selectedDoc!.extension?.toLowerCase();
      if (['docx', 'pdf'].contains(fileExtension)) {
        customSnackBar(context, 0, "Added");
        pages.manuscript.text = _selectedDoc!.name;
      } else {
        customSnackBar(context, 1, "Invalid Document format");
        pages.manuscript.clear();
      }
    }
  }

  Future<void> _selectClip() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _selectedClip = result.files.first;

      final fileExtension = _selectedClip!.extension?.toLowerCase();
      if (['mp4'].contains(fileExtension)) {
        customSnackBar(context, 0, "Added");
        pages.video.text = _selectedClip!.name;
      } else {
        customSnackBar(context, 1, "Invalid Video Clip format");
        pages.video.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          addTitle("ADD NEW REPOSITORY", 20),
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
                        _selectDoc();
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
                        _selectImg();
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
                      _selectClip();
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
