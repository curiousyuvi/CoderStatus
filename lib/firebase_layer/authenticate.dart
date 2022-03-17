import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coder_status/components/generalLoader.dart';
import 'package:coder_status/screens/getStartedScreen.dart';
import 'package:coder_status/home.dart';
import 'package:coder_status/screens/registerNameScreen.dart';
import 'package:coder_status/screens/verifyEmailScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class Authenticate extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool flag = false;

  Future updateFlag() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((doc) {
        flag = doc.exists;
      });
    } catch (e) {
      flag = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: updateFlag(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_auth.currentUser != null) {
            if (_auth.currentUser!.emailVerified) {
              if (flag) {
                return Home();
              } else {
                return Registernamescreen();
              }
            } else {
              return VerifyEmailScreen();
            }
          } else {
            return GetStartedScreen();
          }
        } else {
          return GeneralLoader('');
        }
      },
    );
  }
}
