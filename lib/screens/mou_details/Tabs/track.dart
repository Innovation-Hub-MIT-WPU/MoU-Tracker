import 'package:MouTracker/screens/mou_details/completion.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';

class TrackTab extends StatefulWidget {
  const TrackTab({Key? key}) : super(key: key);

  @override
  _TrackTabState createState() => _TrackTabState();
}

class _TrackTabState extends State<TrackTab> {
  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  int _currentStep = 1;
  StepperType stepperType = StepperType.vertical;
  DataBaseService db = DataBaseService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.userData,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          UserModel userData = snapshot.data as UserModel;
          return trackApproval(userData.pos!);
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      }),
    );
  }

  Widget trackApproval(int pos) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: Colors.green)),
              child: Stepper(
                type: stepperType,
                physics: const ScrollPhysics(),
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep == 5) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MOUApproved()),
                    );
                  } else {
                    setState(() {
                      if (pos + 1 == _currentStep) {
                        _currentStep += 1;
                      }
                    });
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
                    isActive: _currentStep >= 1,
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
                    isActive: _currentStep >= 2,
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
                    isActive: _currentStep >= 3,
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
                    isActive: _currentStep >= 4,
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
                    isActive: _currentStep >= 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
