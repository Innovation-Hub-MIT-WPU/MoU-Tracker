import 'package:MouTracker/common_utils/drop_down.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/mou_details/enagagement_forms/advisory_boards_form.dart';
import 'package:MouTracker/screens/mou_details/enagagement_forms/faculty_intern_form.dart';
import 'package:MouTracker/screens/mou_details/enagagement_forms/internship_form.dart';
import 'package:MouTracker/screens/mou_details/enagagement_forms/placement_form.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:flutter/material.dart';

class AddActivity extends StatelessWidget {
  final String mouId;
  AddActivity({super.key, required this.mouId});

  // static io.File? file;
  final _formKey = GlobalKey<FormState>();

  late UserModel userData;

  TextEditingController dropDownController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'Placement',
      'Internship',
      'Faculty Internship',
      'Advisory boards',
      'Cirriculum Design',
      'Guest sessions / seminars',
      'Lab equipment',
      'Center of excellence',
      'Sponsorships',
      'Consultancy projects'
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

                      Widget? formPage;
                      if (newRoute == '/placement') {
                        formPage = PlacementForm();
                      } else if (newRoute == '/internship') {
                        formPage = InternshipForm();
                      } else if (newRoute == '/faculty internship') {
                        formPage = FacultyInternForm();
                      } else if (newRoute == '/advisory boards') {
                        formPage = AdvisoryBoardsForm(mouId: mouId);
                      } else {
                        formPage = const Placeholder();
                      }

                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (_) => formPage!));
                    },
                    child: const Text("Select")),
                const Expanded(
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
