import 'package:flutter/material.dart';
import 'colorscheme.dart';

class myButton extends StatelessWidget {
  Function dofunction;
  bool prominent;
  Color buttoncolor;
  Color titlecolor;
  String title;

  myButton(bool prominent, String title, Function dofunction) {
    this.prominent = prominent;
    this.title = title;
    this.dofunction = dofunction;
    if (prominent) {
      buttoncolor = colorschemeclass.primarygreen;
      titlecolor = Colors.white;
    } else {
      buttoncolor = Colors.white;
      titlecolor = colorschemeclass.unactivatedblack;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 15,
        color: buttoncolor,
        shadowColor: buttoncolor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(5),
        child: MaterialButton(
          onPressed: dofunction,
          minWidth: double.infinity,
          height: 50,
          child: Text(
            title,
            style: TextStyle(
                color: titlecolor,
                fontFamily: 'young',
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
      ),
    );
  }
}