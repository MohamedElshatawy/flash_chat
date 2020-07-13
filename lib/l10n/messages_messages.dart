// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Your password and confirmation password \n do not match"),
    "confirmPasswordText" : MessageLookupByLibrary.simpleMessage("Confirm password"),
    "darkMode" : MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "deleteChat" : MessageLookupByLibrary.simpleMessage("Delete Chat"),
    "email" : MessageLookupByLibrary.simpleMessage("E-mail"),
    "enterEmail" : MessageLookupByLibrary.simpleMessage("Please enter your email"),
    "enterEmailReg" : MessageLookupByLibrary.simpleMessage("Email must be like this \"exmp@gmail.com\""),
    "enterPassword" : MessageLookupByLibrary.simpleMessage("Please enter your password"),
    "haveAccount" : MessageLookupByLibrary.simpleMessage("You have Account"),
    "lang" : MessageLookupByLibrary.simpleMessage("Change Language"),
    "logOut" : MessageLookupByLibrary.simpleMessage("Logout"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "messages" : MessageLookupByLibrary.simpleMessage("Type your message here..."),
    "newPassword" : MessageLookupByLibrary.simpleMessage("New password"),
    "oldPassword" : MessageLookupByLibrary.simpleMessage("Old password"),
    "or" : MessageLookupByLibrary.simpleMessage("OR"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "passwordGreatThan" : MessageLookupByLibrary.simpleMessage("Your password great than 15"),
    "passwordLessThan" : MessageLookupByLibrary.simpleMessage("Your password less than 6"),
    "passwordUpdate" : MessageLookupByLibrary.simpleMessage("Password Update"),
    "profilePictureChange" : MessageLookupByLibrary.simpleMessage("Profile picture change successful"),
    "register" : MessageLookupByLibrary.simpleMessage("Register"),
    "selectImage" : MessageLookupByLibrary.simpleMessage("No Image Selected"),
    "title" : MessageLookupByLibrary.simpleMessage("⚡ ️Chat")
  };
}
