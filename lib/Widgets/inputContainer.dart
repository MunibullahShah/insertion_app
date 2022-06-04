import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  InputContainer({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscure,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hintText;
  var obscure;
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
            child: TextFormField(
              obscureText: label == 'Password' ? true : false,
              maxLines: (label == 'Password' || label == 'Email') ? 1 : 3,
              minLines: 1,
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                if (label == "Email") {
                  if (!EmailValidator.validate(value)) {
                    return "Enter valid email";
                  }
                }
              },
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
