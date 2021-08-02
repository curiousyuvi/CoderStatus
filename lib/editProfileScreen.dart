import 'dart:io';
import 'package:codersstatus/components/colorscheme.dart';
import 'package:codersstatus/components/myAppBarWithBack.dart';
import 'package:codersstatus/components/myAvatarSelection.dart';
import 'package:codersstatus/components/myButton.dart';
import 'package:codersstatus/components/myCircleAvatar.dart';
import 'package:codersstatus/components/myDividerWithTitle.dart';
import 'package:codersstatus/components/myPassageTextformField.dart';
import 'package:codersstatus/components/myTextFormField.dart';
import 'package:codersstatus/components/urls.dart';
import 'package:codersstatus/firebase_layer/getUserInfo.dart';
import 'package:codersstatus/firebase_layer/setUserInfo.dart';
import 'package:codersstatus/firebase_layer/uploadAvatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'functions/pickImageAndCrop.dart' as pickImageAndCrop;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String urltobeset = urls.avatar1url;

  Image avatarshowimage = Image(image: NetworkImage(urls.avatar1url));
  TextEditingController nameEditingController;
  TextEditingController codernameEditingController;
  TextEditingController bioEditingController;

  File imagetobeuploaded;
  bool isLoading = false;
  bool isFirstTime = true;

  readyUserData() async {
    urltobeset = await GetUserInfo.getUserAvatarUrl();
    avatarshowimage = Image(
      image: NetworkImage(urltobeset),
    );
    final name = await GetUserInfo.getUserName();
    nameEditingController = TextEditingController(text: name);
    final codername = await GetUserInfo.getUserCoderName();
    codernameEditingController = TextEditingController(text: codername);
    final bio = await GetUserInfo.getUserBio();
    bioEditingController = TextEditingController(text: bio);
    setState(() {
      isFirstTime = false;
    });
  }

  Future<String> generateUrl(File imagefile) async {
    final url = await UploadUserAvatar.uploadUserAvatar(imagefile);

    return url;
  }

  pick() async {
    urltobeset = null;
    final pickedfile = await pickImageAndCrop.pickimage();
    imagetobeuploaded = pickedfile;

    setState(() {
      avatarshowimage = Image.file(pickedfile);
    });

    return;
  }

  List<bool> _selections = [
    false,
    true,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<Widget> _avatarbuttons = [
    myAvatarSelection(Image(image: AssetImage('images/avatar0.jpg')), false),
    myAvatarSelection(Image(image: AssetImage('images/avatar1.jpg')), true),
    myAvatarSelection(Image(image: AssetImage('images/avatar2.jpg')), false),
    myAvatarSelection(Image(image: AssetImage('images/avatar3.jpg')), false),
    myAvatarSelection(Image(image: AssetImage('images/avatar4.jpg')), false),
    myAvatarSelection(Image(image: AssetImage('images/avatar5.jpg')), false),
    myAvatarSelection(Image(image: AssetImage('images/avatar6.jpg')), false),
    myAvatarSelection(Image(image: AssetImage('images/avatar7.jpg')), false),
  ];

  final _formkey = GlobalKey<FormState>();

  _updateProfile() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      setState(() {
        isLoading = true;
      });
      if (imagetobeuploaded != null) {
        urltobeset = await generateUrl(imagetobeuploaded);
      }

      await SetUserInfo.updateAvatar(urltobeset);
      await SetUserInfo.updateName(nameEditingController.text.trim());
      await SetUserInfo.updateCodername(codernameEditingController.text.trim());
      await SetUserInfo.updateBio(bioEditingController.text.trim());

      Phoenix.rebirth(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: myAppBarWithBack('Edit Profile'),
        ),
        backgroundColor: colorschemeclass.dark,
        body: isFirstTime
            ? FutureBuilder(
                future: readyUserData(),
                builder: (context, snapshot) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            : isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Form(
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                MyDividerWithTitle('Avatar'),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    width: MediaQuery.of(context).size.height *
                                        0.27,
                                    child: myCircleAvatar(
                                        avatarimage: avatarshowimage)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.028),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ToggleButtons(
                                    isSelected: _selections,
                                    children: _avatarbuttons,
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int i = 0; i < 8; i++) {
                                          _selections[i] = false;
                                        }
                                        _avatarbuttons[0] = myAvatarSelection(
                                            Image(
                                                image: AssetImage(
                                                    'images/avatar0.jpg')),
                                            false);
                                        _avatarbuttons[1] = myAvatarSelection(
                                            Image(
                                                image: AssetImage(
                                                    'images/avatar1.jpg')),
                                            false);
                                        _avatarbuttons[2] = myAvatarSelection(
                                            Image(
                                                image: AssetImage(
                                                    'images/avatar2.jpg')),
                                            false);
                                        _avatarbuttons[3] = myAvatarSelection(
                                            Image(
                                                image: AssetImage(
                                                    'images/avatar3.jpg')),
                                            false);
                                        _avatarbuttons[4] = myAvatarSelection(
                                            Image(
                                                image: AssetImage(
                                                    'images/avatar4.jpg')),
                                            false);
                                        _avatarbuttons[5] = myAvatarSelection(
                                            Image(
                                                image: AssetImage(
                                                    'images/avatar5.jpg')),
                                            false);
                                        _avatarbuttons[6] = myAvatarSelection(
                                            Image(
                                                image: AssetImage(
                                                    'images/avatar6.jpg')),
                                            false);
                                        _avatarbuttons[7] = myAvatarSelection(
                                            Image(
                                                image: AssetImage(
                                                    'images/avatar7.jpg')),
                                            false);

                                        _selections[index] = true;
                                        if (index > 0) {
                                          imagetobeuploaded = null;

                                          switch (index) {
                                            case 1:
                                              {
                                                urltobeset = urls.avatar1url;
                                              }
                                              break;
                                            case 2:
                                              {
                                                urltobeset = urls.avatar2url;
                                              }
                                              break;
                                            case 3:
                                              {
                                                urltobeset = urls.avatar3url;
                                              }
                                              break;
                                            case 4:
                                              {
                                                urltobeset = urls.avatar4url;
                                              }
                                              break;
                                            case 5:
                                              {
                                                urltobeset = urls.avatar5url;
                                              }
                                              break;
                                            case 6:
                                              {
                                                urltobeset = urls.avatar6url;
                                              }
                                              break;
                                            case 7:
                                              {
                                                urltobeset = urls.avatar7url;
                                              }
                                              break;
                                          }

                                          avatarshowimage = Image(
                                            image: AssetImage(
                                                'images/avatar$index.jpg'),
                                          );
                                        } else {
                                          pick();
                                        }
                                        _avatarbuttons[index] = myAvatarSelection(
                                            Image(
                                                image: AssetImage(
                                                    'images/avatar$index.jpg')),
                                            true);
                                      });
                                    },
                                    renderBorder: false,
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                                Divider(
                                  color: colorschemeclass.darkgrey,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.028),
                                MyDividerWithTitle('Name'),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.028),
                                myTextEormField(
                                    Icon(Icons.person),
                                    'Name',
                                    false,
                                    (val) {},
                                    TextInputType.name,
                                    (val) => val.toString().trim().length < 5
                                        ? 'Name is too short'
                                        : null,
                                    nameEditingController),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.028),
                                Divider(
                                  color: colorschemeclass.darkgrey,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.028),
                                MyDividerWithTitle('Codername'),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.028),
                                myTextEormField(
                                    Icon(Icons.alternate_email),
                                    'Codername',
                                    false,
                                    (val) {},
                                    TextInputType.name,
                                    (val) => (val
                                                .toString()
                                                .trim()
                                                .contains(' ') ||
                                            val.toString().trim().length < 4)
                                        ? 'Codername can only be consist a single word'
                                        : null,
                                    codernameEditingController),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.028),
                                Divider(
                                  color: colorschemeclass.darkgrey,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.028),
                                MyDividerWithTitle('Bio'),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.028),
                                myPassageTextEormField(
                                    'Bio',
                                    (val) {},
                                    (val) => val.toString().trim().length > 100
                                        ? 'Bio should be less than 100 charachters'
                                        : null,
                                    bioEditingController),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.028),
                                Divider(
                                  color: colorschemeclass.darkgrey,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.0135,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  height:
                                      MediaQuery.of(context).size.height * 0.09,
                                  child: myButton(colorschemeclass.primarygreen,
                                      'Update Profile', _updateProfile),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
  }
}