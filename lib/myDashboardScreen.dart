import 'package:codersstatus/components/atcoderDialog.dart';
import 'package:codersstatus/components/codechefDialog.dart';
import 'package:codersstatus/components/codeforcesDialog.dart';
import 'package:codersstatus/components/myCircleAvatar.dart';
import 'package:codersstatus/components/myDashboardScreenSkeleton.dart';
import 'package:codersstatus/components/myDividerWithTitle.dart';
import 'package:codersstatus/components/myRatingCard.dart';
import 'package:codersstatus/components/spojDialog.dart';
import 'package:codersstatus/components/urls.dart';
import 'package:codersstatus/firebase_layer/getUserInfo.dart';
import 'package:codersstatus/functions/getRatingFromAPI.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codersstatus/components/colorscheme.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:rive/rive.dart';

class MyDashboardScreen extends StatefulWidget {
  @override
  _MyDashboardScreenState createState() => _MyDashboardScreenState();
}

class _MyDashboardScreenState extends State<MyDashboardScreen> {
  var globalKey1 = RectGetter.createGlobalKey();
  var globalKey2 = RectGetter.createGlobalKey();
  var globalKey3 = RectGetter.createGlobalKey();
  var globalKey4 = RectGetter.createGlobalKey();
  String name = 'name',
      codername = 'codername',
      avatarurl = Urls.avatar1url,
      bio = 'Hey there, I love Competitive Programming';
  List<String> userhandles = ['', '', '', ''],
      userrating = ['0', '0', '0', '0'];

  bool isFirstTimeUserData = true;
  bool isFirstTimeUserRatings = true;
  List<Widget> listOfRatingCards = [];

  readyUserData() async {
    final userDocument = await GetUserInfo.getUserDocument();
    print('reached -1');
    avatarurl = userDocument['avatarurl'];
    name = userDocument['name'];
    codername = userDocument['codername'];
    bio = userDocument['bio'];

    setState(() {
      isFirstTimeUserData = false;
    });
  }

  readyUserRatings() async {
    final userDocument = await GetUserInfo.getUserDocument();

    userhandles[0] = userDocument['codeforces'];
    userhandles[1] = userDocument['codechef'];
    userhandles[2] = userDocument['atcoder'];
    userhandles[3] = userDocument['spoj'];

    if (userhandles[0] != '') {
      userrating[0] =
          await GetRatingFromAPI.getCodeforcesRating(userhandles[0]);
      if (userrating[0] != '0')
        listOfRatingCards.add(RectGetter(
          key: globalKey1,
          child: GestureDetector(
            onTap: () {
              var rect = RectGetter.getRectFromKey(globalKey1);
              print(rect.toString());
              showCodeforcesDialog(
                  this.context, rect, userhandles[0], userrating[0]);
            },
            child: MyRatingCard(AssetImage('images/codeforcestile.png'),
                ColorSchemeClass.codeforcespurple, userrating[0] + ' pts'),
          ),
        ));
    }

    if (userhandles[1] != '') {
      userrating[1] = await GetRatingFromAPI.getCodechefRating(userhandles[1]);
      if (userrating[1] != '0')
        listOfRatingCards.add(RectGetter(
          key: globalKey2,
          child: GestureDetector(
            onTap: () {
              var rect = RectGetter.getRectFromKey(globalKey2);
              print(rect.toString());
              showCodechefDialog(
                  this.context, rect, userhandles[1], userrating[1]);
            },
            child: MyRatingCard(AssetImage('images/codecheftile.png'),
                ColorSchemeClass.codechefbrown, userrating[1] + ' pts'),
          ),
        ));
    }

    if (userhandles[2] != '') {
      userrating[2] = await GetRatingFromAPI.getAtcoderRating(userhandles[2]);
      if (userrating[2] != '0')
        listOfRatingCards.add(RectGetter(
          key: globalKey3,
          child: GestureDetector(
            onTap: () {
              var rect = RectGetter.getRectFromKey(globalKey3);
              print(rect.toString());
              showAtcoderDialog(
                  this.context, rect, userhandles[2], userrating[2]);
            },
            child: MyRatingCard(AssetImage('images/atcodertile.png'),
                ColorSchemeClass.atcodergrey, userrating[2] + ' pts'),
          ),
        ));
    }

    if (userhandles[3] != '') {
      userrating[3] = await GetRatingFromAPI.getSpojRating(userhandles[3]);
      if (userrating[3] != '0')
        listOfRatingCards.add(RectGetter(
          key: globalKey4,
          child: GestureDetector(
            onTap: () {
              var rect = RectGetter.getRectFromKey(globalKey4);
              print(rect.toString());
              showSpojDialog(this.context, rect, userhandles[3], userrating[3]);
            },
            child: MyRatingCard(AssetImage('images/spojtile.png'),
                ColorSchemeClass.spojblue, userrating[3] + ' pts'),
          ),
        ));
    }

    setState(() {
      isFirstTimeUserRatings = false;
    });
  }

  Future futureFunctionUserData;
  Future futureFunctionUserRatings;

  @override
  void initState() {
    super.initState();
    futureFunctionUserData = readyUserData();
    futureFunctionUserRatings = readyUserRatings();
  }

  @override
  Widget build(BuildContext context) {
    return isFirstTimeUserData
        ? FutureBuilder(
            builder: (context, snapshot) {
              return MyDashboardScreenSkeleton();
            },
            future: futureFunctionUserData,
          )
        : Scaffold(
            body: SafeArea(
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.015),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Center(
                          child: Image(
                              image: AssetImage('images/appiconnoback.png')),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.height * 0.22,
                              child: MyCircleAvatar(
                                  Image(image: NetworkImage(avatarurl)))),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'young',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.035),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.007,
                          ),
                          Text(
                            '@' + codername,
                            style: TextStyle(
                                color: ColorSchemeClass.lightgrey,
                                fontFamily: 'young',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          MyMidDividerWithTitle('Bio'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Text(
                            bio,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorSchemeClass.lightgrey,
                                fontFamily: 'young',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          MyMidDividerWithTitle('Ratings'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          isFirstTimeUserRatings
                              ? FutureBuilder(
                                  future: futureFunctionUserRatings,
                                  builder: (context, snapshot) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.32,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Theme(
                                        data: ThemeData(
                                            accentColor: Colors.transparent),
                                        child: GridView.count(
                                            crossAxisCount: 2,
                                            children: [
                                              Container(
                                                child: Center(
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                          child: RiveAnimation
                                                              .asset(
                                                            'assets/skeleton-place-holder.riv',
                                                            fit: BoxFit.cover,
                                                          ))),
                                                ),
                                              ),
                                              Container(
                                                child: Center(
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                          child: RiveAnimation
                                                              .asset(
                                                            'assets/skeleton-place-holder.riv',
                                                            fit: BoxFit.cover,
                                                          ))),
                                                ),
                                              ),
                                              Container(
                                                child: Center(
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                          child: RiveAnimation
                                                              .asset(
                                                            'assets/skeleton-place-holder.riv',
                                                            fit: BoxFit.cover,
                                                          ))),
                                                ),
                                              ),
                                              Container(
                                                child: Center(
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                          child: RiveAnimation
                                                              .asset(
                                                            'assets/skeleton-place-holder.riv',
                                                            fit: BoxFit.cover,
                                                          ))),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    );
                                  })
                              : listOfRatingCards.length == 0
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.32,
                                      child: Center(
                                        child: DottedBorder(
                                          strokeWidth: 1,
                                          dashPattern: [5, 5],
                                          color: ColorSchemeClass.darkgrey,
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05),
                                            child: Text(
                                              'NO RATINGS',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color:
                                                      ColorSchemeClass.darkgrey,
                                                  fontFamily: 'young',
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : (listOfRatingCards.length % 2 == 1)
                                      ? listOfRatingCards.length == 3
                                          ? Column(
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.155,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Theme(
                                                    data: ThemeData(
                                                        accentColor:
                                                            Colors.transparent),
                                                    child: GridView.count(
                                                        crossAxisCount: 2,
                                                        children:
                                                            listOfRatingCards
                                                                .sublist(0, 2)),
                                                  ),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.155,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Center(
                                                    child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        child:
                                                            listOfRatingCards[
                                                                2]),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.155,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Center(
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    child:
                                                        listOfRatingCards[0]),
                                              ),
                                            )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.32,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Theme(
                                            data: ThemeData(
                                                accentColor:
                                                    Colors.transparent),
                                            child: GridView.count(
                                                crossAxisCount: 2,
                                                children: listOfRatingCards),
                                          ),
                                        )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}


/* */