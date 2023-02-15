import 'package:MouTracker/common_utils/drop_down.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/advisory_boards_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/center_of_execellence.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/curriculum_design.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/faculty_intern_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/guest_session_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/internship_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/lab_equipment_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/placement_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/projects_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/sponsorship_form.dart';
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
      'Curriculum Design',
      'Guest sessions',
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
                        formPage =  PlacementForm(mouId: mouId);
                      } else if (newRoute == '/internship') {
                        formPage = InternshipForm(mouId: mouId);
                      } else if (newRoute == '/faculty internship') {
                        formPage = FacultyInternForm();
                      } else if (newRoute == '/advisory boards') {
                        formPage = AdvisoryBoardsForm(mouId: mouId);
                      } else if (newRoute == '/curriculum design') {
                        formPage = CirriculumDesignForm(mouId: mouId);
                      } else if (newRoute == '/lab equipment') {
                        formPage = LabEquipForm(mouId: mouId);
                      } else if (newRoute == '/center of excellence') {
                        formPage = CenterForm(mouId: mouId);
                      } else if (newRoute == '/sponsorships') {
                        formPage = SponsorshipForm(mouId: mouId);
                      } else if (newRoute == '/consultancy projects') {
                        formPage = ProjectsForm(mouId: mouId);
                      } else if (newRoute == '/guest sessions') {
                        formPage = GuestSessionForm(mouId: mouId);
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
