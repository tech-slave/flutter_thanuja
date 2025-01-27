import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'registration.dart';
import 'login.dart';
import 'forgot_password.dart';
import 'home.dart';
import 'add_goal.dart';
import 'update_progress.dart';
import 'notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goal Progress Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/home': (context) => HomePage(),
        '/add_goal': (context) => AddGoalPage(),
        '/notification': (context) => NotificationPage(),
    '/update_progress': (context) {
      final goalId = ModalRoute
          .of(context)!
          .settings
          .arguments as String;
      return UpdateProgressPage(goalId: goalId);
    }
    },
    );
  }
}