import 'package:flutter/material.dart';

// ============================================
// PALETA DE CORES COMPARTILHADA
// ============================================
class AppColors {
  static const Color grassGreen = Color(0xFF2E7D32);
  static const Color grassDark = Color(0xFF1B5E20);
  static const Color soilBrown = Color(0xFF6B4226);
  static const Color soilLight = Color(0xFF8B5A2B);
  static const Color soilDark = Color(0xFF4A2C18);
  static const Color fieldGray = Color(0xFF9E9E9E);
  static const Color fieldGrayLight = Color(0xFFB0B0B0);
  static const Color inputGray = Color(0xFFC0C0C0);
  static const Color textWhite = Color(0xFFF5F5F0);
  static const Color textDark = Color(0xFF2C2C2C);
  static const Color buttonCream = Color(0xFFFAF6E7);
}

// ============================================
// TELA DE CADASTRO
// ============================================
class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _nascimentoController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo marrom com gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.soilLight, AppColors.soilBrown, AppColors.soilDark],
              ),
            ),
          ),

          // Topo verde com borda ondulada
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 160),
              painter: GrassTopPainter(),
            ),
          ),

          // Barra cinza inferior com ícones sociais
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomSocialBar(),
          ),

          // Conteúdo principal
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Título
                  const Text(
                    'CADASTRO',
                    style: TextStyle(
                      fontSize: 40,
                      color: AppColors.textWhite,
                      letterSpacing: 2,
                      fontFamily: 'Serif',
                    ),
                  ),

                  const SizedBox(height: 100),

                  // Campo NOME COMPLETO
                  _buildOrganicField(
                    label: 'NOME COMPLETO',
                    controller: _nomeController,
                    width: MediaQuery.of(context).size.width * 0.78,
                  ),

                  const SizedBox(height: 24),

                  // Linha com NASCIMENTO e CPF
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildOrganicField(
                          label: 'NASCIMENTO',
                          controller: _nascimentoController,
                          width: MediaQuery.of(context).size.width * 0.36,
                          hint: '  /  /',
                          keyboardType: TextInputType.datetime,
                        ),
                        _buildOrganicField(
                          label: 'CPF',
                          controller: _cpfController,
                          width: MediaQuery.of(context).size.width * 0.36,
                          hint: '   .   .   -',
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Campo E-MAIL
                  _buildOrganicField(
                    label: 'E-MAIL',
                    controller: _emailController,
                    width: MediaQuery.of(context).size.width * 0.78,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 50),

                  // Botão CADASTRAR
                  _buildOrganicButton(
                    label: 'CADASTRAR',
                    onPressed: () {
                      // Navega para tela de confirmação
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConfirmacaoScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 140),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget: campo de input no formato orgânico cinza
  Widget _buildOrganicField({
    required String label,
    required TextEditingController controller,
    required double width,
    String? hint,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      width: width,
      child: CustomPaint(
        painter: OrganicFieldPainter(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textWhite,
                  letterSpacing: 1,
                  fontFamily: 'Serif',
                ),
              ),
              const SizedBox(height: 4),
              // Retângulo exato para input
              Container(
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.inputGray,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.textDark, width: 0.8),
                ),
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textDark,
                    fontFamily: 'Serif',
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textDark,
                      fontFamily: 'Serif',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget: botão CADASTRAR no formato orgânico
  Widget _buildOrganicButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 160,
        height: 56,
        child: CustomPaint(
          painter: OrganicFieldPainter(),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textWhite,
                letterSpacing: 1.5,
                fontFamily: 'Serif',
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget: barra cinza inferior com ícones sociais
  Widget _buildBottomSocialBar() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: AppColors.fieldGray,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialIcon(child: _googleIcon()),
            _buildSocialIcon(child: _facebookIcon(), backgroundColor: const Color(0xFF1877F2)),
            _buildSocialIcon(child: _outlookIcon()),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon({required Widget child, Color backgroundColor = Colors.white}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }

  // Ícone Google (G colorido)
  Widget _googleIcon() {
    return const Text(
      'G',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4285F4),
        fontFamily: 'Sans',
      ),
    );
  }

  // Ícone Facebook (f branco em azul)
  Widget _facebookIcon() {
    return const Text(
      'f',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Sans',
        height: 1,
      ),
    );
  }

  // Ícone Outlook (O azul)
  Widget _outlookIcon() {
    return Container(
      width: 28,
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFF0078D4),
        borderRadius: BorderRadius.circular(3),
      ),
      child: const Center(
        child: Text(
          'O',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Sans',
          ),
        ),
      ),
    );
  }
}

// ============================================
// PAINTER: Topo verde com borda ondulada
// ============================================
class GrassTopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grassPaint = Paint()..color = AppColors.grassGreen;

    final shadowPaint = Paint()
      ..color = AppColors.soilDark.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.75);

    // Ondulações na parte inferior (estilo grama irregular)
    final segments = 9;
    final segmentWidth = size.width / segments;
    for (int i = segments; i > 0; i--) {
      final startX = i * segmentWidth;
      final controlX = startX - segmentWidth / 2;
      final endX = (i - 1) * segmentWidth;
      final isUp = i % 2 == 0;
      path.quadraticBezierTo(
        controlX,
        isUp ? size.height * 0.55 : size.height * 0.95,
        endX,
        size.height * 0.75,
      );
    }

    path.lineTo(0, 0);
    path.close();

    // Sombra abaixo da grama
    final shadowPath = Path.from(path);
    canvas.save();
    canvas.translate(0, 4);
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.restore();

    canvas.drawPath(path, grassPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================
// PAINTER: Forma orgânica cinza dos campos
// ============================================
class OrganicFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    final fillPaint = Paint()..color = AppColors.fieldGrayLight;

    // Forma orgânica com cantos arredondados irregulares
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Curvas Bézier criam o formato "blob" estilo pedra/folha
    path.moveTo(w * 0.08, h * 0.15);
    path.quadraticBezierTo(w * 0.15, 0, w * 0.30, h * 0.05);
    path.quadraticBezierTo(w * 0.55, h * 0.12, w * 0.75, h * 0.04);
    path.quadraticBezierTo(w * 0.92, 0, w * 0.97, h * 0.30);
    path.quadraticBezierTo(w, h * 0.55, w * 0.94, h * 0.85);
    path.quadraticBezierTo(w * 0.85, h, w * 0.65, h * 0.95);
    path.quadraticBezierTo(w * 0.40, h * 0.88, w * 0.20, h * 0.97);
    path.quadraticBezierTo(w * 0.03, h, 0, h * 0.65);
    path.quadraticBezierTo(w * -0.02, h * 0.35, w * 0.08, h * 0.15);
    path.close();

    // Desenha sombra com leve offset
    canvas.save();
    canvas.translate(2, 4);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================
// TELA DE CONFIRMAÇÃO DE CADASTRO
// ============================================
class ConfirmacaoScreen extends StatelessWidget {
  const ConfirmacaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo marrom com gradiente radial
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.2),
                radius: 1.2,
                colors: [AppColors.soilLight, AppColors.soilBrown, AppColors.soilDark],
                stops: [0.0, 0.6, 1.0],
              ),
            ),
          ),

          // Faixa cinza inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 130),
              painter: BottomGrayStripPainter(),
            ),
          ),

          // Conteúdo central
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 140),

                // Card grande "CADASTRO CONFIRMADO"
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.82,
                  height: 220,
                  child: CustomPaint(
                    painter: ConfirmationCardPainter(),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CADASTRO',
                            style: TextStyle(
                              fontSize: 32,
                              color: AppColors.textWhite,
                              letterSpacing: 2,
                              fontFamily: 'Serif',
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'CONFIRMADO',
                            style: TextStyle(
                              fontSize: 32,
                              color: AppColors.textWhite,
                              letterSpacing: 2,
                              fontFamily: 'Serif',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                // Botão ENTRAR
                SizedBox(
                  width: 200,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      // Volta para a tela inicial / login
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonCream,
                      foregroundColor: AppColors.textDark,
                      elevation: 3,
                      shadowColor: Colors.black38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text(
                      'ENTRAR',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1.5,
                        color: AppColors.textDark,
                        fontFamily: 'Serif',
                      ),
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================
// PAINTER: Card de confirmação (formato orgânico maior)
// ============================================
class ConfirmationCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final fillPaint = Paint()..color = AppColors.fieldGray;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Formato de "TV antiga" / blob retangular com cantos curvos
    path.moveTo(w * 0.05, h * 0.20);
    path.quadraticBezierTo(w * 0.08, h * 0.02, w * 0.25, h * 0.05);
    path.quadraticBezierTo(w * 0.50, h * 0.10, w * 0.75, h * 0.04);
    path.quadraticBezierTo(w * 0.92, 0, w * 0.97, h * 0.25);
    path.quadraticBezierTo(w, h * 0.50, w * 0.95, h * 0.80);
    path.quadraticBezierTo(w * 0.90, h * 0.99, w * 0.70, h * 0.96);
    path.quadraticBezierTo(w * 0.45, h * 0.90, w * 0.25, h * 0.97);
    path.quadraticBezierTo(w * 0.05, h, w * 0.02, h * 0.75);
    path.quadraticBezierTo(0, h * 0.45, w * 0.05, h * 0.20);
    path.close();

    canvas.save();
    canvas.translate(3, 6);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================
// PAINTER: Faixa cinza inferior da tela de confirmação
// ============================================
class BottomGrayStripPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()..color = AppColors.fieldGray;

    final path = Path();
    path.moveTo(0, size.height * 0.30);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.05,
      size.width * 0.50,
      size.height * 0.15,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.25,
      size.width,
      size.height * 0.10,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
