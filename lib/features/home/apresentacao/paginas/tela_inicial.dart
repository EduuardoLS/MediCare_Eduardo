import 'package:flutter/material.dart';
import '../../../../core/temas/cores_app.dart';
import '../../../agenda/apresentacao/componentes/recortes_nuvem.dart';
import '../../../agenda/apresentacao/paginas/tela_agenda_medica.dart';
import '../../../medicamentos/apresentacao/paginas/tela_medicamentos.dart';
import '../../../buscar/apresentacao/paginas/tela_buscar.dart';
import '../componentes/banner_destaque.dart';
import '../componentes/botao_navegacao_home.dart';
import '../componentes/cartao_horizontal.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: CoresApp.gradienteBackground,
        ),
        child: SafeArea(
          top: false,
          bottom: false,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const BannerDestaque(),
                const SizedBox(height: 8),
                _buildNavegacaoPrincipal(context),
                const SizedBox(height: 8),
                _buildSecaoIlhaBranca(
                  titulo: 'FAVORITOS',
                  conteudo: _buildCardsHorizontais([
                    const CartaoHorizontal(label: 'WEARBLE',    imgPath: 'assets/images/card_wearble.png'),
                    const CartaoHorizontal(label: 'PRONTUÁRIO', imgPath: 'assets/images/card_prontuario.png'),
                  ]),
                ),
                const SizedBox(height: 8),
                _buildSecaoIlhaBranca(
                  titulo: 'FUNCIONALIDADES',
                  conteudo: _buildCardsHorizontais([
                    const CartaoHorizontal(label: 'AGENDAMENTO', imgPath: 'assets/images/card_agendamento.png'),
                    const CartaoHorizontal(label: 'WEARBLE',     imgPath: 'assets/images/card_wearble.png'),
                  ]),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ClipPath(
      clipper: RecorteNuvemSuperior(),
      child: Container(
        height: 120,
        color: CoresApp.fundoCreme,
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 36),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/logo.png',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            _BotaoIconeHeader(
              icon: Icons.notification_add_outlined,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavegacaoPrincipal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BotaoNavegacaoHome(
            icon: Icons.assignment,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TelaAgendaMedica()),
            ),
          ),
          BotaoNavegacaoHome(
            icon: Icons.search,
            onTap: () => Navigator.push(
              context,
              // CORREÇÃO: "TelaBuscar" com 'T' maiúsculo
              MaterialPageRoute(builder: (_) => const TelaBuscar()), 
            ),
          ),
          BotaoNavegacaoHome(
            icon: Icons.medication_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GerenciarMedicamentosPage()),
            ),
          ),
          BotaoNavegacaoHome(
            icon: Icons.add_box_outlined,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSecaoIlhaBranca({
    required String titulo,
    required Widget conteudo,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipPath(
          clipper: RecorteNuvemInferior(),
          child: Container(
            height: 50,
            color: CoresApp.fundoCreme,
          ),
        ),
        Container(
          color: CoresApp.fundoCreme,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 12),
                child: Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: CoresApp.textoForte,
                    fontFamily: 'Serif',
                  ),
                ),
              ),
              conteudo,
              const SizedBox(height: 16),
            ],
          ),
        ),
        ClipPath(
          clipper: RecorteNuvemSuperior(),
          child: Container(
            height: 50,
            color: CoresApp.fundoCreme,
          ),
        ),
      ],
    );
  }

  Widget _buildCardsHorizontais(List<Widget> cards) {
    return SizedBox(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20, right: 6),
        children: cards,
      ),
    );
  }
}

class _BotaoIconeHeader extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _BotaoIconeHeader({required this.icon, required this.onTap});

  @override
  State<_BotaoIconeHeader> createState() => _BotaoIconeHeaderState();
}

class _BotaoIconeHeaderState extends State<_BotaoIconeHeader> {
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _hovering ? Colors.black.withOpacity(0.07) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            widget.icon,
            color: _hovering ? CoresApp.azulCard : CoresApp.textoForte,
            size: 28,
          ),
        ),
      ),
    );
  }
}