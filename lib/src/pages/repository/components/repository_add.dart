import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class RepositoryAdd extends StatefulWidget {
  const RepositoryAdd({super.key});

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

class _RepositoryAddState extends State<RepositoryAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
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
              onStepContinue: () {
                if (_currentStep < 2) {
                  setState(() {
                    _currentStep++;
                  });
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep--;
                  });
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
                      ),
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
                  content: Column(
                    children: [
                      CustomTextField(
                        controller: _groupNameController,
                        label: "Group Name",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _authorsController,
                        label: "Authors",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _attachmentController,
                        label: "Attachment Files",
                      ),
                    ],
                  ),
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
                                    title: "Web App",
                                    size: 10),
                                TextContent(
                                  alignment: Alignment.center,
                                  title: "Capstone Title",
                                  color: Colors.yellow,
                                ),
                                TextContent(
                                    alignment: Alignment.bottomCenter,
                                    title: "2024",
                                    size: 8),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Group Name"),
                              Text("Authors"),
                              Text("Files"),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Access to Repository Files ?"),
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
                            child: Text("Public"),
                          ),
                          RadioMenuButton(
                            value: 1,
                            groupValue: _selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedValue = value!;
                              });
                            },
                            child: Text("Private"),
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
        ),
      ),
    );
  }
}
