import 'file:///F:/flutter/flash_chat/lib/model/data.dart';
import 'package:flash_chat/locale/app_localization.dart';
import 'package:flash_chat/pages/chat_page.dart';
import 'package:flash_chat/pages/login_page.dart';
import 'package:flash_chat/pages/register_page.dart';
import 'package:flash_chat/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider<Data>(
      create: (BuildContext context) => Data(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String password;
    var data = Provider.of<Data>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: data.mode ? ThemeData.dark() : ThemeData.light(),
      title: 'Flash',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizationDelegate(Locale('en', 'US')),
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', 'AR'),
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        'login': (context) => Login(),
        'register': (context) => Register(),
        'chat': (context) => Chat(password),
      },
    );
  }
}
