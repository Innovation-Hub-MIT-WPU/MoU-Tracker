import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateMouField extends StatelessWidget {
  final bool isEnabled;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;

  const CreateMouField({
    Key? key,
    required this.hintText,
    required this.textInputType,
    required this.textEditingController,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.035),
      child: Container(
        decoration: BoxDecoration(
            color: isEnabled
                ? const Color(0XFFEFF3F6)
                : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(6, 3),
                  blurRadius: 4.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Color.fromRGBO(255, 255, 255, 0.9),
                  offset: Offset(-6, -3),
                  blurRadius: 4.0,
                  spreadRadius: 1.0)
            ]),
        child: TextFormField(
          enabled: isEnabled,
          keyboardType: textInputType,
          controller: textEditingController,
          decoration: InputDecoration(
              labelText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              )),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Field is required*';
            } else {}
            return null;
          },
        ),
      ),
    );
  }
}

Padding selectDueDate(BuildContext context, DateTime selectedDate) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.12,
      // width: MediaQuery.of(context).size.width * 1.5,
      decoration: BoxDecoration(
          color: const Color(0XFFEFF3F6),
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 3),
                blurRadius: 4.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -3),
                blurRadius: 4.0,
                spreadRadius: 1.0)
          ]),
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newDateTime) {
          selectedDate = newDateTime;
        },
      ),
    ),
  );
}
