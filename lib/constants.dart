import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kTextHeadStyle = TextStyle(
  fontSize: 35.0,
  fontWeight: FontWeight.w900,
);
const kTextFieldDecoration =InputDecoration(
  hintText: 'Type your message here...',
  contentPadding: EdgeInsets.symmetric(
    horizontal: 20.0,
  ),
  border: OutlineInputBorder(
    borderRadius:BorderRadius.all(Radius.circular(30.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);
const kPadding =EdgeInsets.fromLTRB(6.0, 20.0, 0.0, 0.0);
const kListTileStyle = TextStyle(fontWeight: FontWeight.w500);
const kLanguageButtonText = TextStyle(
  color: Colors.white,
);
