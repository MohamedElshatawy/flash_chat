import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);
  final Icon icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      elevation: 1.0,
      constraints: BoxConstraints.tightFor(height: 40.0, width: 40.0),
      child: icon,
      onPressed: onPressed,
    );
  }
}
