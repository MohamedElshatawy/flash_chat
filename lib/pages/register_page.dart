import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/roundButton.dart';
import 'package:flash_chat/components/roundTextField.dart';
import 'package:flash_chat/components/socialButton.dart';
import 'package:flash_chat/locale/app_localization.dart';
import 'package:flash_chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool visibility = false;
  String email, password;
  bool _loading = false;
  final _authServices = AuthServices();
  final _auth = FirebaseAuth.instance;
  FirebaseUser user;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  void onChange() {
    setState(() {
      visibility = !visibility;
    });
  }

  currentUser() async {
    try {
      final users = await _auth.currentUser();
      if (users != null) {
        user = users;
      }
    } catch (e) {
      print(e);
    }
  }

  register() async {
    var formData = formState.currentState;
    if (formData.validate()) {
      setState(() {
        _loading = true;
      });
      await _authServices
          .registerWithEmailAndPassword(email, password, context)
          .whenComplete(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: SafeArea(
          child: Padding(
            padding: MediaQuery.of(context).padding * 2,
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Form(
                      key: formState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          RoundTextField(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            hintText: AppLocalizations.of(context).email,
                            obscureText: false,
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) =>
                                _authServices.emailValidate(value, context),
                            keyboardType: TextInputType.emailAddress,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.email),
                            ),
                          ),
                          RoundTextField(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            hintText: AppLocalizations.of(context).password,
                            obscureText: visibility ? false : true,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) =>
                                _authServices.passwordValidate(value, context),
                            suffixIcon: IconButton(
                              onPressed: onChange,
                              icon: Icon(visibility
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          RoundTextField(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            hintText: AppLocalizations.of(context)
                                .confirmPasswordText,
                            obscureText: visibility ? false : true,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) =>
                                _authServices.passwordConfirmValidate(
                                    value, password, context),
                            suffixIcon: IconButton(
                              onPressed: onChange,
                              icon: Icon(visibility
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          RoundButton(
                            onPressed: register,
                            color: Colors.deepOrange,
                            title: AppLocalizations.of(context).register,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            indent: 20.0,
                            endIndent: 20.0,
                            height: 30.0,
                          ),
                        ),
                        Text(AppLocalizations.of(context).or),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            indent: 20.0,
                            endIndent: 20.0,
                            height: 30.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SocialButton(
                          icon: Icon(
                            FontAwesomeIcons.google,
                            size: 35.0,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _authServices.signInWithGoogle().whenComplete(() =>
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'chat', (route) => false));
                          },
                        ),
                        SocialButton(
                          icon: Icon(
                            FontAwesomeIcons.facebook,
                            size: 35.0,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _authServices.signInWithFacebook().whenComplete(
                                () => Navigator.pushNamedAndRemoveUntil(
                                    context, 'chat', (route) => false));
                          },
                        ),
                      ],
                    ),
                    FlatButton(
                      child: Text(AppLocalizations.of(context).haveAccount),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'login', (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
