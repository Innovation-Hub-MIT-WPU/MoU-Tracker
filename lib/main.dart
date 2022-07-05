// import 'package:MouTracker/widgets/drawer.dart';
// import 'package:MouTracker/screens/login_register/login_register_page.dart';
// import 'package:MouTracker/screens/splash/splash.dart';
import 'package:MouTracker/common_utils/bottom_nav_util.dart';
import 'package:MouTracker/screens/main_tabs/profile_tab.dart';
import 'package:MouTracker/screens/main_tabs/report_bug.dart';
import 'package:MouTracker/screens/main_tabs/stats_page.dart';

import '/screens/get_started/get_started_page.dart';
import '/screens/get_started/splash_screen_animation_page.dart';

import '/screens/mou_details/mou_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/globals.dart';
import 'common_utils/utils.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kBgClr2,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: '/',
      routes: {
        '/': (_) => const Details(),
        '/start': (context) => const AnimatedSplashScreenPage(),
        '/home': (context) => const GetStartedPage(),
        MyRoute.profileRoute: (context) => const ProfileTab(),
        MyRoute.reportIssuesRoute: (context) => const reportIssues(),
        MyRoute.statsPageRoute: (context) => const StatsPage(),
        MyRoute.startPageRoute: (context) => const Page1(),
      },
    );
  }
}
