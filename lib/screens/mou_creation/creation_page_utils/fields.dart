import 'package:flutter/material.dart';

class CreateMouField extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;

  const CreateMouField({
    Key? key,
    required this.hintText,
    required this.textInputType,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 25, 40, 15),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0XFFEFF3F6),
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
          keyboardType: textInputType,
          controller: textEditingController,
          decoration: InputDecoration(
              labelText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              )),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Field is required.';
            } else {}
            return null;
          },
        ),
      ),
    );
  }
}