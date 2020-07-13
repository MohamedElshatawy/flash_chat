import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final String title;

  const RoundButton({Key key, this.color, @required this.onPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(title,style: TextStyle(color: Colors.white),),
          minWidth: 200.0,
          height: 42.0,
        ),
      ),
    );
  }
}
