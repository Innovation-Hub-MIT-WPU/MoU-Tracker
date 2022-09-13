import 'package:flutter/material.dart';

class MultiStepForm extends StatefulWidget {
  const MultiStepForm({super.key});

  @override
  State<MultiStepForm> createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  int currStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multi-step form"),
        backgroundColor: Colors.blue,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: currStep,
        onStepTapped: (index) => setState(() => currStep = index),
        onStepContinue: () => setState(() {
          bool notLastStep = currStep != getSteps().length - 1;
          if (notLastStep) {
            currStep++;
          }
        }),
        onStepCancel: (() => setState(() {
              if (currStep != 0) {
                currStep--;
              }
            })),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        title: const Text("Account"),
        content: Container(),
        isActive: currStep >= 0,
        state: currStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Address"),
        content: Container(),
        isActive: currStep >= 1,
        state: currStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Complete"),
        content: Container(),
        isActive: currStep >= 2,
        state: currStep > 2 ? StepState.complete : StepState.indexed,
      ),
    ];
  }
}
