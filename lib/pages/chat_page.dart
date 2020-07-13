import 'file:///F:/flutter/flash_chat/lib/model/data.dart';
import 'package:flash_chat/components/dialogContent.dart';
import 'package:flash_chat/components/roundButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/locale/app_localization.dart';
import 'package:flash_chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/messageBubble.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedUSer;

class Chat extends StatefulWidget {
  final String password;
  Chat(this.password);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String password;
  final _auth = FirebaseAuth.instance;
  String messageText;
  final controller = TextEditingController();
  String oldPassword;
  String newPassword;
  String email;
  bool validation = true;
  bool ar = false;
  GlobalKey<ScaffoldState> snackBar = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final _authServices = AuthServices();
  void getCurrentUSer() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedUSer = user;

      }
    } catch (e) {
      print(e);
    }
    setState(() {
      email = loggedUSer.email;
    });

  }

  passwordChange() {
    var formData = formState.currentState;
    if (formData.validate()) {
      setState(() {
        validation = false;
      });
      if (oldPassword == password) {
        loggedUSer.updatePassword(newPassword);
        Navigator.pop(context);
      }
    }
  }

  Future alert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(AppLocalizations.of(context).passwordUpdate),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: Colors.lightBlueAccent,
                    size: 40.0,
                  ),
                ),
              ],
            ),
            elevation: 0.6,
            children: <Widget>[
              Form(
                key: formState,
                child: Column(
                  children: <Widget>[
                    DialogContent(
                      onChange: (value) {
                        oldPassword = value;
                      },
                      hintText: AppLocalizations.of(context).oldPassword,
                      validator: (value) => _authServices
                          .passwordConfirmValidate(value, password,context),
                    ),
                    DialogContent(
                      onChange: (value) {
                        newPassword = value;
                      },
                      validator: (value) =>
                          _authServices.passwordValidate(value,context),
                      hintText: AppLocalizations.of(context).newPassword,
                    ),
                    RoundButton(
                      color: Colors.red,
                      title: AppLocalizations.of(context).confirm,
                      onPressed: passwordChange,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUSer();
    password = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, data, child) {
        return Directionality(
          textDirection:
              data.ar == true ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            key: snackBar,
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).title),
              backgroundColor: Colors.lightBlueAccent,
              elevation: 6.0,
              centerTitle: true,
            ),
            drawer: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: Drawer(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                            ),
                            currentAccountPicture: Stack(
                              fit: StackFit.expand,
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Container(
                                  child: data.image == null
                                      ? Text(AppLocalizations.of(context)
                                          .selectImage)
                                      : CircleAvatar(
                                          backgroundImage:
                                              FileImage(data.image),
                                        ),
                                ),
                                Positioned.fill(
                                  bottom: -55.0,
                                  left: 42.0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    ),
                                    iconSize: 21.0,
                                    onPressed: () {
                                      data.getImage().whenComplete(() =>
                                          snackBar.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                AppLocalizations.of(context)
                                                    .profilePictureChange),
                                          )));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            accountEmail: ListTile(
                              contentPadding: EdgeInsets.only(left: 0.0),
                              title: Text(
                                '$email',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              leading: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SwitchListTile(
                            value: data.mode,
                            title: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.brightness_4,
                                  color: Colors.lightBlueAccent,
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Text(AppLocalizations.of(context).darkMode),
                              ],
                            ),
                            onChanged: (value) {
                              data.modeThemeChange(value);
                            },
                            activeTrackColor: Colors.grey,
                            activeColor: Colors.white,
                          ),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context).passwordUpdate,
                              style: kListTileStyle,
                            ),
                            leading: Icon(
                              Icons.edit,
                              color: Colors.lightBlueAccent,
                            ),
                            onTap: () {
                              alert(context);
                            },
                          ),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context).deleteChat,
                              style: kListTileStyle,
                            ),
                            leading: Icon(
                              Icons.delete,
                              color: Colors.lightBlueAccent,
                            ),
                            onTap: () {
                              _fireStore
                                  .collection('messages')
                                  .getDocuments()
                                  .then((snapshot) {
                                for (DocumentSnapshot doc
                                    in snapshot.documents) {
                                  doc.reference.delete();
                                }
                              });
                            },
                          ),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context).lang,
                              style: kListTileStyle,
                            ),
                            leading: Icon(
                              Icons.public,
                              color: Colors.lightBlueAccent,
                            ),
                            onTap: () {
                              Alert(
                                context: context,
                                title: AppLocalizations.of(context).lang,
                                style: AlertStyle(
                                  backgroundColor: ThemeData.dark() != null
                                      ? Colors.white
                                      : Colors.white,
                                ),
                                closeFunction: () {},
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      'English',
                                      style: kLanguageButtonText,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        AppLocalizations.load(
                                            Locale('en', 'US'));
                                        data.directionality(false);
                                        Navigator.pop(context);
                                      });
                                    },
                                    radius: BorderRadius.circular(30.0),
                                  ),
                                  DialogButton(
                                    child: Text(
                                      'عربى',
                                      style: kLanguageButtonText,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        AppLocalizations.load(
                                            Locale('ar', 'AR'));
                                        data.directionality(true);
                                        Navigator.pop(context);
                                      });
                                    },
                                    radius: BorderRadius.circular(30.0),
                                    color: Colors.red,
                                  ),
                                ],
                              ).show();
                            },
                          ),
                          Divider(
                            color: Colors.lightBlueAccent,
                            indent: 50.0,
                            endIndent: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RoundButton(
                            onPressed: () async {
                              _auth.signOut();
                              _authServices.googleSignIn.signOut();
                              _authServices.facebookLogin.logOut();
                              Navigator.pushNamedAndRemoveUntil(context, '/',
                                  (Route<dynamic> route) => false);
                            },
                            color: Colors.red,
                            title: AppLocalizations.of(context).logOut,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomStream(),
                Container(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextField(
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: AppLocalizations.of(context).messages,
                              ),
                              controller: controller,
                              onChanged: (value) {
                                messageText = value;
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.clear();
                            _fireStore.collection('messages').add({
                              'text': messageText,
                              'sender': loggedUSer.email,
                              'time': DateTime.now(),
                            });
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.lightBlueAccent,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomStream extends StatelessWidget {
  const CustomStream({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messagesBox = [];
        if (snapshot.hasError) {
          return Center(
            child: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
          );
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
              break;
            case ConnectionState.active:
              final messages = snapshot.data.documents.reversed;
              for (var message in messages) {
                final text = message.data['text'];
                final sender = message.data['sender'];
                final currentUser = loggedUSer.email;
                final messageBox = MessageBubble(
                  message: text,
                  sender: sender,
                  isUser: currentUser == sender,
                );
                messagesBox.add(messageBox);
              }
              break;
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: messagesBox,
          ),
        );
      },
    );
  }
}
