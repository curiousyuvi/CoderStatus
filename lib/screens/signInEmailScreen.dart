import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coder_status/components/colorscheme.dart';
import 'package:coder_status/components/generalLoader.dart';
import 'package:coder_status/components/showAnimatedToast.dart';
import 'package:coder_status/screens/forgotPasswordscreen.dart';
import 'package:coder_status/home.dart';
import 'package:coder_status/firebase_layer/loginUser.dart';
import 'package:coder_status/screens/registerEmailidScreen.dart';
import 'package:coder_status/screens/verifyEmailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../components/myTextFormFields.dart';
import '../components/myButtons.dart';
import '../components/noInternet.dart';

void main() => runApp(
      MaterialApp(
        home: SignInEmailScreen(),
      ),
    );

class SignInEmailScreen extends StatefulWidget {
  @override
  _SignInEmailScreenState createState() => _SignInEmailScreenState();
}

class _SignInEmailScreenState extends State<SignInEmailScreen> {
  //Form State
  StreamSubscription? subscription;

  @override
  initState() {
    super.initState();

    subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;

      if (!hasInternet) noInternet(this.context);
    });
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  String emailid = '';
  String password = '';
  bool isLoading = false;

  void _submit() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      login(emailid.trim(), password.trim()).then((user) async {
        if (user != null) {
          late bool flag;
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get()
              .then((doc) {
            flag = doc.exists;
          });
          if (flag) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return Home();
            }), ModalRoute.withName('/home'));
          } else {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return VerifyEmailScreen();
            }), ModalRoute.withName('/emailVerify'));
          }
        } else {
          setState(() {
            isLoading = false;
          });

          showAnimatedToast(
              this.context, 'Email or Password or both are incorrect.', false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MediaQuery.of(context).viewInsets.bottom == 0
                          ? Flexible(
                              child: Hero(
                                tag: 'appIcon',
                                child: Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  image: AssetImage('images/appiconnoback.png'),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      MediaQuery.of(context).viewInsets.bottom == 0
                          ? RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'headline',
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.06),
                                  children: [
                                    TextSpan(
                                      text: 'CODER',
                                    ),
                                    TextSpan(
                                        text: ' STATUS',
                                        style: TextStyle(
                                            color:
                                                ColorSchemeClass.primarygreen))
                                  ]),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      MyTextFormField(Icon(Icons.email), 'Email Id', false,
                          (val) {
                        emailid = val;
                      },
                          TextInputType.emailAddress,
                          (val) => !val!.contains('@')
                              ? 'Please enter a valid email'
                              : null),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      MyTextFormField(Icon(Icons.vpn_key), 'Password', true,
                          (val) {
                        password = val;
                      },
                          TextInputType.visiblePassword,
                          (val) => val!.trim().length < 6
                              ? 'Please enter a valid password'
                              : null),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03,
                            vertical:
                                MediaQuery.of(context).size.height * 0.01),
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: MyButton(
                            ColorSchemeClass.primarygreen, 'Log in', _submit),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      Flexible(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterEmailidScreen();
                              }));
                            },
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  color: ColorSchemeClass.primarygreen,
                                  fontFamily: 'young',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.022,
                                  decoration: TextDecoration.underline),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      Flexible(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Forgotpasswordscreen();
                              }));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'young',
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                  decoration: TextDecoration.underline),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        isLoading ? GeneralLoaderTransparent('') : SizedBox.shrink()
      ],
    );
  }
}
