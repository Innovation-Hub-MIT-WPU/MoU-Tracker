import 'package:flutter/material.dart';
import 'package:MouTracker/common_utils/drop_down.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/placement_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/engagement_form.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/engagemnt_forms_with_budget.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/enagagement_forms/engagement_forms_with_status.dart';

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
      //  Placement Desc is handled

      // desc for w/o file upload
      'advisory boards': 'Industry Advisory boards setted up for the company',
      'consultancy projects':
          'Industry Consultancy Projects conducted by the company',
      'guest sessions':
          'Record of Scheduled / conducted guest sessions & seminars',

      // desc for with file upload
      'lab equipment': '',
      'curriculum design': 'Curriculum design documents & status',

      // w/o budget
      'sponsorships': 'Information about sponsorship agreements',
      'center of execellence':
          'Details of agreements & transactions for Center of Excellence',
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

                      Widget? formPage;

                      // Engagement Forms regarding placements
                      if (newRoute == 'placement' ||
                          newRoute == 'internship' ||
                          newRoute == 'faculty internships') {
                        formPage = PlacementForm(mouId: mouId, title: newRoute);
                      }

                      // Engagement without file uplaods
                      else if (newRoute == 'guest sessions' ||
                          newRoute == 'consultancy projects' ||
                          newRoute == 'advisory boards') {
                        formPage = EngagementForm(
                          mouId: mouId,
                          title: newRoute,
                          desc: desc[newRoute]!,
                        );
                      }

                      // Engagement Forms with Status
                      else if (newRoute == 'curriculum design' ||
                          newRoute == 'sponsorships') {
                        formPage = EngagementFormWithStatus(
                            mouId: mouId,
                            title: newRoute,
                            desc: desc[newRoute]!);
                      }

                      // Engagement Forms with Budget
                      else if (newRoute == 'center of execellence' ||
                          newRoute == 'lab equipment') {
                        formPage = EngagementFormWithBudget(
                          mouId: mouId,
                          title: newRoute,
                          desc: desc[newRoute]!,
                        );
                      } else {
                        formPage = const Placeholder();
                      }

                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (_) => formPage!));
                    },
                    child: const Text("Select")),
                Expanded(
                  child: Center(
                      child: PText(
                    "Select an Activity",
                    style: TextStyle(fontSize: screenWidth * 0.06),
                  )),
                ),
              ],
            ),
          ),
        ));
  }
}
