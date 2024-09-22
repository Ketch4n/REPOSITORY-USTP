import 'package:flutter/material.dart';
import 'package:repository_ustp/src/auth/login/modules/add_title.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

import 'package:repository_ustp/src/utils/palette.dart';

import '../../repository_function.dart';

class StepperUpdate extends StatefulWidget {
  const StepperUpdate({
    super.key,
    required this.reload,
    required this.instance,
  });
  final Function reload;
  final ProjectModel instance;

  @override
  State<StepperUpdate> createState() => _StepperUpdateState();
}

class _StepperUpdateState extends State<StepperUpdate> {
  final TextEditingController _capstoneTitleController =
      TextEditingController();
  final TextEditingController _projectTypeController = TextEditingController();
  final TextEditingController _yearPublishedController =
      TextEditingController();

  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _authorsController = TextEditingController();
  final TextEditingController _attachmentController = TextEditingController();

  int _currentStep = 0;
  int _selectedValue = 0;

  int? _selectedItem;

  final List<int> _items = [1, 2, 3];

  void _onSubmit(context, reload) async {
    await RepositoryFunction.updateProject(
      context,
      widget.instance.id,
      _capstoneTitleController.text,
      _selectedItem!,
      _yearPublishedController.text,
      _selectedValue,
    );

    Navigator.of(context).pop();
    reload();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _capstoneTitleController.text = widget.instance.title;
      _projectTypeController.text =
          projectTypeBinaryValue(widget.instance.project_type);
      _selectedItem = widget.instance.project_type;
      _yearPublishedController.text = widget.instance.year_published.toString();
      // _selectedValue = widget.instance.privacy;
    });
  }

  @override
  void dispose() {
    // Dispose of all the controllers here
    _capstoneTitleController.dispose();
    _projectTypeController.dispose();
    _yearPublishedController.dispose();
    _groupNameController.dispose();
    _authorsController.dispose();
    _attachmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final ProjectModel project = widget.instance;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addTitle("UPDATE REPOSITORY", 20),
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
                  title: const Text('Privacy'),
                  content: Column(children: [
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
                  ]),
                  isActive: _currentStep >= 1,
                  state: _currentStep == 1
                      ? StepState.editing
                      : StepState.complete,
                ),
                Step(
                  title: const Text('Confirm'),
                  content: Row(
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
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: projectPrivacyValue(_selectedValue, context),
                      // ),
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
