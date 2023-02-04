import 'package:MouTracker/models/notifications_data.dart';
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
        description:
            "Legal and Binding Agreement. This Agreement is legal and binding between the Parties as stated above."),
    onTrack(
        title: "MOU-4",
        date: "1 Sept 2022",
        description: "We provide best services in the world..."),
    onTrack(
        title: "MOU-5",
        date: "1 Sept 2022",
        description:
            "The Parties each represent that they have the authority to enter into this Agreement....."),
    onTrack(
        title: "MOU-6",
        date: "1 Sept 2022",
        description: "We provide best services in the world..."),
    onTrack(
        title: "MOU-7",
        date: "31 Dec 2022",
        description:
            "This Agreement may be entered into and is legal and binding both in the United States and throughout Europe."),
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
        date: "1 july 2022",
        description:
            "The Parties each represent that they have the authority to enter into this Agreement....."),
    onTrack(
        title: "MOU-8",
        date: "1 july 2022",
        description:
            "This Agreement may be entered into and is legal and binding both in the United States and throughout Europe."),
    onTrack(
        title: "MOU-9",
        date: "15 july 2022",
        description:
            "Legal and Binding Agreement. This Agreement is legal and binding between the Parties as stated above."),
  ];
}

// class NotificationsData {
//   static List delayedMap = [];
//   static List onTrackMap = [];

//   static Stream<Iterable<Map<String, dynamic>>> getData() {
//     return FirebaseFirestore.instance
//         .collection('mou')
//         .snapshots()
//         .map((event) => event.docs.map((e) => e.data()));
//   }

//   static unloadData() {
//     delayedMap.clear();
//     onTrackMap.clear();
//     Stream<Iterable<Map<String, dynamic>>> stream;
//     stream = getData();
//     stream.listen((event) {
//       for (Map e in event) {
//         if ((e["due-date"] as Timestamp)
//             .toDate()
//             .difference(DateTime.now())
//             .isNegative) {
//           delayedMap.add(e);
//         } else {
//           onTrackMap.add(e);
//         }
//       }
//     });
//   }
// }

class NotificationsData1 {
  static List delayedMap = [];
  static List onTrackMap = [];
  static List userList = [];
  static List<NotificationsData> notiList = [];
  static List list = [];

  static Future newGet() async {
    delayedMap.clear();
    onTrackMap.clear();
    // print("i was cleared");
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('mou').get();

    userList = querySnapshot.docs.map((e) => (e.data())).toList();
    for (Map e in userList) {
      if ((e["due-date"]).toDate().difference(DateTime.now()).isNegative) {
        delayedMap.add(e);
        // print("iwasadded");
      } else {
        onTrackMap.add(e);
      }
    }
    // print("i was called");
  }

  static Future getNoti() async {
    notiList.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('notifications').get();

    list = querySnapshot.docs.map((e) => (e.data())).toList();
    for (Map e in list) {
      notiList.add(NotificationsData(
          due: e['due'],
          mouId: e['mou_id'],
          title: e['title'],
          body: e['body'],
          docName: e['doc_name'],
          on: e['on'].toDate(),
          by: e['by']));
    }
    // print(notiList);
  }
}
