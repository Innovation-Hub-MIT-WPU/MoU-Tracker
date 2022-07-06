import 'package:flutter/material.dart';
import '../../common_widgets/CreatedLogo.dart';

class SubmittedPage extends StatefulWidget {
  const SubmittedPage({Key? key}) : super(key: key);

  @override
  State<SubmittedPage> createState() => _SubmittedPageState();
}

class _SubmittedPageState extends State<SubmittedPage> {
  @override
  Widget build(BuildContext context) {
    const title = 'CREATE MOU';

    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: false,
                pinned: false,
                floating: false,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ), //TextStyle
                    ),
                  ), //Text
                ), //FlexibleSpaceBar
                expandedHeight: MediaQuery.of(context).size.height * 0.2 - 30,
                backgroundColor: const Color(0xff2D376E),
              ), //SliverAppBar
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const CreatedLogo(),
                      const SizedBox(height: 10),
                      _text0(),
                      _text1(),
                      const SizedBox(height: 30),
                      _text2(),
                      const SizedBox(height: 50),
                      const TrackButton(),
                    ],
                  ),
                ),
              )
            ], //<Widget>[]
          ) //CustonScrollView
          ),
    );
  }
}

Widget _text0() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 45),
    alignment: Alignment.center,
    child: const Text(
      'We have received your request!',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}

Widget _text1() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 45),
    alignment: Alignment.center,
    child: const Text(
      'Please wait till we verify your details.',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}

Widget _text2() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 45),
    alignment: Alignment.center,
    child: const Text(
      'In the meanwhile, you can track your request, by clicking on the button below!',
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      textAlign: TextAlign.center,
    ),
  );
}

class TrackButton extends StatefulWidget {
  const TrackButton({Key? key}) : super(key: key);

  @override
  State<TrackButton> createState() => _TrackButtonState();
}

class _TrackButtonState extends State<TrackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Inkwell Tap Registered');
        Navigator.pushNamed(context, '/home');
      },
      splashColor: Colors.teal,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
// color: Color(0xff64C636),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        decoration: BoxDecoration(
          color: const Color(0xff64C636),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'TRACK',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
