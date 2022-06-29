// ignore_for_file: prefer_const_constructors

/*
* form element - function from util.dart params - (Main text, hint text)
* button - params- (main text) TODO: pass navigation data as a param
* */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common_utils/utils.dart';
import '../../common_widgets/login_signup_widgets.dart';

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

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    Widget loginButton({Color textColor = Colors.white, double buttonWidth = 125, double buttonHeight = 35, double fontSize = 16} ){
      return SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: ElevatedButton(
          onPressed: (){
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => newRoute));
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
            fontSize: fontSize,
            color: textColor,
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

              emailFormElement("EMAIL", "abc@gmail.com", emailController),
              SizedBox(height: kFormSpacing),

              //formElement("DESIGNATION", ""),
              formAndDropDown(text: "DESIGNATION", hintText: "Choose designation"),
              SizedBox(height: kFormSpacing),

              passwordFormElement("PASSWORD", "password", passwordController),
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

  void logInFunction(String email, String password) async {
    if(_formKey.currentState!.validate()){
      //if login is successful then display toast else display error toast
      await _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((userid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => EmptyPage(previousPageName: "Log in tab"),))
        }).catchError( (e) {
          Fluttertoast.showToast(msg: e!.message);
        });
    } 

  }

}

