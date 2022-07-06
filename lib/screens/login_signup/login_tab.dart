// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../home/home_screen.dart';
import '/common_utils/utils.dart';
import '/common_widgets/login_signup_widgets.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController designationController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  String? designation;

  @override
  Widget build(BuildContext context) {

    Widget loginButton(){
      return SizedBox(
        width: 125,
        height: 35,
        child: ElevatedButton(
          onPressed: (){
            logInFunction(emailController.text, passwordController.text);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.buttonYellow),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            )
          ),
          child: Text("LOG IN", textAlign: TextAlign.center, style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          )), 
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kFormHorizontal),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kFormSpacing),

              emailFormElement(emailController),
              SizedBox(height: kFormSpacing),

              //formElement("DESIGNATION", ""),
              FormAndDropDown(designationController: designationController, designation: designation,),
              SizedBox(height: kFormSpacing),

              passwordFormElement(passwordController),
              TextButton(
                  onPressed: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Forgot password", textAlign: TextAlign.center,), behavior: SnackBarBehavior.floating, width: 200, duration: Duration(milliseconds: 1000) , shape: StadiumBorder(),));},
                  child: const Text("Forgot Password?",
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: kFormSpacing),

              Center(
                child: loginButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Checks if form key is validated
  ///Logs the user in using firebase authentication
  void logInFunction(String email, String password) async {
    if(_formKey.currentState!.validate()){
      //if login is successful then display toast else display error toast
      await _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((userid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => HomePage()))
        }).catchError( (e) {
          Fluttertoast.showToast(msg: e!.message);
        });
    } 

  }

}

