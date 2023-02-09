import 'package:MouTracker/common_utils/drop_down.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
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
  TextEditingController dropDownController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'Placement',
      'Internship',
      'Faculty Internship',
      'Advisory boards'
    ];
    double screenWidth = MediaQuery.of(context).size.width;

    dropDownController.text = "";
    return Scaffold(
        appBar: appBar("Add Activity", context),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              children: [
                CreateDropDown(
                  dropDownItems: items,
                  dropDownController: dropDownController,
                  hintText: "Select an activity",
                  dropDownStyle: dropDownDecoration(),
                ),
                ElevatedButton(
                    onPressed: () {
                      String newRoute =
                          '/${dropDownController.text.toLowerCase()}';
                      print('drop down value - $newRoute');
                      Navigator.pushNamed(context, newRoute);
                    },
                    child: const Text("Submit")),
                dropDownController.text != ""
                    ? const Expanded(
                        child: Center(child: PText("Display Form")),
                      )
                    : const Expanded(
                        child: Center(child: PText("Select an Activity")),
                      ),
              ],
            ),
          ),
        ));
  }
}

InputDecoration dropDownDecoration() {
  return InputDecoration(
    border: dropDownBorder(),
    enabledBorder: dropDownBorder(),
    focusedBorder: dropDownBorder(),
  );
}

OutlineInputBorder dropDownBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.darkBlue, width: 2),
    borderRadius: BorderRadius.circular(12.0),
  );
}
