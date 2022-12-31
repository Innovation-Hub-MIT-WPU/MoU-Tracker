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
                  onStepCancel: () {
                    _currentStep > 1 ? setState(() => _currentStep -= 1) : null;
                  },
                  controlsBuilder: ((context, details) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          MouCard(widget: widget),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: _buttonStyle(0, 0, 22, 0),
                                    onPressed: details.onStepContinue,
                                    child: details.currentStep == 1
                                        ? const Text("Initiate MOU")
                                        : const Text("Approve")),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    style: _buttonStyle(0, 0, 0, 22).copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: details.onStepCancel,
                                    child: const Text("Deny")),
                              )
                            ],
                          ),
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

  ButtonStyle _buttonStyle(
      double topLeft, double topRight, double bottomLeft, double bottomRight) {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        ),
      )),
    );
  }

  List<Step> getStepsList() {
    return <Step>[
      Step(
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const Text('Created the MoU'),
        content: const Text(""),
        isActive: _currentStep >= 0,
      ),
      Step(
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        title: const Text('Sent for Approval'),
        content: const Text(""),
        isActive: _currentStep >= 1,
      ),
      Step(
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        title: const Text('Approved by Head'),
        content: const Text(""),
        isActive: _currentStep >= 2,
      ),
      Step(
        state: _currentStep > 3 ? StepState.complete : StepState.indexed,
        title: const Text('Approved by Directors'),
        content: const Text(""),
        isActive: _currentStep >= 3,
      ),
      Step(
        state: _currentStep > 4 ? StepState.complete : StepState.indexed,
        title: const Text('Approved by CEO'),
        content: const Text(""),
        isActive: _currentStep >= 4,
      ),
      Step(
        state: _currentStep > 5 ? StepState.complete : StepState.indexed,
        title: const Text('Process Completed'),
        content: const Text(""),
        isActive: _currentStep >= 5,
      ),
    ];
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
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Text(
              widget.mou.docName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.mou.description, maxLines: 4),
            ),
          ],
        ));
  }
}
