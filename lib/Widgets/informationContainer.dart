import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class InformationContainer extends StatelessWidget {
  InformationContainer({
    Key? key,
    required this.label,
    required this.text,
  }) : super(key: key);

  final String label;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 43,
      width: 290,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(
                230,
                242,
                255,
                1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            width: 160,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                  color: label == 'Status'
                      ? text == "Delivered"
                          ? Colors.green
                          : Colors.red
                      : Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
