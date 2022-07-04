// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

import '../../common_utils/utils.dart';

class StatsTab extends StatefulWidget {
  const StatsTab({Key? key}) : super(key: key);

  @override
  State<StatsTab> createState() => StatsTabState();
}

class StatsTabState extends State<StatsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("2D376E"),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text(
                "Report",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: Theme.of(context).textTheme.headline2!.fontFamily,
                  fontSize: Theme.of(context).textTheme.headline3!.fontSize,
                ),
              ),
            ),
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1)),
        centerTitle: true,
      ),
    );
  }
}
