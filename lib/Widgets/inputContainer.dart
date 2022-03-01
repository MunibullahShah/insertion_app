import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  InputContainer({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
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
            child: TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
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
