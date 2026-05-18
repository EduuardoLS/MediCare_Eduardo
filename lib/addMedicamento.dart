// ignore: file_names
import 'package:flutter/material.dart';

class AdicionarMedicamentoPage extends StatefulWidget {
  final Medicamento? medicamentoExistente;

  const AdicionarMedicamentoPage({
    super.key,
    this.medicamentoExistente,
  });

  @override
  State<AdicionarMedicamentoPage> createState() =>
      _AdicionarMedicamentoPageState();
}

class _AdicionarMedicamentoPageState extends State<AdicionarMedicamentoPage> {
  final TextEditingController medicoController = TextEditingController();
  final TextEditingController especialidadeController = TextEditingController();
  final TextEditingController crmController = TextEditingController();
  final TextEditingController receitaController = TextEditingController();
  final TextEditingController medicamentoController = TextEditingController();

  Color corSelecionada = const Color(0xFF08C98E);

  @override
  void initState() {
    super.initState();

    if (widget.medicamentoExistente != null) {
      final item = widget.medicamentoExistente!;

      medicoController.text = item.medico;
      especialidadeController.text = item.especialidade;
      crmController.text = item.crm;
      receitaController.text = item.receita;
      medicamentoController.text = item.medicamento;
      corSelecionada = item.corLateral;
    }
  }

  void salvarMedicamento() {
    if (medicoController.text.isEmpty ||
        especialidadeController.text.isEmpty ||
        crmController.text.isEmpty ||
        receitaController.text.isEmpty ||
        medicamentoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos'),
        ),
      );
      return;
    }

    final medicamentoSalvo = Medicamento(
      corLateral: corSelecionada,
      medico: medicoController.text,
      especialidade: especialidadeController.text,
      crm: crmController.text,
      receita: receitaController.text,
      medicamento: medicamentoController.text,
    );

    Navigator.pop(context, medicamentoSalvo);
  }

  @override
  void dispose() {
    medicoController.dispose();
    especialidadeController.dispose();
    crmController.dispose();
    receitaController.dispose();
    medicamentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool editando = widget.medicamentoExistente != null;

    return Scaffold(
      backgroundColor: const Color(0xFF04CFCF),
      appBar: AppBar(
        title: Text(editando ? 'Editar Medicamento' : 'Adicionar Medicamento'),
        backgroundColor: const Color(0xFF04CFCF),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _campoTexto(
              controller: medicoController,
              label: 'Nome do médico',
            ),

            const SizedBox(height: 12),

            _campoTexto(
              controller: especialidadeController,
              label: 'Especialidade',
            ),

            const SizedBox(height: 12),

            _campoTexto(
              controller: crmController,
              label: 'CRM / RQE',
            ),

            const SizedBox(height: 12),

            _campoTexto(
              controller: medicamentoController,
              label: 'Nome do medicamento',
            ),

            const SizedBox(height: 12),

            _campoTexto(
              controller: receitaController,
              label: 'Receita médica',
              maxLines: 4,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Text(
                  'Cor lateral:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(width: 14),

                _botaoCor(const Color(0xFF08C98E)),
                _botaoCor(const Color(0xFFC92323)),
                _botaoCor(Colors.blue),
                _botaoCor(Colors.orange),
              ],
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: salvarMedicamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF7F5EF),
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  editando ? 'Salvar alterações' : 'Salvar medicamento',
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoTexto({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF7F5EF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _botaoCor(Color cor) {
    final bool selecionada = corSelecionada == cor;

    return GestureDetector(
      onTap: () {
        setState(() {
          corSelecionada = cor;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: cor,
          shape: BoxShape.circle,
          border: Border.all(
            color: selecionada ? Colors.black : Colors.transparent,
            width: 3,
          ),
        ),
      ),
    );
  }
}

class Medicamento {
  final Color corLateral;
  final String medico;
  final String especialidade;
  final String crm;
  final String receita;
  final String medicamento;

  Medicamento({
    required this.corLateral,
    required this.medico,
    required this.especialidade,
    required this.crm,
    required this.receita,
    required this.medicamento,
  });
}