import 'package:flutter/material.dart';
import '../../../../core/temas/cores_app.dart';

class BotaoNavegacaoHome extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const BotaoNavegacaoHome({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  State<BotaoNavegacaoHome> createState() => _BotaoNavegacaoHomeState();
}

class _BotaoNavegacaoHomeState extends State<BotaoNavegacaoHome> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: _hovering
                ? CoresApp.cianoPrincipal.withOpacity(0.15)
                : CoresApp.branco,
            borderRadius: BorderRadius.circular(15),
            border: _hovering
                ? Border.all(color: CoresApp.azulCard, width: 1.5)
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_hovering ? 0.10 : 0.05),
                blurRadius: _hovering ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            color: _hovering ? CoresApp.azulCard : CoresApp.textoForte,
            size: 32,
          ),
        ),
      ),
    );
  }
}