import 'package:cloud_firestore/cloud_firestore.dart';

class CreationDetails {
  static Map<String, String> quantities = {};

  static void mapping(String text, String itemId) {
    quantities[itemId] = text;
    print("quantities:");
    print(quantities);
  }

  static Future addData() async {
    final mou = FirebaseFirestore.instance.collection('MOUs').doc();

    await mou.set(quantities);
  }
}
