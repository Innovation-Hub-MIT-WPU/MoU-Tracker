import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/login_signup/auth_page_utlis/login_signup_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormAndDropDown extends StatefulWidget {
  String? dropDownItem;
  TextEditingController dropDownController;
  double screenHeight, screenWidth;
  FormAndDropDown(
      {Key? key,
      required this.dropDownController,
      required this.dropDownItem,
      required this.screenHeight,
      required this.screenWidth})
      : super(key: key);

  @override
  State<FormAndDropDown> createState() => _FormAndDropDownState();
}

class _FormAndDropDownState extends State<FormAndDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PText(
          "DESIGNATION",
          style: GoogleFonts.figtree(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
        const SizedBox(height: kFormSpacing / 2),
        Container(
          decoration: const BoxDecoration(
              //border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: DropdownButtonFormField(
              hint: PText(
                "Select a designation",
                style:
                    GoogleFonts.figtree(color: Colors.white.withOpacity(0.5)),
              ),
              value: widget.dropDownItem,
              selectedItemBuilder: (_) {
                return designations
                    .map((e) => Container(
                        child: PText(e,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.figtree(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.white))))
                    .toList();
              },
              isExpanded: true,
              items: designations.map(buildMenuItem).toList(),
              onChanged: (value) {
                setState(() {
                  widget.dropDownController.text = value.toString();
                  widget.dropDownItem = value.toString();
                });
              },
              validator: (value) {
                if (value == null || value == "") {
                  return "Select a designation";
                }
                return null;
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white, width: kBorderWidth)),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white, width: kBorderWidth)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.buttonYellow, width: kBorderWidth),
                ),
              )),
        )
      ],
    );
  }
}
