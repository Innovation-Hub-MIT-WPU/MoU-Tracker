import 'package:MouTracker/common_utils/drop_down.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/center_of_execellence.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/curriculum_design.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/engagement_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/lab_equipment_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/placement_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/sponsorship_form.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddActivity extends StatelessWidget {
  final String mouId;
  AddActivity({super.key, required this.mouId});

  // static io.File? file;
  // ignore: unused_field
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
      'Center of execellence',
      'Sponsorships',
      'Consultancy projects'
    ];

    Map<String, String> desc = {
      'placements': 'Details of yearwise placement',
      'advisory boards': 'Industry Advisory boards setted up for the company',
      'consultancy projects':
          'Industry Consultancy Projects conducted by the company',
      'guest sessions':
          'Record of Scheduled / conducted guest sessions & seminars',
    };
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
                      String newRoute = dropDownController.text.toLowerCase();
                      // print('drop down value - $newRoute');

                      Widget? formPage;
                      if (newRoute == 'placement' ||
                          newRoute == 'internship' ||
                          newRoute == 'faculty internships') {
                        formPage = PlacementForm(mouId: mouId, title: newRoute);
                      } else if (newRoute == 'guest sessions' ||
                          newRoute == 'consultancy projects' ||
                          newRoute == 'advisory boards') {
                        formPage = EngagementForm(
                          mouId: mouId,
                          title: newRoute,
                          desc: desc[newRoute]!,
                        );
                      } else if (newRoute == 'curriculum design') {
                        formPage = CurriculumDesignForm(
                            mouId: mouId, title: 'curriculum design');
                      } else if (newRoute == 'lab equipment') {
                        formPage =
                            LabEquipForm(mouId: mouId, title: 'lab equipment');
                      } else if (newRoute == 'center of excellence') {
                        formPage = CenterForm(
                            mouId: mouId, title: 'center of execellence');
                      } else if (newRoute == 'sponsorships') {
                        formPage = SponsorshipForm(
                            mouId: mouId, title: 'sponsorships');
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
