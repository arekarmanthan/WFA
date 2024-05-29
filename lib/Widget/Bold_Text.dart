import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget BoldText(String Data, Color col, double size) {
  return Text(
    Data.toString(),
    style: GoogleFonts.inter(
        textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: col,
      fontSize: size,
    )),
  );
}
