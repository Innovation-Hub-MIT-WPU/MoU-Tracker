import 'package:MouTracker/screens/mou_details/completion.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';


class TrackTab extends StatefulWidget {
  const TrackTab({Key? key}) : super(key: key);

  @override
  _TrackTabState createState() => _TrackTabState();
}

class _TrackTabState extends State<TrackTab> {
  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme:
                        const ColorScheme.light(primary: Colors.green)),
                child: Stepper(
                  type: stepperType,
                  physics: const ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: () {
                    if(_currentStep==5)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MOUApproved()),
                        );
                      }
                    else {
                      setState(() => _currentStep += 1);
                    }
                  },
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      state: _currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                      title: const Text(
                        'Completed the MoU',
                        style: TextStyle(color: Colors.black),
                      ),
                      content: const Text(""),
                      isActive: _currentStep >= 0,
                    ),
                    Step(
                      state: _currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                      title: const Text(
                        'Sent for Approval',
                        style: TextStyle(color: Colors.black),
                      ),
                      content: const Text(""),
                      isActive: _currentStep >= 0,
                    ),
                    Step(
                      state: _currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                      title: const Text(
                        'Approved by Head',
                        style: TextStyle(color: Colors.black),
                      ),
                      content: const Text(" "),
                      isActive: _currentStep >= 0,
                    ),
                    Step(
                      state: _currentStep > 3
                          ? StepState.complete
                          : StepState.indexed,
                      title: const Text(
                        'Approved by Directors',
                        style: TextStyle(color: Colors.black),
                      ),
                      content: const Text(" "),
                      isActive: _currentStep >= 0,
                    ),
                    Step(
                      state: _currentStep > 4
                          ? StepState.complete
                          : StepState.indexed,
                      title: const Text(
                        'Approved by CEO',
                        style: TextStyle(color: Colors.black),
                      ),
                      content: const Text(" "),
                      isActive: _currentStep >= 0,
                    ),
                    Step(
                      state: _currentStep > 5
                          ? StepState.complete
                          : StepState.indexed,
                      title: const Text(
                        'Process Completed',
                        style: TextStyle(color: Colors.black),
                      ),
                      content: const Text(" "),
                      isActive: _currentStep >= 0,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  /*continued() {
    _currentStep < 6 ? setState(() => _currentStep += 1) : null;
  }*/

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
