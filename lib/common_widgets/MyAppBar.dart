import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      height: 135,
      child: CustomScrollView(slivers: [
        SliverAppBar(
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'CREATE MOU',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          expandedHeight: 135,
        ),
      ]),
    );
  }
}
