import 'package:codersstatus/components/colorscheme.dart';
import 'package:codersstatus/registercodernamescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'components/myTextFormField.dart';
import 'components/myButton.dart';

void main() => runApp(
      MaterialApp(
        home: Registernamescreen(),
      ),
    );

class Registernamescreen extends StatefulWidget {
  const Registernamescreen({Key key}) : super(key: key);

  @override
  _RegisternamescreenState createState() => _RegisternamescreenState();
}

class _RegisternamescreenState extends State<Registernamescreen> {
  static String name = '';
  final _formkey = GlobalKey<FormState>();

  void _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Registercodernamescreen(name);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorschemeclass.dark,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'splashscreenImage',
                    child: Image(
                      width: 300,
                      image: AssetImage('images/appiconnoback.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Enter Your Full Name',
                    style: TextStyle(
                        color: Colors.white, fontSize: 25, fontFamily: 'young'),
                  ),
                )),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '*Example: Alan Wil',
                    style: TextStyle(
                        color: colorschemeclass.darkgrey,
                        fontSize: 15,
                        fontFamily: 'young'),
                    textAlign: TextAlign.center,
                  ),
                )),
                myTextEormField(Icon(Icons.person), 'Full Name', false, (val) {
                  name = val;
                }, TextInputType.name,
                    (val) => val.length < 5 ? 'Name is too short' : null),
                Container(
                    padding: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.11,
                    child: myButton(
                        colorschemeclass.primarygreen, 'Next', _submit))
              ],
            ),
          ),
        ),
      ),
    );
  }
}