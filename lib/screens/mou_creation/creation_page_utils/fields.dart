import 'package:MouTracker/screens/mou_creation/mou_creation_page.dart';
import 'package:flutter/material.dart';

late String name;
late String description;
late int amount;
late int id;
Widget buildField1() {
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
        decoration: const InputDecoration(
            labelText: 'Field 1',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            )),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          CreateFormState.field1 = value!;
        },
      ),
    ),
  );
}

Widget buildField2() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0XFFEFF3F6),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 4.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 4.0,
                spreadRadius: 1.0)
          ]),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 2',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          CreateFormState.field2 = value!;
        },
      ),
    ),
  );
}

Widget buildField3() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0XFFEFF3F6),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 4.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 4.0,
                spreadRadius: 1.0)
          ]),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 3',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          CreateFormState.field3 = value!;
        },
      ),
    ),
  );
}

Widget buildField4() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0XFFEFF3F6),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 4.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 4.0,
                spreadRadius: 1.0)
          ]),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 4',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          CreateFormState.field4 = value!;
        },
      ),
    ),
  );
}

Widget buildField5() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0XFFEFF3F6),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 4.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 4.0,
                spreadRadius: 1.0)
          ]),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 5',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          CreateFormState.field5 = value!;
        },
      ),
    ),
  );
}

Widget buildField6() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0XFFEFF3F6),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 4.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 4.0,
                spreadRadius: 1.0)
          ]),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 6',
            // enabledBorder: InputBorder.none,
            // disabledBorder: InputBorder.none,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          CreateFormState.field6 = value!;
        },
      ),
    ),
  );
}
