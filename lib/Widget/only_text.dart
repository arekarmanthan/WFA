import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget onlyText(String Data, Color col, double size) {
  return Text(
    Data.toString(),
    style: GoogleFonts.inter(
        textStyle: TextStyle(
      color: col,
      fontSize: size,
    )),
  );
}
