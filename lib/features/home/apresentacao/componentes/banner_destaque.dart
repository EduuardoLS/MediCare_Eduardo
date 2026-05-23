import 'package:flutter/material.dart';

class BannerDestaque extends StatelessWidget {
  const BannerDestaque({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/banner_fundo.png'), // Imagem de fundo
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Imagem sobreposta (ex: médico ou paciente vazado em PNG)
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/banner_frente.png', 
              height: 180, // Ajuste a altura conforme sua imagem real
              fit: BoxFit.contain,
            ),
          ),
          // Gradiente sutil para dar contraste ao texto
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              ),
            ),
          ),
          // Textos
          const Positioned(
            right: 15,
            top: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'SAÚDE NO CONFORTO\nDO NOSSO LAR',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'MEDICARE',
                  style: TextStyle(
                    color: Colors.white70, 
                    fontSize: 12, 
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}