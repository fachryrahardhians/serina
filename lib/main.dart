import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serina/features/chat_history/view/chat_history_page.dart';
import 'package:serina/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.signInAnonymously();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: GoogleFonts.nunito().fontFamily,
        fontFamily: "nunito",
        primaryColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        tooltipTheme: const TooltipThemeData(
          textStyle: TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const ChatHistoryPage(),
    );
  }
}
