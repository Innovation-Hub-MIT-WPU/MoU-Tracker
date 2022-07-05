import 'package:cloud_firestore/cloud_firestore.dart';

class onTrack {
  String title;
  String description;
  DateTime date;

  onTrack({required this.title, required this.description, required this.date});
}

class delayed {
  String title;
  String description;
  DateTime date;

  delayed({required this.title, required this.description, required this.date});
}

List getonTracksList() {
  return [
    onTrack(
        title: "MOU-1",
        date: DateTime.now(),
        description: "lore  You should see a circular....."),
    onTrack(
        title: "MOU-2",
        date: DateTime.now(),
        description: "We provide best services in the world...."),
  ];
}

List getdelayedList() {
  return [
    onTrack(
        title: "MOU-3",
        date: DateTime.now(),
        description:
            "We provide best services in the world.rave suffered alteration in some ..."),
    onTrack(
        title: "MOU-4",
        date: DateTime.now(),
        description:
            "We provide best services in  of Lorem Ipsum avhave suffered alteration in some ..."),
  ];
}

class NotificationsData {
  static List delayedMap = [];
  static List onTrackMap = [];

  static Stream<Iterable<Map<String, dynamic>>> getData() {
    return FirebaseFirestore.instance
        .collection('MOUs')
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()));
  }

  static unloadData() {
    delayedMap.clear();
    onTrackMap.clear();
    Stream<Iterable<Map<String, dynamic>>> stream;
    stream = getData();
    stream.listen((event) {
      for (Map e in event) {
        if ((e["Due Date"] as Timestamp)
            .toDate()
            .difference(DateTime.now())
            .isNegative) {
          delayedMap.add(e);
        } else {
          onTrackMap.add(e);
        }
      }
    });
  }
}
