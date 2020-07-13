import 'package:flash_chat/l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale)  {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localName = Intl.canonicalizedLocale(name);
    return initializeMessages(localName).then((_) {
      Intl.defaultLocale = localName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  String get title {
    return Intl.message('⚡ ️Chat', name: 'title', desc: 'Application title ');
  }

  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: 'Application Mode ');
  }

  String get passwordUpdate {
    return Intl.message('Password Update',
        name: 'passwordUpdate', desc: 'Application passwordUpdate ');
  }

  String get deleteChat {
    return Intl.message('Delete Chat',
        name: 'deleteChat', desc: 'Application deleteChat ');
  }

  String get logOut {
    return Intl.message('Logout', name: 'logOut', desc: 'Application logOut ');
  }

  String get lang {
    return Intl.message('Change Language', name: 'lang', desc: 'Application Language ');
  }

  String get selectImage {
    return Intl.message('No Image Selected', name: 'selectImage', desc: 'Application selectImage ');
  }

  String get messages {
    return Intl.message('Type your message here...', name: 'messages', desc: 'Application message ');
  }

  String get login {
    return Intl.message('Login', name: 'login', desc: 'Application login ');
  }

  String get register {
    return Intl.message('Register', name: 'register', desc: 'Application Register ');
  }

  String get email {
    return Intl.message('E-mail', name: 'email', desc: 'Application Email ');
  }

  String get password {
    return Intl.message('Password', name: 'password', desc: 'Application Password ');
  }

  String get haveAccount {
    return Intl.message('You have Account', name: 'haveAccount', desc: 'Application haveAccount ');
  }
  String get oldPassword {
    return Intl.message('Old password', name: 'oldPassword', desc: 'Application oldPassword ');
  }
  String get newPassword {
    return Intl.message('New password', name: 'newPassword', desc: 'Application newPassword ');
  }
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: 'Application confirm ');
  }
  String get profilePictureChange {
    return Intl.message('Profile picture change successful', name: 'profilePictureChange', desc: 'Application profilePictureChange ');
  }
  String get enterEmail {
    return Intl.message('Please enter your email', name: 'enterEmail', desc: 'Application enterEmail ');
  }
  String get enterEmailReg {
    return Intl.message('Email must be like this "exmp@gmail.com"', name: 'enterEmailReg', desc: 'Application enterEmailReg ');
  }
  String get enterPassword {
    return Intl.message('Please enter your password', name: 'enterPassword', desc: 'Application enterPassword ');
  }
  String get passwordLessThan {
    return Intl.message('Your password less than 6', name: 'passwordLessThan', desc: 'Application passwordLessThan ');
  }
  String get passwordGreatThan {
    return Intl.message('Your password great than 15', name: 'passwordGreatThan', desc: 'Application passwordGreatThan ');
  }
  String get confirmPassword {
    return Intl.message('Your password and confirmation password \n do not match', name: 'confirmPassword', desc: 'Application confirmPassword ');
  }
  String get confirmPasswordText {
    return Intl.message('Confirm password', name: 'confirmPasswordText', desc: 'Application confirmPasswordText ');
  }
  String get or{
    return Intl.message('OR',name: 'or');
  }
}


class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale locale;

  AppLocalizationDelegate(this.locale);
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
