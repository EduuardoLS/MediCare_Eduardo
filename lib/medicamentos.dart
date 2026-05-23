import 'package:flutter/material.dart';
import 'package:medicare/addMedicamento.dart';

class GerenciarMedicamentosPage extends StatefulWidget {
  const GerenciarMedicamentosPage({super.key});

  @override
  State<GerenciarMedicamentosPage> createState() =>
      _GerenciarMedicamentosPageState();
}

class _GerenciarMedicamentosPageState extends State<GerenciarMedicamentosPage> {
  final List<Medicamento> medicamentos = [
    Medicamento(
      corLateral: const Color(0xFF08C98E),
      medico: 'LUAN MORAES DA SILVA',
      especialidade: 'NUTROLOGO',
      crm: 'CRM-SE 4321 | RQE 7452',
      receita:
          'UTILIZAR 1 UNIDADE\nDE OZEMPIC DURANTE 3 MESES.\nAUMENTANDO A DOSAGEM EM 0.25MG\nDE 3 EM 3 SEMANAS',
      medicamento: 'OZEMPIC',
    ),
    Medicamento(
      corLateral: const Color(0xFFC92323),
      medico: 'ANA LÚCIA DE NOBREGA',
      especialidade: 'CARDIOLOGISTA',
      crm: 'CRM-SE 9087 | RQE 3242',
      receita: 'UTILIZAR ENALAPRIL\nDE 5MG DE 12 EM 12 HORAS DURANTE\n30 DIAS',
      medicamento: 'ENALAPRIL',
    ),
  ];

  Future<void> abrirTelaAdicionarMedicamento() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdicionarMedicamentoPage(),
      ),
    );

    if (resultado != null && resultado is Medicamento) {
      setState(() {
        medicamentos.add(resultado);
      });
    }
  }

  Future<void> editarMedicamento(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdicionarMedicamentoPage(
          medicamentoExistente: medicamentos[index],
        ),
      ),
    );

    if (resultado != null && resultado is Medicamento) {
      setState(() {
        medicamentos[index] = resultado;
      });
    }
  }

  void excluirMedicamento(int index) {
    setState(() {
      medicamentos.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Medicamento excluído'),
      ),
    );
  }

  void confirmarExclusao(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir medicamento'),
          content: const Text(
            'Tem certeza que deseja excluir este medicamento?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                excluirMedicamento(index);
              },
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF04CFCF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),

            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 14,
                      right: 16,
                      bottom: 18,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: abrirTelaAdicionarMedicamento,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F5EF),
                            border: Border.all(
                              color: Colors.black87,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 24,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 40),
                      itemCount: medicamentos.length,
                      itemBuilder: (context, index) {
                        final item = medicamentos[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: MedicamentoCard(
                            corLateral: item.corLateral,
                            medico: item.medico,
                            especialidade: item.especialidade,
                            crm: item.crm,
                            receita: item.receita,
                            medicamento: item.medicamento,
                            onEditar: () {
                              editarMedicamento(index);
                            },
                            onExcluir: () {
                              confirmarExclusao(index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            _buildBottomWave(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 170,
      width: double.infinity,
      color: const Color(0xFF04CFCF),
      child: Column(
        children: [
          Container(
            height: 92,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF7F5EF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomPaint(
                    size: const Size(48, 48),
                    painter: MedicineLogoPainter(),
                  ),
                  const Icon(
                    Icons.notification_add_outlined,
                    size: 27,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 22,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(width: 26),

                Expanded(
                  child: Container(
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F5EF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'GERENCIAR MEDICAMENTOS',
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 1.4,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 38,
      color: const Color(0xFFF7F5EF),
      child: const Row(
        children: [
          SizedBox(width: 18),
          Icon(
            Icons.menu,
            size: 22,
            color: Colors.black87,
          ),
          Spacer(),
          Icon(
            Icons.search,
            size: 26,
            color: Colors.black87,
          ),
          SizedBox(width: 14),
        ],
      ),
    );
  }

  Widget _buildBottomWave() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF7F5EF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
      ),
    );
  }
}

class MedicamentoCard extends StatelessWidget {
  final Color corLateral;
  final String medico;
  final String especialidade;
  final String crm;
  final String receita;
  final String medicamento;
  final VoidCallback onEditar;
  final VoidCallback onExcluir;

  const MedicamentoCard({
    super.key,
    required this.corLateral,
    required this.medico,
    required this.especialidade,
    required this.crm,
    required this.receita,
    required this.medicamento,
    required this.onEditar,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5EF),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            decoration: BoxDecoration(
              color: corLateral,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 14,
                top: 10,
                right: 8,
                bottom: 6,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'MÉDICO(A): $medico',
                          style: const TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.7,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.notifications_none,
                        size: 22,
                        color: Colors.black87,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Text(
                        especialidade,
                        style: const TextStyle(
                          fontSize: 10,
                          letterSpacing: 0.8,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(width: 24),

                      Expanded(
                        child: Text(
                          crm,
                          style: const TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.8,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'RECEITA MÉDICA: $receita',
                    style: const TextStyle(
                      fontSize: 10,
                      height: 1.05,
                      letterSpacing: 0.6,
                      color: Colors.black87,
                    ),
                  ),

                  const Spacer(),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'MEDICAMENTO: $medicamento',
                      style: const TextStyle(
                        fontSize: 10,
                        letterSpacing: 0.8,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: onEditar,
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.black87,
                        ),
                        tooltip: 'Editar',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),

                      const SizedBox(width: 16),

                      IconButton(
                        onPressed: onExcluir,
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 22,
                          color: Colors.red,
                        ),
                        tooltip: 'Excluir',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Rect rect = Rect.fromLTWH(
      4,
      4,
      size.width - 8,
      size.height - 8,
    );

    canvas.drawOval(rect, paint);

    canvas.drawLine(
      Offset(size.width * 0.30, size.height * 0.22),
      Offset(size.width * 0.72, size.height * 0.78),
      paint,
    );

    final Path path = Path()
      ..moveTo(size.width * 0.28, size.height * 0.24)
      ..quadraticBezierTo(
        size.width * 0.47,
        size.height * 0.38,
        size.width * 0.48,
        size.height * 0.55,
      )
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.73,
        size.width * 0.72,
        size.height * 0.78,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}