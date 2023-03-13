import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CreateDropDown extends StatefulWidget {
  final String hintText;
  TextEditingController dropDownController;
  final List<String> dropDownItems;
  final InputDecoration dropDownStyle;
  CreateDropDown({
    super.key,
    required this.dropDownItems,
    required this.hintText,
    required this.dropDownStyle,
    required this.dropDownController,
  });

  @override
  State<CreateDropDown> createState() => _CreateDropDownState();
}

class _CreateDropDownState extends State<CreateDropDown> {
  String? dropDownValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.035),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            hint: PText(
              widget.hintText,
              style: GoogleFonts.figtree(color: Colors.black.withOpacity(0.5)),
            ),
            value: dropDownValue,
            isExpanded: true,
            items: widget.dropDownItems
                .map((String item) => DropdownMenuItem(
                      value: item,
                      child: PText(item),
                    ))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                dropDownValue = value.toString();
                widget.dropDownController.text = value.toString();
              });
            },
            selectedItemBuilder: (_) {
              return widget.dropDownItems
                  .map((e) => PText(e,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.figtree(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.black)))
                  .toList();
            },
            decoration: widget.dropDownStyle,
          ),
        ],
      ),
    );
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

class FormAndDropDown extends StatefulWidget {
  String? dropDownItem;
  TextEditingController dropDownController;
  double screenHeight, screenWidth;
  List<String> positionsList;
  FormAndDropDown(
      {Key? key,
      required this.dropDownController,
      required this.positionsList,
      required this.dropDownItem,
      required this.screenHeight,
      required this.screenWidth})
      : super(key: key);

  @override
  State<FormAndDropDown> createState() => _FormAndDropDownState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'dropDownController', dropDownController));
  }
}

class _FormAndDropDownState extends State<FormAndDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              //border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: DropdownButtonFormField(
              dropdownColor: Colors.white,
              hint: PText(
                "Select a designation",
                style: GoogleFonts.figtree(color: Colors.white),
              ),
              value: widget.dropDownItem,
              selectedItemBuilder: (_) {
                return widget.positionsList
                    .map((e) => PText(e,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.figtree(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.black)))
                    .toList();
              },
              isExpanded: true,
              items: widget.positionsList.map(buildMenuItem).toList(),
              // items: designations.map(buildMenuItem).toList(),
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
                        BorderSide(color: Colors.black, width: kBorderWidth)),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black, width: kBorderWidth)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.black, width: kBorderWidth),
                ),
              )),
        )
      ],
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: PText(
        item,
        style: GoogleFonts.figtree(
            fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
      ),
    );
