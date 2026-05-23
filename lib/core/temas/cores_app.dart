import 'package:flutter/material.dart';

class CoresApp {
  static const Color cianoPrincipal   = Color(0xFF00E5FF);
  static const Color cianoClaro       = Color(0xFFCCF7FF); // topo do gradiente (bem suave)
  static const Color azulCard         = Color(0xFF0099BB); // barra lateral dos cards (azul mais forte)
  static const Color fundoCreme       = Color(0xFFF9F9F7);
  static const Color textoForte       = Colors.black87;
  static const Color textoSecundario  = Colors.black54;
  static const Color branco           = Colors.white;

  static const LinearGradient gradienteBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [cianoClaro, cianoPrincipal],
    stops: [0.0, 1.0],
  );
}