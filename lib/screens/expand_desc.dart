import 'package:flutter/material.dart';
import 'package:MouTracker/models/personalized_text.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text, {super.key});

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        AnimatedSize(
            duration: const Duration(milliseconds: 500),
            child: ConstrainedBox(
                constraints: widget.isExpanded
                    ? const BoxConstraints()
                    : const BoxConstraints(maxHeight: 50.0),
                child: PText(
                  widget.text,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ))),
        widget.isExpanded
            ? ConstrainedBox(constraints: const BoxConstraints())
            : TextButton(
                child: const PText('...'),
                onPressed: () => setState(() => widget.isExpanded = true))
      ]),
    );
  }
}
