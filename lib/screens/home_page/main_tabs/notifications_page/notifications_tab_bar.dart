import 'package:flutter/material.dart';
import '../../../../classes/notifications_data.dart';
import '../../../../services/Firebase/firestore/firestore.dart';
import 'notifications_page_utils/notifications_list.dart';
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
  int index = 0;
  static late List<NotificationsData> ontracklist;
  static late List<NotificationsData> delayedlist;

  @override
  void initState() {
    // ontracklist = getonTracksList();
    // delayedlist = getdelayedList();

    // NotificationsData.unloadData();
    // delayedlist = NotificationsData.delayedMap;
    // ontracklist = NotificationsData.onTrackMap;

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
          child: FutureBuilder(
              future: DataBaseService().getNotifications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  ontracklist = snapshot.data as List<NotificationsData>;
                  delayedlist = snapshot.data as List<NotificationsData>;
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth / 50),
                        child: searchBox(screenHeight, screenWidth),
                      ),
                      Expanded(
                          child: tabview(
                              _tabController, screenHeight, screenWidth)),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget searchBox(double height, double width) {
    return TextField(
      onChanged: (value) => _runFilter(value),
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

  _runFilter(String value) {
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
    setState(() {
      ontracklist = search1;
    });
    final search2 = delayedlist.where((element) {
      final name = element.title.toString().toLowerCase();
      final desc = element.body.toString().toLowerCase();
      final q = value.toLowerCase();
      if (name.contains(q)) {
        return name.contains(q);
      } else {
        return desc.contains(q);
      }
    }).toList();
    setState(() {
      delayedlist = search2;
    });
  }
}




// Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(screenWidth / 50),
//                 child: searchBox(screenHeight, screenWidth),
//               ),
//               Expanded(
//                   child: tabview(_tabController, screenHeight, screenWidth)),
//             ],
//           ),