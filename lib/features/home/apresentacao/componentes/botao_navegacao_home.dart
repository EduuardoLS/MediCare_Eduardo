import 'package:flutter/material.dart';
import '../../../../core/temas/cores_app.dart';

class BotaoNavegacaoHome extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const BotaoNavegacaoHome({
    super.key, 
    required this.icon, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: CoresApp.branco,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), 
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Icon(icon, color: CoresApp.azulCard, size: 35),
      ),
    );
  }
}