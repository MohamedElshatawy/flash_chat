import 'package:flash_chat/components/roundButton.dart';
import 'package:flash_chat/locale/app_localization.dart';
import 'package:flash_chat/pages/login_page.dart';
import 'package:flash_chat/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../constants.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  String lang ;
  List<String> languages = [
    'English',
    'عربي',
  ];
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controller.forward();
    animation = ColorTween(
      begin: Colors.blueGrey,
    ).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                DropdownButton(
                  icon: Icon(
                    Icons.public,
                    color: Colors.lightBlueAccent,
                  ),
                  value: lang,
                  onChanged: (value) {
                    setState(() {
                      lang = value;
                    });
                  },
                  items: languages
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                            onTap: () {
                              if (e == 'عربي') {
                                AppLocalizations.load(Locale('ar', 'AR'));
                              } else {
                                AppLocalizations.load(Locale('en', 'US'));
                              }
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'images/logo.png',
                            height: 60.0,
                          ),
                        ),
                        TypewriterAnimatedTextKit(
                          text: ['Flash'],
                          textStyle: kTextHeadStyle,
                          speed: Duration(seconds: 1),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  RoundButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                    },
                    color: Colors.blue,
                    title: AppLocalizations.of(context).login,
                  ),
                  RoundButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                    },
                    color: Colors.deepOrange,
                    title: AppLocalizations.of(context).register,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
