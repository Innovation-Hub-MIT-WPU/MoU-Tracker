import 'package:flutter/material.dart';
import 'package:MouTracker/screens/mou_details/mou_details_page.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';

class FetchMouDetails extends StatelessWidget {
  const FetchMouDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DataBaseService().mouData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Details();
        } else {
          return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}
