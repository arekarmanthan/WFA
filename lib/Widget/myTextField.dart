import 'package:flutter/material.dart';

Widget myTextField(String hint, var Controllers, TextInputType userInputtype) {
  return Container(
    child: TextField(
      controller: Controllers,
      keyboardType: userInputtype,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        fillColor: Color.fromARGB(255, 255, 255, 255),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(18),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color.fromARGB(115, 64, 64, 64),
          fontSize: 19,
        ),
      ),
    ),
  );
}
