import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  InputContainer({
    Key? key,
    required this.controller,
    required this.label,
    this.obscure,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  var obscure;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 43,
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 200,
            //height: 40,
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
