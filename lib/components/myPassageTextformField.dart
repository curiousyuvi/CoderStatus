import 'package:flutter/material.dart';
import 'colorscheme.dart';
import 'constants.dart';

class myPassageTextEormField extends StatelessWidget {
  String tfhintText;
  Function onchangedfunction;
  Function validation;
  Color bordercolor;

  myPassageTextEormField(
      String tfhintText, Function onchangedfunction, Function validation,
      [Color bordercolor = colorschemeclass.primarygreen]) {
    this.tfhintText = tfhintText;
    this.onchangedfunction = onchangedfunction;
    this.validation = validation;
    this.bordercolor = bordercolor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: TextFormField(
        maxLines: null,
        validator: validation,
        onChanged: onchangedfunction,
        keyboardType: TextInputType.name,
        cursorColor: bordercolor,
        obscureText: false,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'young',
            fontSize: 15,
            fontWeight: FontWeight.normal),
        decoration: myPassageInputDecoration.copyWith(
          hintText: tfhintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: bordercolor, width: 2)),
        ),
      ),
    );
  }
}