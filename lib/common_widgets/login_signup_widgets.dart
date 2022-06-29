// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:MouTracker/screens/login_signup/login_signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../common_utils/utils.dart';
import '../services/Firebase/fireauth/model.dart';

var _designations = [
  'Initiator',
  'SPOC',
  'Head',
  'Directors',
  'CEO',
  'Dean',
  'Vice Chancellor'
];
String? designation = 'Dean';

class formAndDropDown extends StatefulWidget {

  String text, hintText;
  formAndDropDown({Key? key, required this.text, required this.hintText}) : super(key: key);

  @override
  State<formAndDropDown> createState() => _formAndDropDownState();
}
class _formAndDropDownState extends State<formAndDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16), ),
        SizedBox(height: kFormSpacing / 2),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4.0))
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(  
              value: designation,
              selectedItemBuilder: (_){
                return _designations.map( (e) => Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child:  Text(e, textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.white))
                )).toList();
              },
              isExpanded: true,
              items: _designations.map(buildMenuItem).toList(), 
              onChanged: (value) { 
                setState(() {
                  designation = value.toString();
                });
              }
            ),
          ),
        ),
      ],
    );
  }
}
DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
  value: item,
  child: Padding(
    padding: const EdgeInsets.all(10),
    child: Text(item, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black)),
  ),
);


///---------------------------- Temporary page to navigate to, from any button

class EmptyPage extends StatefulWidget {

  String previousPageName;
  EmptyPage({
    Key? key,
    required this.previousPageName,
  }) : super(key: key);

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .get()
      .then( (value){
        loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Navigated from '${widget.previousPageName}' to here :))\nName: ${loggedInUser.firstName} ${loggedInUser.lastName}\nEmail: ${loggedInUser.email}"),
            ActionChip(label: Text("LOG OUT"), onPressed: (){
              logout(context);
            })
          ],
        ),
      ),
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LogInSignUpPage()));
  }
}

//----------------------------------------

//Button widget: used in 'Get Started' + 'Sign in/Sign up' screens
Widget AppButton(String text, Widget newRoute, BuildContext context, {Color textColor = Colors.white, double buttonWidth = 125, double buttonHeight = 35, double fontSize = 16} ){
  return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => newRoute));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.buttonYellow),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            )
          )
        ),
        child: Text(text, textAlign: TextAlign.center, style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        )), 
      ),
    );
}

//----------------------------------------

//A text footer -> 'Privacy policy . TOC . Content Policy' : used in 'Get Started' + 'Sign in/Sign up' screens
Widget footer(BuildContext context){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      footerText("Privacy Policy", context),
      SizedBox(width: 20,),
      Icon(Icons.circle, size: 6, color: Colors.white,),
      SizedBox(width: 20,),
      footerText("TOS", context),
      SizedBox(width: 20,),
      Icon(Icons.circle, size: 6, color: Colors.white),
      SizedBox(width: 20,),
      footerText("Content Policy", context),
    ],
  );
}
//Clickable text used in above footer widget
Widget footerText(String text, BuildContext context) {
  return InkWell(
    onTap: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(text, textAlign: TextAlign.center,), behavior: SnackBarBehavior.floating, width: 200, duration: Duration(milliseconds: 1000) , shape: StadiumBorder(),
        ));
    },
    child: Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white,))
  );
}


Widget emailFormElement(String text, String hintText, TextEditingController emailController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
      ),
      SizedBox(height: kFormSpacing / 2),
      TextFormField(
        autofocus: false,
        onSaved: (value) {
          emailController.text = value!;
        },
        validator: (value){
          if(value!.isEmpty){
            return "Please enter your email";
          }
          //reg ex for email validation
          if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
            return "Please enter a valid email";
          }
          return null;
        },
        cursorColor: AppColors.buttonYellow,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: kBorderWidth)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: kBorderWidth)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.buttonYellow, width: kBorderWidth),
          ),
        ),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
    ],
  );
}

Widget passwordFormElement(String text, String hintText, TextEditingController passwordController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
      ),
      SizedBox(height: kFormSpacing / 2),
      TextFormField(
        controller: passwordController,
        obscureText: true,
        validator: (value){
          RegExp regex = RegExp(r'^.{6,}$');
          if(value!.isEmpty){
            return("Please enter a password");
          }
          if(!regex.hasMatch(value)){
            return("Please enter a valid passowrd (min. 6 characters)");
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        cursorColor: AppColors.buttonYellow,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: kBorderWidth)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.buttonYellow, width: kBorderWidth),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: kBorderWidth))
        ),
      ),
    ],
  );
}

Widget nameFormElement(String text, String hintText, TextEditingController nameController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
      ),
      SizedBox(height: kFormSpacing / 2),
      TextFormField(
        controller: nameController,
        validator: (value){
          //RegExp regex = RegExp("/(^[a-zA-Z][a-zA-Zs]{0,20}[a-zA-Z])/");
          if(value!.isEmpty){
            return "Please enter name";
          }
          /*if(!regex.hasMatch(value)){
            return "Enter a valid name (no numericals and special characters)";
          }*/
          return null;
        },
        onSaved: (value) {
          nameController.text = value!;
        },
        cursorColor: AppColors.buttonYellow,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: kBorderWidth)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.buttonYellow, width: kBorderWidth),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: kBorderWidth))
        ),
      ),
    ],
  );
}
