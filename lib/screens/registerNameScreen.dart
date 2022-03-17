import 'dart:async';
import 'package:coder_status/components/colorscheme.dart';
import 'package:coder_status/screens/registerCodernameScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../components/myTextFormFields.dart';
import '../components/myButtons.dart';
import '../components/noInternet.dart';

void main() => runApp(
      MaterialApp(
        home: Registernamescreen(),
      ),
    );

class Registernamescreen extends StatefulWidget {
  @override
  _RegisternamescreenState createState() => _RegisternamescreenState();
}

class _RegisternamescreenState extends State<Registernamescreen> {
  static String name = '';
  final _formkey = GlobalKey<FormState>();
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

  void _submit() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Registercodernamescreen(name);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: ColorSchemeClass.dark,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'appIcon',
                      child: Image(
                        width: MediaQuery.of(context).size.width * 0.45,
                        image: AssetImage('images/appiconnoback.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Flexible(
                      child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.02),
                    child: Text(
                      'Enter Your Full Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.033,
                          fontFamily: 'young'),
                    ),
                  )),
                  Flexible(
                      child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.02),
                    child: Text(
                      '*Example: Light Yagami',
                      style: TextStyle(
                          color: ColorSchemeClass.darkgrey,
                          fontSize: MediaQuery.of(context).size.height * 0.023,
                          fontFamily: 'young'),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  MyTextFormField(
                      Icon(FontAwesomeIcons.solidUser), 'Full Name', false,
                      (val) {
                    name = val.toString().trim();
                  },
                      TextInputType.name,
                      (val) => val.toString().trim().length < 5
                          ? 'Name is too short'
                          : null),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: MyButton(
                        ColorSchemeClass.primarygreen, 'Next', _submit),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
