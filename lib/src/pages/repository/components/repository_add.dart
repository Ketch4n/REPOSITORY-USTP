import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/textfield.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class RepositoryAdd extends StatefulWidget {
  const RepositoryAdd({super.key});

  @override
  State<RepositoryAdd> createState() => _RepositoryAddState();
}

final TextEditingController _capstoneTitleController = TextEditingController();
final TextEditingController _projectTypeController = TextEditingController();
final TextEditingController _syController = TextEditingController();
int _currentStep = 0;

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
                        controller: _syController,
                        label: "School Year",
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
                        controller: _capstoneTitleController,
                        label: "Group Name",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _projectTypeController,
                        label: "Members",
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _projectTypeController,
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
                      const Text('Set Privacy / Display Summary / Confirm'),
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
