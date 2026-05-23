import 'package:flutter/material.dart';
import '../../../../core/temas/cores_app.dart';
import '../../../agenda/apresentacao/componentes/recortes_nuvem.dart';
import '../../../agenda/apresentacao/paginas/tela_agenda_medica.dart';
import '../../../medicamentos/apresentacao/paginas/tela_medicamentos.dart';

// Importações dos componentes recém-criados
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
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipPath(
                clipper: RecorteNuvemInferior(),
                child: Container(
                  height: 100,
                  color: CoresApp.branco,
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const BannerDestaque(),
                    _buildNavegacaoPrincipal(context),
                    _buildSecaoFavoritos(),
                    _buildSecaoFuncionalidades(),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ClipPath(
      clipper: RecorteNuvemSuperior(),
      child: Container(
        height: 120,
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 35),
        color: CoresApp.branco,
        child: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 50),
            const Spacer(),
            const Icon(Icons.notification_add_outlined, size: 28, color: CoresApp.textoForte),
          ],
        ),
      ),
    );
  }

  Widget _buildNavegacaoPrincipal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BotaoNavegacaoHome(
            icon: Icons.assignment, 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaAgendaMedica())),
          ),
          BotaoNavegacaoHome(
            icon: Icons.search, 
            onTap: () {},
          ),
          BotaoNavegacaoHome(
            icon: Icons.medication, 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GerenciarMedicamentosPage())),
          ),
          BotaoNavegacaoHome(
            icon: Icons.add_box, 
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSecaoFavoritos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text('FAVORITOS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: CoresApp.textoForte)),
        ),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            children: const [
              CartaoHorizontal(label: 'PRONTUÁRIO', imgPath: 'assets/images/card_prontuario.png'),
              // Adicione mais cartões se necessário
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecaoFuncionalidades() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text('FUNCIONALIDADES', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: CoresApp.textoForte)),
        ),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            children: const [
              CartaoHorizontal(label: 'AGENDAMENTO', imgPath: 'assets/images/card_agendamento.png'),
              CartaoHorizontal(label: 'CONSULTAS', imgPath: 'assets/images/card_consultas.png'), // Exemplo de um novo cartão
            ],
          ),
        ),
      ],
    );
  }
}