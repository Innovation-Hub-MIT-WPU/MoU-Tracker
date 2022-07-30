import 'package:MouTracker/screens/mou_creation/mou_creation_page.dart';

import 'package:flutter/material.dart';
import '/classes/create_mou_backend.dart';

Widget buildField1() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 25, 40, 15),
    child: TextFormField(
      decoration: const InputDecoration(
          labelText: 'Field 1',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required.';
        }
      },
      onSaved: (value) {
        CreateFormState.field1 = value!;
      },
    ),
  );
}

Widget buildField2() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
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
  );
}

Widget buildField3() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
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
  );
}

Widget buildField4() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
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
  );
}

Widget buildField5() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
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
  );
}

Widget buildField6() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
    child: TextFormField(
      decoration: const InputDecoration(
          labelText: 'Field 6',
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
  );
}
