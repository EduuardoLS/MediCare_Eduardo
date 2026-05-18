import 'package:flutter/material.dart';
import 'screens/cadastro_screen.dart';

void main() {
  runApp(const MedicareApp());
}

class MedicareApp extends StatelessWidget {
  const MedicareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Serif',
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Paleta de cores extraída do design
  static const Color cyanBackground = Color(0xFF26D7D9);
  static const Color cyanLight = Color(0xFF4FE0E2);
  static const Color cloudWhite = Color(0xFFF5F5F0);
  static const Color buttonWhite = Color(0xFFFAF6E7);
  static const Color textDark = Color(0xFF2C2C2C);
  static const Color grassDarkGreen = Color(0xFF2E7D32);
  static const Color grassMidGreen = Color(0xFF388E3C);
  static const Color grassLightGreen = Color(0xFF66BB6A);
  static const Color bushGreen = Color(0xFF7CB342);
  static const Color houseRoof = Color(0xFF5D2E1F);
  static const Color houseWall = Color(0xFFB8D957);
  static const Color houseDoor = Color(0xFF8B4513);
  static const Color chimneyRed = Color(0xFFB85450);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com gradiente azul ciano
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [cyanLight, cyanBackground],
              ),
            ),
          ),

          // Nuvens no topo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 90),
              painter: CloudsPainter(),
            ),
          ),

          // Colinas, casa e arbustos na parte inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 260),
              painter: LandscapePainter(),
            ),
          ),

          // Conteúdo principal
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Logo circular com pomba
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: cloudWhite,
                    shape: BoxShape.circle,
                    border: Border.all(color: textDark, width: 2),
                  ),
                  child: CustomPaint(
                    painter: DovePainter(),
                  ),
                ),

                const SizedBox(height: 12),

                // Título MEDICARE
                const Text(
                  'MEDICARE',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w400,
                    color: textDark,
                    letterSpacing: 2,
                    fontFamily: 'Serif',
                  ),
                ),

                const Spacer(),

                // Botões
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      _buildButton(
                        label: 'ENTRAR',
                        onPressed: () {
                          // Ação do botão Entrar
                        },
                      ),
                      const SizedBox(height: 14),
                      _buildButton(
                        label: 'CADASTRAR',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CadastroScreen(),
                            )
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonWhite,
          foregroundColor: textDark,
          elevation: 2,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
            color: textDark,
            fontFamily: 'Serif',
          ),
        ),
      ),
    );
  }
}

// ============================================
// PAINTER: Nuvens onduladas no topo
// ============================================
class CloudsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = LoginScreen.cloudWhite
      ..style = PaintingStyle.fill;

    final outline = Paint()
      ..color = LoginScreen.textDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.55);

    // Ondulações da nuvem
    final segments = 7;
    final segmentWidth = size.width / segments;
    for (int i = 0; i < segments; i++) {
      final startX = i * segmentWidth;
      final controlX = startX + segmentWidth / 2;
      final endX = (i + 1) * segmentWidth;
      final isUp = i % 2 == 0;
      path.quadraticBezierTo(
        controlX,
        isUp ? size.height * 0.95 : size.height * 0.30,
        endX,
        size.height * 0.55,
      );
    }

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);

    // Linha de contorno apenas na parte ondulada inferior
    final outlinePath = Path();
    outlinePath.moveTo(0, size.height * 0.55);
    for (int i = 0; i < segments; i++) {
      final startX = i * segmentWidth;
      final controlX = startX + segmentWidth / 2;
      final endX = (i + 1) * segmentWidth;
      final isUp = i % 2 == 0;
      outlinePath.quadraticBezierTo(
        controlX,
        isUp ? size.height * 0.95 : size.height * 0.30,
        endX,
        size.height * 0.55,
      );
    }
    canvas.drawPath(outlinePath, outline);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================
// PAINTER: Pomba dentro do círculo do logo
// ============================================
class DovePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bodyPaint = Paint()
      ..color = LoginScreen.cloudWhite
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = LoginScreen.textDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Corpo da pomba (forma oval)
    final bodyPath = Path();
    bodyPath.moveTo(cx - 25, cy + 8);
    bodyPath.quadraticBezierTo(cx - 30, cy - 5, cx - 15, cy - 12);
    bodyPath.quadraticBezierTo(cx, cy - 18, cx + 18, cy - 10);
    bodyPath.quadraticBezierTo(cx + 28, cy - 3, cx + 25, cy + 5);
    bodyPath.quadraticBezierTo(cx + 15, cy + 12, cx, cy + 13);
    bodyPath.quadraticBezierTo(cx - 18, cy + 14, cx - 25, cy + 8);
    bodyPath.close();

    canvas.drawPath(bodyPath, bodyPaint);
    canvas.drawPath(bodyPath, strokePaint);

    // Asa (curva interna)
    final wingPath = Path();
    wingPath.moveTo(cx - 10, cy - 8);
    wingPath.quadraticBezierTo(cx, cy + 2, cx + 18, cy - 2);
    canvas.drawPath(wingPath, strokePaint);

    // Cabeça (pequeno círculo destacado)
    canvas.drawCircle(Offset(cx + 20, cy - 8), 5, bodyPaint);
    canvas.drawCircle(Offset(cx + 20, cy - 8), 5, strokePaint);

    // Bico
    final beakPath = Path();
    beakPath.moveTo(cx + 24, cy - 9);
    beakPath.lineTo(cx + 30, cy - 7);
    beakPath.lineTo(cx + 24, cy - 5);
    beakPath.close();
    canvas.drawPath(beakPath, strokePaint..style = PaintingStyle.stroke);

    // Olho
    final eyePaint = Paint()..color = LoginScreen.textDark;
    canvas.drawCircle(Offset(cx + 21, cy - 9), 1.2, eyePaint);

    // Cauda
    final tailPath = Path();
    tailPath.moveTo(cx - 22, cy + 2);
    tailPath.lineTo(cx - 32, cy - 2);
    tailPath.lineTo(cx - 32, cy + 4);
    tailPath.lineTo(cx - 22, cy + 8);
    tailPath.close();
    canvas.drawPath(tailPath, bodyPaint);
    canvas.drawPath(tailPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================
// PAINTER: Paisagem (colinas, casa, arbustos)
// ============================================
class LandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Colina de trás (mais clara)
    final hillBackPaint = Paint()..color = LoginScreen.grassMidGreen;
    final hillBackPath = Path();
    hillBackPath.moveTo(0, size.height * 0.55);
    hillBackPath.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.25,
      size.width * 0.6,
      size.height * 0.45,
    );
    hillBackPath.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.60,
      size.width,
      size.height * 0.40,
    );
    hillBackPath.lineTo(size.width, size.height);
    hillBackPath.lineTo(0, size.height);
    hillBackPath.close();
    canvas.drawPath(hillBackPath, hillBackPaint);

    // Colina da frente (mais escura)
    final hillFrontPaint = Paint()..color = LoginScreen.grassDarkGreen;
    final hillFrontPath = Path();
    hillFrontPath.moveTo(0, size.height * 0.75);
    hillFrontPath.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.55,
      size.width * 0.55,
      size.height * 0.70,
    );
    hillFrontPath.quadraticBezierTo(
      size.width * 0.80,
      size.height * 0.85,
      size.width,
      size.height * 0.70,
    );
    hillFrontPath.lineTo(size.width, size.height);
    hillFrontPath.lineTo(0, size.height);
    hillFrontPath.close();
    canvas.drawPath(hillFrontPath, hillFrontPaint);

    // Casa
    _drawHouse(canvas, size);

    // Arbustos
    _drawBush(canvas, size.width * 0.30, size.height * 0.78, 18);
    _drawBush(canvas, size.width * 0.45, size.height * 0.82, 22);
  }

  void _drawHouse(Canvas canvas, Size size) {
    final houseX = size.width * 0.25;
    final houseY = size.height * 0.45;

    final strokePaint = Paint()
      ..color = LoginScreen.textDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Parede da casa
    final wallPaint = Paint()..color = LoginScreen.houseWall;
    final wallRect = Rect.fromLTWH(houseX - 25, houseY + 5, 50, 40);
    canvas.drawRect(wallRect, wallPaint);
    canvas.drawRect(wallRect, strokePaint);

    // Telhado
    final roofPaint = Paint()..color = LoginScreen.houseRoof;
    final roofPath = Path();
    roofPath.moveTo(houseX - 32, houseY + 8);
    roofPath.lineTo(houseX, houseY - 20);
    roofPath.lineTo(houseX + 32, houseY + 8);
    roofPath.close();
    canvas.drawPath(roofPath, roofPaint);
    canvas.drawPath(roofPath, strokePaint);

    // Chaminé
    final chimneyPaint = Paint()..color = LoginScreen.chimneyRed;
    final chimneyRect = Rect.fromLTWH(houseX - 18, houseY - 18, 8, 16);
    canvas.drawRect(chimneyRect, chimneyPaint);
    canvas.drawRect(chimneyRect, strokePaint);

    // Tijolos da chaminé (linhas)
    canvas.drawLine(
      Offset(houseX - 18, houseY - 13),
      Offset(houseX - 10, houseY - 13),
      strokePaint,
    );
    canvas.drawLine(
      Offset(houseX - 14, houseY - 18),
      Offset(houseX - 14, houseY - 13),
      strokePaint,
    );
    canvas.drawLine(
      Offset(houseX - 14, houseY - 8),
      Offset(houseX - 14, houseY - 2),
      strokePaint,
    );

    // Fumaça
    final smokePaint = Paint()
      ..color = LoginScreen.cloudWhite.withOpacity(0.9)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(houseX - 14, houseY - 24), 4, smokePaint);
    canvas.drawCircle(Offset(houseX - 18, houseY - 30), 3.5, smokePaint);
    canvas.drawCircle(Offset(houseX - 12, houseY - 35), 3, smokePaint);

    canvas.drawCircle(Offset(houseX - 14, houseY - 24), 4, strokePaint);
    canvas.drawCircle(Offset(houseX - 18, houseY - 30), 3.5, strokePaint);
    canvas.drawCircle(Offset(houseX - 12, houseY - 35), 3, strokePaint);

    // Porta
    final doorPaint = Paint()..color = LoginScreen.houseDoor;
    final doorRect = Rect.fromLTWH(houseX - 18, houseY + 25, 10, 20);
    canvas.drawRect(doorRect, doorPaint);
    canvas.drawRect(doorRect, strokePaint);

    // Maçaneta
    canvas.drawCircle(
      Offset(houseX - 11, houseY + 35),
      1,
      Paint()..color = LoginScreen.textDark,
    );

    // Janela
    final windowPaint = Paint()..color = LoginScreen.cloudWhite;
    final windowRect = Rect.fromLTWH(houseX + 2, houseY + 18, 14, 14);
    canvas.drawRect(windowRect, windowPaint);
    canvas.drawRect(windowRect, strokePaint);
    // Cruz da janela
    canvas.drawLine(
      Offset(houseX + 9, houseY + 18),
      Offset(houseX + 9, houseY + 32),
      strokePaint,
    );
    canvas.drawLine(
      Offset(houseX + 2, houseY + 25),
      Offset(houseX + 16, houseY + 25),
      strokePaint,
    );
  }

  void _drawBush(Canvas canvas, double cx, double cy, double radius) {
    final bushPaint = Paint()..color = LoginScreen.bushGreen;
    final strokePaint = Paint()
      ..color = LoginScreen.textDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    // Arbusto composto por 3 círculos sobrepostos
    final path = Path();
    path.addOval(Rect.fromCircle(center: Offset(cx - radius * 0.5, cy), radius: radius * 0.7));
    path.addOval(Rect.fromCircle(center: Offset(cx, cy - radius * 0.3), radius: radius * 0.8));
    path.addOval(Rect.fromCircle(center: Offset(cx + radius * 0.5, cy), radius: radius * 0.7));

    canvas.drawPath(path, bushPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}