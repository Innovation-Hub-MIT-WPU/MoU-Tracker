import 'package:flutter/material.dart';

class CreatedLogo extends StatelessWidget {
  const CreatedLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/Vectorlogo.png',
            height: 200,
          ),
        ),
        Positioned(
          right: 60,
          child: Image.asset(
            'assets/images/Vectorlogo-1.png',
            height: 200,
          ),
        ),
        Positioned(
          left: 70,
          top: 10,
          child: Image.asset(
            'assets/images/Vectorlogo-2.png',
            height: 200,
          ),
        ),
        Positioned(
          right: 100,
          bottom: 10,
          child: Image.asset(
            'assets/images/Vectorlog.png',
            height: 200,
          ),
        ),
      ],
    );
  }
}
