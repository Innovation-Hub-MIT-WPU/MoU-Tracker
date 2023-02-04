import 'package:MouTracker/screens/mou_details/Tabs/track.dart';
import 'package:MouTracker/classes/personalized_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MouCard extends StatelessWidget {
  const MouCard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final TrackTab widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0x00f8f8f8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Column(
        children: [
          PText(
            widget.mou.docName,
            style:
                GoogleFonts.figtree(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PText(widget.mou.description, maxLines: 4),
          ),
        ],
      ),
    );
  }
}
