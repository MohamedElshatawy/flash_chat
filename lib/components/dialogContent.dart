
import 'package:flash_chat/components/roundTextField.dart';
import 'package:flutter/material.dart';

class DialogContent extends StatefulWidget {
  final Function onChange;
  final String hintText;
  final TextEditingController controller;
  final String Function(String value) validator;

  const DialogContent({Key key, this.onChange, this.hintText, this.controller, this.validator}) : super(key: key);
  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  bool visibility = false;
  void visibilityPassword(){
    setState(() {
      visibility=!visibility;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      child: RoundTextField(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        obscureText: visibility ? false : true,
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        validator: widget.validator,
        hintText: widget.hintText,
        icon: Icon(
          Icons.vpn_key,
          color: Colors.lightBlueAccent,
        ),
        onChanged: widget.onChange,
        suffixIcon: IconButton(
          onPressed: visibilityPassword,
          icon: Icon(visibility ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}