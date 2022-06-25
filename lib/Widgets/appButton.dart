import 'package:flutter/material.dart';

import '../constants.dart';

class appButton extends StatelessWidget {
  var onTap;
  String label;

  appButton(this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        width: 75,
        decoration: BoxDecoration(
          color: primaryButtonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: buttonTextColor,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
