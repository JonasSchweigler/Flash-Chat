import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/firebase/auth.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final _auth = FirebaseAuth.instance;
  Auth auth = Auth();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String email = await auth.getEmail();
    String password = await auth.getPassword();
    print('Email: $password');
    print('Password: $email');

    if (email != null && password != null) {
      final autoLogin =
          _auth.signInWithEmailAndPassword(email: password, password: email);
      if (autoLogin != null) {
        Navigator.pushNamed(context, ChatScreen.id);
      }
    } else {
      Navigator.pushNamed(context, WelcomeScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: SpinKitDualRing(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
