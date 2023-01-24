import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import '../../../../classes/notifications_data.dart';
import '../../../../services/Firebase/firestore/firestore.dart';
import 'notifications_page_utils/notifications_tab.dart';
import 'notifications_page_utils/notifications_tab_view.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController searchQueryController = TextEditingController();
  int index = 0;
  static List<NotificationsData> ontracklist = [];
  static List<NotificationsData> delayedlist = [];
  static late List<NotificationsData> allData;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    searchQueryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: appbar(_tabController, index, context),
        body: Padding(
          padding: EdgeInsets.all(screenWidth / 30),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth / 50),
                child: searchBox(screenHeight, screenWidth),
              ),
              FutureBuilder(
                  future: DataBaseService().getNotifications(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      ontracklist = snapshot.data as List<NotificationsData>;
                      delayedlist = snapshot.data as List<NotificationsData>;
                      ontracklist = _runFilter(
                          searchQueryController.text.toString().trim());
                      delayedlist = _runFilter2(
                          searchQueryController.text.toString().trim());
                      ontracklist.sort(((a, b) => b.on.compareTo(a.on)));
                      delayedlist.sort(((a, b) => b.on.compareTo(a.on)));
                      return Expanded(
                          child: tabview(_tabController, screenHeight,
                              screenWidth, context));
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBox(double height, double width) {
    return TextField(
      controller: searchQueryController,
      onChanged: (value) {
        setState(() {
          ontracklist = _runFilter(value);
          delayedlist = _runFilter2(value);
        });
      },
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(vertical: height / 70, horizontal: width / 20),
        hintText: "Search",
        suffixIcon: const Icon(Icons.search),
        // prefix: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(),
        ),
      ),
    );
  }

  List<NotificationsData> _runFilter(String value) {
    final search1 = ontracklist.where((element) {
      final name = element.title.toString().toLowerCase();
      final desc = element.body.toString().toLowerCase();
      final q = value.toLowerCase();
      if (name.contains(q)) {
        return name.contains(q);
      } else {
        return desc.contains(q);
      }
    }).toList();
    // print(search1);
    return ontracklist = search1;
  }

  List<NotificationsData> _runFilter2(String value) {
    final search1 = delayedlist.where((element) {
      final name = element.title.toString().toLowerCase();
      final desc = element.body.toString().toLowerCase();
      final q = value.toLowerCase();
      if (name.contains(q)) {
        return name.contains(q);
      } else {
        return desc.contains(q);
      }
    }).toList();
    // print(search1);
    return delayedlist = search1;
  }

  void sort(List<NotificationsData> data) async {
    for (NotificationsData data in data) {
      var query = await FirebaseFirestore.instance
          .collection('mou')
          .where('doc-name', isEqualTo: data.docName)
          .get();
      final dueDate = query.docs.map((doc) {
        return doc['due-date'].toDate();
      }).toList();
      print(dueDate[0]);
      if ((dueDate[0]).difference(DateTime.now()).isNegative) {
        print(" !due: $dueDate");
        delayedlist.add(data);
      } else {
        print(" on: $dueDate");
        ontracklist.add(data);
      }
    }
  }
}
