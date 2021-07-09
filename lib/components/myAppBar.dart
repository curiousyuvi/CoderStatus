import 'package:flutter/material.dart';
import 'package:codersstatus/components/colorscheme.dart';
//Add this as parent to myAppBar :
//PreferredSize( preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),

class myAppBar extends StatelessWidget {
  String title;
  myAppBar(String title) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorschemeclass.dark,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: colorschemeclass.lightgrey,
            fontFamily: 'young',
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height * 0.035),
      ),
    );
  }
}
