import 'package:MouTracker/models/personalized_text.dart';
import 'package:flutter/material.dart';

class PlacementData extends StatefulWidget {
  const PlacementData({super.key});

  @override
  State<PlacementData> createState() => _PlacementDataState();
}

class _PlacementDataState extends State<PlacementData> {
  @override
  Widget build(BuildContext context) {
    return const PText("Placement data");
  }
}