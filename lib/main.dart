import 'package:MouTracker/screens/get_started/check_logged.dart';
import 'package:MouTracker/screens/home_page/main_tabs/profile_page/profile_page_utlis/report_bug.dart';
import 'package:MouTracker/screens/home_page/main_tabs/profile_page/profile_tab.dart';
import 'package:MouTracker/screens/home_page/main_tabs/stats_page/stats_page.dart';
import 'package:MouTracker/screens/login_signup/login_signup_page.dart';
import 'package:MouTracker/screens/mou_creation/mou_creation_page.dart';
import 'package:MouTracker/screens/mou_creation/submitted_page.dart';
import 'package:MouTracker/screens/home_page/bottom_nav_bar.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/multi_step_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: COLOR_THEME['primary'],
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
        // textTheme: DEFAULT_TEXT_THEME,
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
        '/login_signup': (_) => const LogInSignUpPage(),
        '/multi_form': (_) => const MultiStepForm(),
        '/submitted': (_) => const SubmittedPage(),
        '/create_mou': (_) => const CreateForm(),
        '/start': (context) => const CheckAuth(),
        '/home': (context) => const HomePage(),
        MyRoute.profileRoute: (context) => const ProfileTab(),
        MyRoute.reportIssuesRoute: (context) => const ReportIssues(),
        MyRoute.statsPageRoute: (context) => const StatsPage(),
      },
    );
  }
}
