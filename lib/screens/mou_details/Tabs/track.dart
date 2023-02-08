import 'package:MouTracker/models/mou.dart';
import 'package:MouTracker/screens/loading/loading_spinner.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/mou_details/mou_details_utils/completion.dart';
import 'package:MouTracker/screens/mou_details/mou_details_utils/mou_card.dart';
import 'package:MouTracker/services/Firebase/fcm/notification_service.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';

/// Issues
/*
    Approval Level takes time to update need to play an animation until the database is updated.
 */

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
  NotificationService ns = NotificationService();
  int _currentStep = 1;
  int _userPos = 1;
  bool isLoading = false;
  StepperType stepperType = StepperType.vertical;
  late UserModel userData;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          userData = snapshot.data as UserModel;
          _currentStep = (widget.mou.appLvl + 1);
          _userPos = userData.pos! + 1;

          print('before operation');
          print('approval lvl - ${widget.mou.appLvl}');
          print('User pos - $_userPos');
          print('currentStep : $_currentStep');
          // current Step -> next Step in approval

          return isLoading ? const Loading() : trackApproval();
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      }),
    );
  }

  Widget trackApproval() {
    return Scaffold(
      body: Column(
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
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    controlsBuilder: ((context, details) {
                      return Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      style: _buttonStyle(0, 0, 22, 0),
                                      onPressed: details.onStepContinue,
                                      child: details.currentStep == 1
                                          ? const PText("Initiate MOU")
                                          : const PText("Approve")),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      style: _buttonStyle(0, 0, 0, 22).copyWith(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red)),
                                      onPressed: details.onStepCancel,
                                      child: const PText("Deny")),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                    steps: getStepsList())),
          ),
        ],
      ),
    );
  }

  List<Step> getStepsList() {
    return <Step>[
      Step(
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const PText('Created the MoU'),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 0,
      ),
      Step(
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        title: const PText('Sent for Approval'),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 1,
      ),
      Step(
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        title: const PText('Approved by Head'),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 2,
      ),
      Step(
        state: _currentStep > 3 ? StepState.complete : StepState.indexed,
        title: const PText('Approved by Directors'),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 3,
      ),
      Step(
        state: _currentStep > 4 ? StepState.complete : StepState.indexed,
        title: const PText('Approved by CEO'),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 4,
      ),
      Step(
        state: _currentStep > 5 ? StepState.complete : StepState.indexed,
        title: const PText('Process Completed'),
        content: MouCard(widget: widget),
        isActive: _currentStep >= 5,
      ),
    ];
  }

  continued() async {
    if (_currentStep == 5) {
      DataBaseService().addNotification(
          mouId: widget.mou.mouId,
          body: "${widget.mou.docName} was approved by  ${userData.firstName}",
          title: "Final Approval",
          doc_name: widget.mou.docName,
          by: userData.firstName!,
          due: widget.mou.due!,
          on: DateTime.now());
      ns.sendPushMessage("${widget.mou.docName} was approved sucessfully",
          "Final Approval", widget.mou.mouId, 5);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MOUApproved()),
      );
    } else if (_currentStep <= _userPos) {
      setState(() => isLoading = true);
      await DataBaseService()
          .updateApprovalLvl(mouId: widget.mou.mouId, appLvl: _currentStep);
      setState(() => isLoading = false);
      DataBaseService().addNotification(
          mouId: widget.mou.mouId,
          body: "${widget.mou.docName} was approved by  ${userData.firstName}",
          title: "MoU Approved",
          doc_name: widget.mou.docName,
          by: userData.firstName!,
          due: widget.mou.due!,
          on: DateTime.now());
      ns.sendPushMessage(
          "${widget.mou.docName} was approved by ${userData.firstName}",
          "MoU Approved",
          widget.mou.mouId,
          _userPos);
      // setState(() => _currentStep += 1);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MOUApproved()),
      );
    } else {
      print("You can't approve this MOU");
    }
  }

  cancel() async {
    _currentStep > 0
        ? setState(() {
            _currentStep -= 2;
            print('currentStep : $_currentStep');
          })
        : null;
    setState(() => isLoading = true);

    await DataBaseService()
        .updateApprovalLvl(mouId: widget.mou.mouId, appLvl: (_currentStep));
    setState(() => isLoading = false);

    await DataBaseService().addNotification(
        mouId: widget.mou.mouId,
        body: "${widget.mou.docName} was denied by ${userData.firstName}",
        title: "Mou Rejected!!",
        doc_name: widget.mou.docName,
        by: userData.firstName!,
        due: widget.mou.due!,
        on: DateTime.now());
    ns.sendPushMessage(
        "${widget.mou.docName} was denied by ${userData.firstName}",
        "MoU Rejected!!",
        widget.mou.mouId,
        _userPos);
    Navigator.pop(context);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const NewHomePage()),
    // );
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
}
