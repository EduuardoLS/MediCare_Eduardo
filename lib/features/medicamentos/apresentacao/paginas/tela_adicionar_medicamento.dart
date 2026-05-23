import 'package:flutter/material.dart';
import '../../../../core/temas/cores_app.dart';
import '../../dados/medicamento.dart';

class AdicionarMedicamentoPage extends StatefulWidget {
  final Medicamento? medicamentoExistente;

  const AdicionarMedicamentoPage({super.key, this.medicamentoExistente});

  @override
  State<AdicionarMedicamentoPage> createState() => _AdicionarMedicamentoPageState();
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
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    final medicamentoSalvo = Medicamento(
      corLateral: corSelecionada,
      medico: medicoController.text.toUpperCase(),
      especialidade: especialidadeController.text.toUpperCase(),
      crm: crmController.text.toUpperCase(),
      receita: receitaController.text.toUpperCase(),
      medicamento: medicamentoController.text.toUpperCase(),
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
      backgroundColor: CoresApp.fundoCreme,
      appBar: AppBar(
        title: Text(
          editando ? 'EDITAR MEDICAMENTO' : 'ADICIONAR MEDICAMENTO',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CoresApp.branco),
        ),
        backgroundColor: CoresApp.cianoPrincipal,
        foregroundColor: CoresApp.branco,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _campoTexto(controller: medicoController, label: 'NOME DO MÉDICO'),
            const SizedBox(height: 14),
            _campoTexto(controller: especialidadeController, label: 'ESPECIALIDADE'),
            const SizedBox(height: 14),
            _campoTexto(controller: crmController, label: 'CRM / RQE'),
            const SizedBox(height: 14),
            _campoTexto(controller: medicamentoController, label: 'NOME DO MEDICAMENTO'),
            const SizedBox(height: 14),
            _campoTexto(controller: receitaController, label: 'RECEITA MÉDICA', maxLines: 5),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('COR LATERAL:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CoresApp.textoForte)),
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
              height: 50,
              child: ElevatedButton(
                onPressed: salvarMedicamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoresApp.azulCard,
                  foregroundColor: CoresApp.branco,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  editando ? 'SALVAR ALTERAÇÕES' : 'SALVAR MEDICAMENTO',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoTexto({required TextEditingController controller, required String label, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: CoresApp.textoSecundario, fontSize: 13, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: CoresApp.branco,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: CoresApp.cianoPrincipal, width: 2),
        ),
      ),
    );
  }

  Widget _botaoCor(Color cor) {
    final bool selecionada = corSelecionada == cor;
    return GestureDetector(
      onTap: () => setState(() => corSelecionada = cor),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: cor,
          shape: BoxShape.circle,
          border: Border.all(
            color: selecionada ? CoresApp.textoForte : Colors.transparent,
            width: selecionada ? 3 : 1,
          ),
        ),
      ),
    );
  }
}