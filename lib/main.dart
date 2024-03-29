import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/get_started/get_started_page.dart';
import 'package:MouTracker/screens/home_page/main_tabs/profile_page/profile_page_utlis/report_bug.dart';
import 'package:MouTracker/screens/home_page/main_tabs/stats_page/stats_page.dart';
import 'package:MouTracker/screens/login_signup/login_signup_page.dart';
import 'package:MouTracker/screens/mou_creation/mou_creation_page.dart';
import 'package:MouTracker/screens/mou_creation/submitted_page.dart';
import 'package:MouTracker/screens/get_started/check_logged.dart';
import 'package:MouTracker/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();

  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: STATUS_BAR_COLOR,
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
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
        // textTheme: DEFAULT_TEXT_THEME,
        textTheme: Theme.of(context).textTheme.copyWith(),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xff2D376E),
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
      initialRoute: '/start',
      routes: {
        '/start': (context) => const CheckAuth(),
        '/test': (_) => const TestWidget(),
        '/login_signup': (_) => const LogInSignUpPage(),
        '/get_started': (_) => const GetStartedPage(),
        '/submitted': (_) => const SubmittedPage(),
        '/create_mou': (_) => const CreateForm(),
        //'/home': (context) => const HomePage(),
        '/report_issues': (context) => const ReportIssues(),

        // MyRoute.profileRoute: (context) => const ProfileTab(controller: null,),
        MyRoute.reportIssuesRoute: (context) => const ReportIssues(),
        MyRoute.statsPageRoute: (context) => const StatsPage(),
      },
    );
  }
}
