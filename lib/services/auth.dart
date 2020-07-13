import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/locale/app_localization.dart';
import 'package:flash_chat/pages/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final googleSignIn = GoogleSignIn();
  final facebookLogin = FacebookLogin();
  final _auth = FirebaseAuth.instance;
  String _pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //Email validation
  emailValidate(String value,BuildContext context){
    if(value.trim().isEmpty){
      return AppLocalizations.of(context).enterEmail;
    }
    RegExp regExp = RegExp(_pattern);
    if(!regExp.hasMatch(value)){
      return AppLocalizations.of(context).enterEmailReg;
    }
  }
  //Password validation
  passwordValidate(String value,BuildContext context){
    if(value.trim().isEmpty){
      return AppLocalizations.of(context).enterPassword;
    }
    if(value.trim().length < 6){
      return AppLocalizations.of(context).passwordLessThan;
    }
    if(value.trim().length > 15){
      return AppLocalizations.of(context).passwordGreatThan;
    }
  }
  passwordConfirmValidate(String value,String password,BuildContext context){
    if(value != password){
      return AppLocalizations.of(context).confirmPassword;
    }
  }

  //Register using email and password
  Future registerWithEmailAndPassword(
      email, password, BuildContext context) async {
    AuthResult result = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .whenComplete(() => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Chat(password)),
            (route) => false))
        .catchError((onError) => print(onError.toString()));
    FirebaseUser user = result.user;
    return user;
  }
  //Login using email and password
  Future signInWithEmailAndPassword(
      email, password, BuildContext context) async {
    AuthResult result = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .whenComplete(() => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Chat(password)),
            (route) => false))
        .catchError((onError) => print(onError.toString()));
    FirebaseUser user = result.user;
    return user;
  }

  //Login and register using google
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    final AuthResult result = await _auth.signInWithCredential(credential);
    final FirebaseUser user = result.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    return 'Sign In With Google Succeeded : $user';
  }

  //Login and register using facebook
  Future signInWithFacebook() async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: accessToken.token,
        );
        final AuthResult authResult =
            await _auth.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);
        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
  Stream<FirebaseUser> get user  {
    return _auth.onAuthStateChanged;
  }
}
