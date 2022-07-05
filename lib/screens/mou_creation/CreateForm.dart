import 'package:flutter/material.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({Key? key}) : super(key: key);

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  // for identification and validation of the form
  final _formKey = GlobalKey<FormState>();

  String _field1 = '';
  String _field2 = '';
  String _field3 = '';
  String _field4 = '';
  String _field5 = '';
  String _field6 = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              // CustomPaint(
              //   size: const Size(400, 400),
              //   painter: CurvePainter(),
              // ),
              Container(
                color: Color(0xff2D376E),
                height: MediaQuery.of(context).size.height * 0.2 - 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      'CREATE MOU',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    _buildField1(),
                    _buildField2(),
                    _buildField3(),
                    _buildField4(),
                    _buildField5(),
                    _buildField6(),
                    Center(
                        child: Text(
                      'Submit MoU 3 Pager',
                      style: TextStyle(fontSize: 22),
                    )),
                    Container(
                      height: 60,
                      width: 300,
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Choose File',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff64C636)),
                          elevation: MaterialStateProperty.all(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // if (!_formKey.currentState!.validate()) {
                          //   return;
                          // }
                          _formKey.currentState!.save();
                          Navigator.pushNamed(context, '/submitted');
                        },
                        child: Text(
                          'DONE',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(0),
                            side: MaterialStateProperty.all(
                                BorderSide(color: Colors.black, width: 2))),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    ));
  }

  Widget _buildField1() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 1',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          _field1 = value!;
        },
      ),
    );
  }

  Widget _buildField2() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 2',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          _field2 = value!;
        },
      ),
    );
  }

  Widget _buildField3() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 3',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          _field3 = value!;
        },
      ),
    );
  }

  Widget _buildField4() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 4',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          _field4 = value!;
        },
      ),
    );
  }

  Widget _buildField5() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 5',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          _field5 = value!;
        },
      ),
    );
  }

  Widget _buildField6() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 15, 40, 15),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Field 6',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required.';
          }
        },
        onSaved: (value) {
          _field6 = value!;
        },
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //layer 3
    var paint3 = Paint();
    paint3.color = Colors.pink;
    paint3.style = PaintingStyle.fill; // Change this to fill

    var path3 = Path();

    path3.moveTo(0, size.height * 0.25 - 40);
    path3.quadraticBezierTo(size.width / 2 + 100, size.height / 2 - 30,
        size.width, size.height * 0.25 + 30);
    path3.lineTo(size.width, 0);
    path3.lineTo(0, 0);

    canvas.drawPath(path3, paint3);

    var paint = Paint();
    // Color myBlue = Color(0xff2D376E);
    Color myBlue = Color(0xff023E8A);
    paint.color = myBlue;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25 - 10);
    path.quadraticBezierTo(size.width / 2 - 90, size.height / 2 + 20,
        size.width, size.height * 0.25 - 30);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);

    // layer 2
    var paint2 = Paint();
    paint2.color = Color(0xff03045E);
    paint2.style = PaintingStyle.fill; // Change this to fill

    var path2 = Path();

    path2.moveTo(0, size.height * 0.25 - 40);
    path2.quadraticBezierTo(size.width / 2 - 70, size.height / 2 - 30,
        size.width, size.height * 0.25 - 10);
    path2.lineTo(size.width, 0);
    path2.lineTo(0, 0);

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
