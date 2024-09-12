import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/utils/palette.dart';

import '../repository_function.dart';

class RepositoryAdd extends StatefulWidget {
  const RepositoryAdd({super.key, required this.reload});
  final Function reload;

  @override
  State<RepositoryAdd> createState() => _RepositoryAddState();
}

final TextEditingController _capstoneTitleController = TextEditingController();
final TextEditingController _projectTypeController = TextEditingController();
final TextEditingController _yearPublishedController = TextEditingController();

final TextEditingController _groupNameController = TextEditingController();
final TextEditingController _authorsController = TextEditingController();
final TextEditingController _attachmentController = TextEditingController();

int _currentStep = 0;
int _selectedValue = 0;

int? _selectedItem;

final List<int> _items = [1, 2, 3];

List<String?> lines = [];

bool _visible = false;

void _onSubmit(context, reload) async {
  await RepositoryFunction.postProjects(
    context,
    _capstoneTitleController.text,
    _selectedItem!,
    _selectedValue,
    _yearPublishedController.text,
    _groupNameController.text,
    lines,
  );
  Navigator.of(context).pop();
  reload();
}

class _RepositoryAddState extends State<RepositoryAdd> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addTitle("ADD NEW REPOSITORY", 20),
          Container(
            height: 470,
            width: 450,
            decoration: BoxDecoration(
              color: ColorPallete.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              onStepTapped: (int step) {
                setState(() {
                  _currentStep = step;
                });
              },
              onStepContinue: () async {
                if (_currentStep < 2) {
                  setState(() {
                    _currentStep++;
                  });
                } else if (_currentStep == 2) {
                  _onSubmit(context, widget.reload);
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep--;
                  });
                } else if (_currentStep == 0) {
                  Navigator.of(context).pop();
                }
              },
              steps: <Step>[
                Step(
                  title: const Text('Project'),
                  content: Column(
                    children: [
                      CustomTextField(
                        controller: _capstoneTitleController,
                        label: "Capstone Title",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _projectTypeController,
                        label: "Project Type",
                        suffix: PopupMenuButton<int>(
                          icon: const Icon(Icons.menu),
                          onSelected: (int value) {
                            setState(() {
                              _selectedItem = value;
                              _projectTypeController.text =
                                  projectTypeBinaryValue(value);
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return _items.map((int type) {
                              return PopupMenuItem<int>(
                                value: type,
                                child: Text(projectTypeBinaryValue(type)),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      // Container(
                      //   height: 60,
                      //   width: double.maxFinite,
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(5)),
                      //   child: ProjectDropdownCategory(),
                      // ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _yearPublishedController,
                        label: "Year Published",
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep == 0
                      ? StepState.editing
                      : StepState.complete,
                ),
                Step(
                  title: const Text('Details'),
                  content: Column(children: [
                    CustomTextField(
                      controller: _groupNameController,
                      label: "Group Name",
                    ),
                    const SizedBox(height: 10),
                    // CustomTextField(
                    //   controller: _authorsController,
                    //   label: "Authors",
                    // ),
                    TextField(
                      controller: _authorsController,
                      keyboardType:
                          TextInputType.multiline, // Allow multiline input
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Authors...',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _visible = !_visible;
                            });
                          },
                          icon: const Icon(Icons.info_outline),
                        ),
                        fillColor: Colors.white,
                      ),

                      onChanged: (text) {
                        setState(
                          () {
                            lines = text.split('\n');
                            if (lines.length > 4) {
                              lines = lines.sublist(0, 4);
                              _authorsController.text = lines.join('\n');
                              _authorsController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: _authorsController.text.length),
                              );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _visible
                        ? const Text("maximum of 4 authors (by new line)")
                        : const SizedBox()
                    // SizedBox(
                    //   height: 100,
                    //   child: Expanded(
                    //     child: ListView(
                    //       children: List.generate(
                    //         lines.length,
                    //         (index) =>
                    //             Text('Line ${index + 1}: ${lines[index]}'),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ]),
                  isActive: _currentStep >= 1,
                  state: _currentStep == 1
                      ? StepState.editing
                      : StepState.complete,
                ),
                Step(
                  title: const Text('Confirm'),
                  content:
                      // const Text('Set Privacy / Display Summary / Confirm'),

                      Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 190,
                            width: 140,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset("assets/hardbound.png"),
                                TextContent(
                                    alignment: Alignment.topCenter,
                                    title: _projectTypeController.text,
                                    size: 10),
                                TextContent(
                                  alignment: Alignment.center,
                                  title: _capstoneTitleController.text,
                                  color: Colors.yellow,
                                ),
                                TextContent(
                                    alignment: Alignment.bottomCenter,
                                    title: _yearPublishedController.text,
                                    size: 8),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Group Name"),
                              Text(
                                _groupNameController.text,
                                style: const TextStyle(color: Colors.blue),
                              ),
                              const Text("Authors"),
                              Text(
                                _authorsController.text,
                                style: const TextStyle(color: Colors.blue),
                              ),

                              // ListTile(
                              //   title: Text(_groupNameController.text),
                              //   subtitle: Text("Files"),
                              // ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Access to Repository Files ?"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RadioMenuButton(
                            value: 0,
                            groupValue: _selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedValue = value!;
                              });
                            },
                            child: const Text("Public"),
                          ),
                          RadioMenuButton(
                            value: 1,
                            groupValue: _selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedValue = value!;
                              });
                            },
                            child: const Text("Private"),
                          ),
                        ],
                      ),

                      // Text(_capstoneTitleController.text),
                      // Text(_projectTypeController.text),
                      // Text(_yearPublishedController.text),
                      // Text(_groupNameController.text),
                      // Text(_authorsController.text),
                      // Text(_attachmentController.text),
                    ],
                  ),
                  isActive: _currentStep >= 2,
                  state: _currentStep == 2
                      ? StepState.editing
                      : StepState.complete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
