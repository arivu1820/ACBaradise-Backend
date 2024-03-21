import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextContainer extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isOptional;
  final int limit;
  final bool isnum;
  final int minCharacters; // New property for minimum characters

  TextContainer({
    required this.controller,
    required this.limit,
    required this.isnum,
    required this.label,
    this.isOptional = false,
    this.minCharacters = 1, // Set a default minimum character requirement
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: "OxygenRegular",
              color: blackColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: isnum ? TextInputType.number : TextInputType.streetAddress,
            maxLength: limit,
            controller: controller,
            inputFormatters: [
              if (isnum) FilteringTextInputFormatter.allow(RegExp(r'\d')), // Allow only numeric characters
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: lightBlue20Color,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (!isOptional && (value == null || value.isEmpty)) {
                return "This field is required";
              }

              if (value != null && value.length < minCharacters) {
                return "Minimum $minCharacters characters required";
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
