import 'package:cloud_firestore/cloud_firestore.dart';

class onTrack {
  String title;
  String description;
  String date;

  onTrack({required this.title, required this.description, required this.date});
}

class delayed {
  String title;
  String description;
  String date;

  delayed({required this.title, required this.description, required this.date});
}

List getonTracksList() {
  return [
    onTrack(
        title: "MOU-3",
        date: "30 Aug 2022",
        description: "lore  You should see a circular....."),
    onTrack(
        title: "MOU-4",
        date: "1 Sept 2022",
        description: "We provide best services in the world...."),
    onTrack(
        title: "MOU-6",
        date: "31 Dec 2022",
        description: "We provide best services in the world...."),
  ];
}

List getdelayedList() {
  return [
    onTrack(
        title: "MOU-2",
        date: "1 july 2022",
        description:
            "We provide best services in the world.rave suffered alteration in some ..."),
    onTrack(
        title: "MOU-1",
        date: "15 july 2022",
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
