import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
TextStyle AppStyle (double size,Color color,FontWeight fw){
      return GoogleFonts.poppins(fontSize: size,color: color,fontWeight: fw);
}

TextStyle AppStyleWithht (double size,Color color,FontWeight fw,double ht){
      return GoogleFonts.poppins(fontSize: size,color: color,fontWeight: fw,height: ht);
}