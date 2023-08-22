import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serina/features/chat_history/view/chat_history_page.dart';
import 'package:serina/features/chatbox/view/chatbox_page_builder.dart';
import 'package:serina/features/chatbox/view/component/chatting_page.dart';
import 'package:serina/firebase_options.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.signInAnonymously();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // static SessionConfig sessionConfig =  SessionConfig(
  //   invalidateSessionForAppLostFocus: const Duration(minutes: 15),
  //   invalidateSessionForUserInactivity: const Duration(minutes: 15),
  // );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "nunito",
        primaryColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: const ChatHistoryPage(),
      home:  ChatboxPage(),
    );
  }
}
