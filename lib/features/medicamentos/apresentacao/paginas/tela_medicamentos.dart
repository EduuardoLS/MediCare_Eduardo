import 'package:flutter/material.dart';
import '../../../../core/temas/cores_app.dart';
import '../../dados/medicamento.dart';
import '../componentes/cartao_medicamento.dart';
import 'tela_adicionar_medicamento.dart';
import '../../../agenda/apresentacao/componentes/recortes_nuvem.dart';

class GerenciarMedicamentosPage extends StatefulWidget {
  const GerenciarMedicamentosPage({super.key});

  @override
  State<GerenciarMedicamentosPage> createState() => _GerenciarMedicamentosPageState();
}

class _GerenciarMedicamentosPageState extends State<GerenciarMedicamentosPage> {
  final List<Medicamento> medicamentos = [
    Medicamento(
      corLateral: const Color(0xFF08C98E),
      medico: 'LUAN MORAES DA SILVA',
      especialidade: 'NUTROLOGO',
      crm: 'CRM-SE 4321',
      receita: '',
      medicamento: 'OZEMPIC',
    ),
    Medicamento(
      corLateral: const Color(0xFFC92323),
      medico: 'ANA LÚCIA DE NOBREGA',
      especialidade: 'CARDIOLOGISTA',
      crm: 'CRM-SE 9087',
      receita: '',
      medicamento: 'ENALAPRIL',
    ),
  ];

  Future<void> abrirTelaAdicionarMedicamento() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdicionarMedicamentoPage()),
    );
    if (resultado != null && resultado is Medicamento) {
      setState(() => medicamentos.add(resultado));
    }
  }

  Future<void> editarMedicamento(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdicionarMedicamentoPage(medicamentoExistente: medicamentos[index]),
      ),
    );
    if (resultado != null && resultado is Medicamento) {
      setState(() => medicamentos[index] = resultado);
    }
  }

  void excluirMedicamento(int index) {
    setState(() => medicamentos.removeAt(index));
  }

  void confirmarExclusao(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: CoresApp.branco,
          title: const Text('Excluir medicamento', style: TextStyle(color: CoresApp.textoForte)),
          content: const Text('Tem certeza que deseja excluir este medicamento?', style: TextStyle(color: CoresApp.textoSecundario)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: CoresApp.textoSecundario)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                excluirMedicamento(index);
              },
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

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
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: Column(
                      children: [
                        _buildSearchBar(),
                        _buildAddButton(),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                            itemCount: medicamentos.length,
                            itemBuilder: (context, index) {
                              final item = medicamentos[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: MedicamentoCard(
                                  corLateral: item.corLateral,
                                  medico: item.medico,
                                  especialidade: item.especialidade,
                                  crm: item.crm,
                                  receita: item.receita,
                                  medicamento: item.medicamento,
                                  onEditar: () => editarMedicamento(index),
                                  onExcluir: () => confirmarExclusao(index),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          child: ClipPath(
            clipper: RecorteNuvemSuperior(),
            child: Container(
              height: 120,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 35),
              color: CoresApp.branco,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_none, size: 28, color: CoresApp.textoForte),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, size: 28, color: CoresApp.textoForte),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: CoresApp.branco,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'GERENCIAR MEDICAMENTOS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: CoresApp.textoForte,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      height: 48,
      decoration: BoxDecoration(
        color: CoresApp.branco,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        children: [
          SizedBox(width: 16),
          Icon(Icons.search, size: 24, color: CoresApp.textoSecundario),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Buscar medicamento...',
              style: TextStyle(color: CoresApp.textoSecundario, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 14, top: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: abrirTelaAdicionarMedicamento,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: CoresApp.branco,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.add, size: 28, color: CoresApp.textoForte),
          ),
        ),
      ),
    );
  }
}