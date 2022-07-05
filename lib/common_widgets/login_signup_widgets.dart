// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:MouTracker/screens/login_signup/login_signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../common_utils/utils.dart';
import '../services/Firebase/fireauth/model.dart';

//designations array used in DropDownButtonFormField items
var _designations = [
  'Initiator',
  'SPOC',
  'Head',
  'Directors',
  'CEO',
  'Dean',
  'Vice Chancellor'
];
//A widget using DropDropDownButtonFormField to give dropdown for var _designations
///A widget to create DropDownButtonFormField
class FormAndDropDown extends StatefulWidget {

  String? designation;
  TextEditingController designationController;
  FormAndDropDown({Key? key, required this.designationController, required this.designation}) : super(key: key);

  @override
  State<FormAndDropDown> createState() => _FormAndDropDownState();
}
class _FormAndDropDownState extends State<FormAndDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("DESIGNATION", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16), ),
        SizedBox(height: kFormSpacing / 2),
        Container(
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4.0))
          ),
          child: DropdownButtonFormField(
            hint: Text("Select a designation", style: TextStyle(color: Colors.white.withOpacity(0.5)),),
            value: widget.designation,
            selectedItemBuilder: (_){
              return _designations.map( (e) => Container(
                child:  Text(e, textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.white))
              )).toList();
            },
            isExpanded: true,
            items: _designations.map(buildMenuItem).toList(), 
            onChanged: (value) { 
              setState(() {
                widget.designationController.text = value.toString();
                widget.designation = value.toString();
              });
            },
            validator: (value){
              if(value == null || value == ""){
                return "Select a designation";
              } 
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: kBorderWidth)),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: kBorderWidth)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.buttonYellow, width: kBorderWidth),
            ),
          )
          ),
    )],
    );
  }
}
//for each _designation element, we are mapping it to 'buildMenuItem' function and then converting to List:
//" items: _designations.map(buildMenuItem).toList()  "
DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
  value: item,
  child: Padding(
    padding: const EdgeInsets.all(10),
    child: Text(item, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black)),
  ),
);

//----------------------------------------

///form field for email validation
Widget emailFormElement(TextEditingController emailController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "EMAIL",
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
      ),
      SizedBox(height: kFormSpacing / 2),
      TextFormField(
        style: TextStyle(color: Colors.white),
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
          hintText: "abc@gmail.com",
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
///form field for password validation
Widget passwordFormElement(TextEditingController passwordController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "PASSWORD",
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
      ),
      SizedBox(height: kFormSpacing / 2),
      TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
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
///form field for names (first name, last name)
Widget nameFormElement(String text, TextEditingController nameController) {
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
        style: TextStyle(color: Colors.white),
        autofocus: false,
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
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: kBorderWidth)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.buttonYellow, width: kBorderWidth),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: kBorderWidth))
        ),
        textInputAction: TextInputAction.next,
      ),
    ],
  );
}

//----------------------------------------

//Temporary page to navigate to, from any button
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
            Text("Navigated from '${widget.previousPageName}' to here :))\nName: ${loggedInUser.firstName} ${loggedInUser.lastName}\nEmail: ${loggedInUser.email}\nDesignatoin: ${loggedInUser.designation}"),
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

//Button widget: used in 'Get Started' screen
Widget appButton(String text, Widget newRoute, BuildContext context, {Color textColor = Colors.white, double buttonWidth = 125, double buttonHeight = 35, double fontSize = 16} ){
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

///A text footer -> 'Privacy policy . TOC . Content Policy'
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
