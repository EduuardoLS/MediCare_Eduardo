import 'package:flutter/material.dart';
import '../../../../core/temas/cores_app.dart';
import '../../../agenda/apresentacao/componentes/recortes_nuvem.dart';

class TelaBuscar extends StatefulWidget {
  const TelaBuscar({super.key});

  @override
  State<TelaBuscar> createState() => _TelaBuscarState();
}

class _TelaBuscarState extends State<TelaBuscar> {
  String _filtroSelecionado = "DOR";
  String _remedioSelecionado = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: CoresApp.gradienteBackground,
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  _buildHeaderNuvem(),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 100),
                      children: [
                        _buildBotoesEAbas(),
                        const SizedBox(height: 24),
                        _buildSearchBar(),
                        const SizedBox(height: 24),
                        _buildFiltros(),
                        const SizedBox(height: 24),
                        _buildListaMedicamentos(),
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: RecorteNuvemInferior(),
                  child: Container(
                    height: 80,
                    color: CoresApp.nuvemBranco,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderNuvem() {
    return ClipPath(
      clipper: RecorteNuvemSuperior(),
      child: Container(
        height: 120,
        width: double.infinity,
        color: CoresApp.nuvemBranco,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/Logo.png',
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
            Stack(
              children: [
                const Icon(
                  Icons.notifications_none,
                  size: 38,
                  color: CoresApp.textoForte,
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: CoresApp.textoForte,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBotoesEAbas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
          child: _BotaoVoltarHover(
            onTap: () => Navigator.pop(context),
          ),
        ),
        Row(
          children: [
            _buildAbaWidget(texto: "BUSCAR", ativo: true),
            _buildAbaWidget(texto: "FAVORITOS", ativo: false),
          ],
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: CoresApp.nuvemBranco,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: CoresApp.cianoPrincipal),
            child: Text(
              "MENU",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
              ),
            ),
          ),
          _buildDrawerItem(Icons.medication, "Medicamentos"),
          _buildDrawerItem(Icons.favorite, "Favoritos"),
          _buildDrawerItem(Icons.notifications, "Lembretes"),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: CoresApp.textoForte),
      title: Text(title, style: const TextStyle(fontFamily: 'Serif', fontSize: 16)),
      onTap: () {},
    );
  }

  Widget _buildAbaWidget({required String texto, required bool ativo}) {
    return Expanded(
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: ativo ? const Color(0xFF008D95) : CoresApp.cianoClaro,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            texto,
            style: TextStyle(
              color: ativo ? Colors.white : CoresApp.textoForte.withOpacity(0.6),
              fontSize: 18,
              fontWeight: FontWeight.w300,
              fontFamily: 'Serif',
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Container(
                    width: 45,
                    height: 45,
                    color: Colors.transparent,
                    child: const Icon(Icons.menu, size: 28, color: CoresApp.textoForte),
                  ),
                );
              },
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Buscar medicamento...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontFamily: 'Serif', color: Colors.grey, fontSize: 16),
                  ),
                ),
              ),
            ),
            const Icon(Icons.search, size: 32, color: CoresApp.textoForte),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltros() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFiltroWidget("DOR"),
          _buildFiltroWidget("VITAMINA"),
          _buildFiltroWidget("CARDÍACO"),
        ],
      ),
    );
  }

  Widget _buildFiltroWidget(String texto) {
    bool ativo = _filtroSelecionado == texto;

    return GestureDetector(
      onTap: () {
        setState(() {
          _filtroSelecionado = texto;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: ativo ? Border.all(color: const Color(0xFF008D95), width: 1.5) : null,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            ),
          ],
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: ativo ? const Color(0xFF008D95) : CoresApp.textoSecundario,
            fontSize: 14,
            fontFamily: 'Serif',
          ),
        ),
      ),
    );
  }

  Widget _buildListaMedicamentos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          _buildRemedioCard(
            nome: "CARDALI",
            horario: "14:00",
            imagem: "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=1200&auto=format&fit=crop",
          ),
          _buildRemedioCard(
            nome: "MEBENDAZOL",
            horario: "18:00",
            imagem: "https://images.unsplash.com/photo-1587854692152-cbe660dbde88?q=80&w=1200&auto=format&fit=crop",
          ),
          _buildRemedioCard(
            nome: "SÍBUS",
            horario: "22:00",
            imagem: "https://images.unsplash.com/photo-1471864190281-a93a3070b6de?q=80&w=1200&auto=format&fit=crop",
          ),
        ],
      ),
    );
  }

  Widget _buildRemedioCard({
    required String nome,
    required String horario,
    required String imagem,
  }) {
    bool ativo = _remedioSelecionado == nome;

    return GestureDetector(
      onTap: () {
        setState(() {
          _remedioSelecionado = nome;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 18),
        height: 125,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: ativo ? Border.all(color: const Color(0xFF008D95), width: 2) : null,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                imagem,
                width: 120,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            nome,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Serif',
                              color: CoresApp.textoForte,
                            ),
                          ),
                        ),
                        Icon(
                          ativo ? Icons.notifications_active : Icons.notifications_none,
                          size: 28,
                          color: ativo ? const Color(0xFF008D95) : CoresApp.textoForte,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "OBS: NENHUMA",
                      style: TextStyle(
                        fontSize: 13,
                        color: CoresApp.textoForte.withOpacity(0.6),
                        fontFamily: 'Serif',
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "HORÁRIO: $horario",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: CoresApp.textoForte,
                          fontFamily: 'Serif',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _BotaoVoltarHover extends StatefulWidget {
  final VoidCallback onTap;

  const _BotaoVoltarHover({required this.onTap});

  @override
  State<_BotaoVoltarHover> createState() => _BotaoVoltarHoverState();
}

class _BotaoVoltarHoverState extends State<_BotaoVoltarHover> {
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
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _hovering ? Colors.black.withOpacity(0.08) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 28, // Seta fiel à imagem
            color: CoresApp.textoForte,
          ),
        ),
      ),
    );
  }
}