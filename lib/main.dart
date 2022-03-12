import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_out1/screens/call_menu.dart';
import 'package:get_out1/screens/caller_id.dart';
import 'package:get_out1/screens/caller_screen.dart';
import 'package:get_out1/screens/scheduler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF00001A),
      systemNavigationBarColor: Color(0xFF00001A),
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: CallMenu(),
      routes: {
        '/CallerScreen': (context) => CallerScreen(),
        '/CallerID': (context) => CallerID(),
        '/Scheduler': (context) => Scheduler(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
