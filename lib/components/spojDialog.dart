import 'package:codersstatus/components/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

showSpojDialog(
    BuildContext context, Rect rect, String spojHandle, String spojRating) {
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(builder: (context) {
    return GestureDetector(
      onTap: () {
        overlayEntry.remove();
      },
      child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(
                height: rect.top - MediaQuery.of(context).size.height * 0.14,
              ),
              Row(
                children: [
                  SizedBox(
                    width: rect.left - MediaQuery.of(context).size.width * 0.06,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: [
                        GlassContainer(
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: MediaQuery.of(context).size.height * 0.1265,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: MediaQuery.of(context).size.height * 0.157,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('images/dialogSpoj.png'))),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.width * 0.025,
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.height * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Platform : ',
                                      style: TextStyle(
                                          color: ColorSchemeClass.lightgrey,
                                          fontFamily: 'young',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018),
                                    ),
                                    Text(
                                      'SPOJ',
                                      style: TextStyle(
                                          color: ColorSchemeClass.spojblue,
                                          fontFamily: 'young',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Username : ',
                                        style: TextStyle(
                                            color: ColorSchemeClass.lightgrey,
                                            fontFamily: 'young',
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018),
                                      ),
                                      Text(
                                        '@' + spojHandle,
                                        style: TextStyle(
                                            color: ColorSchemeClass.spojblue,
                                            fontFamily: 'young',
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Row(
                                  children: [
                                    Text(
                                      'Rating : ',
                                      style: TextStyle(
                                          color: ColorSchemeClass.lightgrey,
                                          fontFamily: 'young',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018),
                                    ),
                                    Text(
                                      spojRating,
                                      style: TextStyle(
                                          color: ColorSchemeClass.spojblue,
                                          fontFamily: 'young',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' pts',
                                      style: TextStyle(
                                          color: ColorSchemeClass.spojblue,
                                          fontFamily: 'young',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  });

  overlayState.insert(overlayEntry);
}
