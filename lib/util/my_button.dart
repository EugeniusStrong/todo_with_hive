import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String nameButton;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.nameButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(nameButton),
    );
  }
}
