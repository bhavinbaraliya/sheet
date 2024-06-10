import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sheet/Provider/UserProvider.dart';
import 'package:sheet/Screens/AddWork.dart';
import 'package:sheet/Screens/HomePage.dart';
import 'package:sheet/Screens/SignupPage.dart';
import 'package:sheet/Screens/ViewWork.dart';
import 'package:sheet/Screens/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  print('Initializing Firebase...');
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getName()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          SignUpPage.id: (context) => SignUpPage(),
          HomePage.id: (context) => HomePage(),
          AddWork.id: (context) => AddWork(),
          ViewWork.id: (context) => ViewWork(),
        },
      ),
    );
  }
}
