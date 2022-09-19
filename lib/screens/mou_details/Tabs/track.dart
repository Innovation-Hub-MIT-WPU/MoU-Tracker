import 'package:MouTracker/classes/mou.dart';
import 'package:MouTracker/screens/mou_details/track_page_utils/completion.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';

class TrackTab extends StatefulWidget {
  final MOU mou;
  const TrackTab({required this.mou, Key? key}) : super(key: key);

  @override
  _TrackTabState createState() => _TrackTabState();
}

class _TrackTabState extends State<TrackTab> {
  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  Future<UserModel> getUserData = DataBaseService().getuserData();
  int _currentStep = 1;
  StepperType stepperType = StepperType.vertical;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          UserModel userData = snapshot.data as UserModel;
          _currentStep = (widget.mou.appLvl + 1);
          return trackApproval(userData.pos!);
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      }),
    );
  }

  Widget trackApproval(int userPos) {
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
                    print("user-pos: $userPos");
                    if (_currentStep ==
                        getStepsList().sublist(0, userPos + 3).length) {}
                    if (_currentStep == getStepsList().length) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MOUApproved()),
                      );
                    } else {
                      if (userPos + 1 >= _currentStep) {
                        DataBaseService().updateApprovalLvl(
                            mouId: widget.mou.mouId, appLvl: _currentStep);
                        setState(() => _currentStep += 1);
                      }
                    }
                  },
                  onStepCancel: cancel,
                  controlsBuilder: ((context, details) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: details.currentStep == 1
                                  ? const Text("Initiate MOU")
                                  : const Text("Approve")),
                          ElevatedButton(
                              onPressed: details.onStepCancel,
                              child: const Text("Deny"))
                        ],
                      ),
                    );
                  }),
                  steps: getStepsList().sublist(0, userPos + 3)),
            ),
          ),
        ],
      ),
    );
  }

  List<Step> getStepsList() {
    return <Step>[
      Step(
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const Text(
          'Completed the MoU',
          style: TextStyle(color: Colors.black),
        ),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 0,
      ),
      Step(
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        title: const Text(
          'Sent for Approval',
          style: TextStyle(color: Colors.black),
        ),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 1,
      ),
      Step(
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        title: const Text(
          'Approved by Head',
          style: TextStyle(color: Colors.black),
        ),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 2,
      ),
      Step(
        state: _currentStep > 3 ? StepState.complete : StepState.indexed,
        title: const Text(
          'Approved by Directors',
          style: TextStyle(color: Colors.black),
        ),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 3,
      ),
      Step(
        state: _currentStep > 4 ? StepState.complete : StepState.indexed,
        title: const Text(
          'Approved by CEO',
          style: TextStyle(color: Colors.black),
        ),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 4,
      ),
      Step(
        state: _currentStep > 5 ? StepState.complete : StepState.indexed,
        title: const Text(
          'Process Completed',
          style: TextStyle(color: Colors.black),
        ),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 5,
      ),
    ];
  }

  cancel() {
    _currentStep > 1 ? setState(() => _currentStep -= 1) : null;
  }
}

class MouCard extends StatelessWidget {
  const MouCard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final TrackTab widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(widget.mou.docName),
      ),
    );
  }
}
