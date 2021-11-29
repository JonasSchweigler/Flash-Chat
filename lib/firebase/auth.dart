import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flash_chat/screens/chat_screen.dart';

class Auth {
  final storage = new FlutterSecureStorage();
  final _auth = FirebaseAuth.instance;

  void SignUp(
    String email,
    String password,
    bool showSpinner,
    Function trueState,
    Function falseState,
    BuildContext context,
  ) async {
    if (email != null && password != null) {
      trueState(showSpinner);
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (newUser != null) {
          await storeSecrets(
            email,
            password,
          );
          falseState(showSpinner);
          Navigator.pushNamed(context, ChatScreen.id);
        }
      } catch (e) {
        falseState(showSpinner);
        print(e);
      }
    } else {
      print('No values set');
    }
  }

  void SignIn(
    String email,
    String password,
    bool showSpinner,
    Function trueState,
    Function falseState,
    BuildContext context,
  ) async {
    if (email != null && password != null) {
      trueState(showSpinner);
      try {
        final loginUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (loginUser != null) {
          await storeSecrets(
            email,
            password,
          );
          falseState(showSpinner);
          Navigator.pushNamed(context, ChatScreen.id);
        }
      } catch (e) {
        falseState(showSpinner);
        print(e);
      }
    } else {
      print('No values set');
    }
  }

  Future<void> storeSecrets(String password, String email) async {
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);
  }

  Future<String> getEmail() async {
    return await storage.read(key: 'email');
  }

  Future<String> getPassword() async {
    return await storage.read(key: 'password');
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
