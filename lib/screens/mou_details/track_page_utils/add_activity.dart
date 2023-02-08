import 'package:MouTracker/common_utils/drop_down.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:flutter/material.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  // static io.File? file;
  // static UploadTask? task;

  final _formKey = GlobalKey<FormState>();
  late UserModel userData;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController dropDownController = TextEditingController();
    return Scaffold(
        appBar: appBar("Add Activity", context),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Column(
            children: [
              FormAndDropDown(
                dropDownController: dropDownController,
                dropDownItem: 'Initiator',
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
            ],
          ),
        ));
  }
}
