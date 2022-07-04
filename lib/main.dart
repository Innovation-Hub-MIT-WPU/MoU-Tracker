// import 'package:MouTracker/widgets/drawer.dart';
// ignore_for_file: prefer_const_constructors

import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/main_tabs/profile_tab.dart';
import 'package:MouTracker/screens/report_bug/report_bug.dart';
import 'package:flutter/material.dart';

import 'package:MouTracker/globals.dart';
// import 'package:MouTracker/screens/login_register/login_register_page.dart';
// import 'package:MouTracker/screens/splash/splash.dart';

import 'package:firebase_core/firebase_core.dart';
// import 'package:MouTracker/services/Firebase/firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: DEFAULT_TEXT_THEME,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0x9400688B),
              secondary: const Color(0xFFF0FFFF),
            ),
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              buttonColor: const Color(0xFFC1F0F6),
            ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: DEFAULT_TEXT_THEME,
      ),
      themeMode: ThemeMode.light,
      initialRoute: MyRoute.startPageRoute,
      routes: {
        MyRoute.profileRoute: (context) => ProfileTab(),
        MyRoute.reportIssuesRoute: (context) => reportIssues(),
        MyRoute.startPageRoute: (context) => Page1(),
      },
    );
  }
}
