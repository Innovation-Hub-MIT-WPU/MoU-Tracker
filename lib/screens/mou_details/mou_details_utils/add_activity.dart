import 'package:MouTracker/common_utils/utils.dart';
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
    String dropdownValue = 'One';
    return Scaffold(
        appBar: appBar("Add Activity", context),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: DropdownButtonFormField<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.darkBlue, width: 2)),
              ),
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ));
  }
}

OutlineInputBorder dropDownBorder() {
  return const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.darkBlue, width: 2));
}
