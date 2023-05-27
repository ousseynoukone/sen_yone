import 'package:flutter/material.dart';

class BtnComponent extends StatelessWidget {
    final VoidCallback onPressed;

  const BtnComponent({super.key , required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).primaryColorLight,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        "Allons-y",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}



