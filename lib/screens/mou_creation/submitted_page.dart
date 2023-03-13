import 'package:flutter/material.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_page/new_nav_bar.dart';
import 'creation_page_utils/created_logo.dart';

class SubmittedPage extends StatefulWidget {
  const SubmittedPage({Key? key}) : super(key: key);

  @override
  State<SubmittedPage> createState() => _SubmittedPageState();
}

class _SubmittedPageState extends State<SubmittedPage> {
  @override
  Widget build(BuildContext context) {
    const title = 'CREATE MOU';
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: false,
            pinned: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(bottom: h * 0.02),
                child: PText(
                  title,
                  style: GoogleFonts.figtree(
                    color: Colors.white,
                    fontSize: w * 0.04,
                  ), //GoogleFonts.figtree
                ),
              ), //PaTaTa
            ), //FlexibleSpaceBar
            expandedHeight: MediaQuery.of(context).size.height * 0.2 - 30,
            backgroundColor: const Color(0xff2D376E),
          ), //SliverAppBar
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.04),
                  const CreatedLogo(),
                  SizedBox(height: h * 0.03),
                  _text0(h, w),
                  _text1(h, w),
                  SizedBox(height: h * 0.03),
                  _text2(h, w),
                  SizedBox(height: h * 0.05),
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

Widget _text0(double h, double w) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: h * 0.045),
    alignment: Alignment.center,
    child: PText(
      'We have received your request!',
      style:
          GoogleFonts.figtree(fontWeight: FontWeight.bold, fontSize: w * 0.035),
    ),
  );
}

Widget _text1(double h, double w) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: h * 0.045),
    alignment: Alignment.center,
    child: PText(
      'Please wait till we verify your details.',
      style:
          GoogleFonts.figtree(fontWeight: FontWeight.bold, fontSize: w * 0.035),
    ),
  );
}

Widget _text2(double h, double w) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: h * 0.045),
    alignment: Alignment.center,
    child: PText(
      'In the meanwhile, you can track your request, by clicking on the button below!',
      style:
          GoogleFonts.figtree(fontWeight: FontWeight.w400, fontSize: w * 0.035),
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        // print('Inkwell Tap Registered');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NewHomePage()),
        );
      },
      splashColor: Colors.teal,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
// color: Color(0xff64C636),
        padding: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.08),
        decoration: BoxDecoration(
          color: const Color(0xff64C636),
          borderRadius: BorderRadius.circular(10),
        ),
        child: PText(
          'TRACK',
          style: GoogleFonts.figtree(fontSize: w * 0.05, color: Colors.white),
        ),
      ),
    );
  }
}
