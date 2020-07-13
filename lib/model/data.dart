import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Data extends ChangeNotifier{
  bool _mode = false;
  File _image;
  final _picker = ImagePicker();
  final _reference = FirebaseStorage.instance;
  bool _ar = false;
  bool signIn = false;
  modeThemeChange(bool value){
     _mode = value;
    notifyListeners();
  }
  directionality(bool value){
     _ar = value;
     notifyListeners();
  }
  visibilityChange(bool value){
    signIn = value;
    notifyListeners();
  }
  bool get mode => _mode;
  File get image => _image;
  bool get ar => _ar;
  //Get image from Gallery and store in firebaseStorage
  Future getImage() async {
    var imagePicker = await _picker.getImage(source: ImageSource.gallery);
    _image = File(imagePicker.path);
    StorageReference storageReference = _reference.ref().child('$_image');
    StorageUploadTask storageUploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot storageTaskSnapshot =
    await storageUploadTask.onComplete;
    String url = await storageTaskSnapshot.ref.getDownloadURL();
    print('url $url');
    notifyListeners();
  }
}