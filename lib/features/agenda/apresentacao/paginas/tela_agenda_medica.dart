import 'package:flutter/material.dart';
import '../../../../core/temas/cores_app.dart';
import '../../dados/consulta_medica.dart';
import '../componentes/cartao_consulta.dart';
import '../componentes/recortes_nuvem.dart';

class TelaAgendaMedica extends StatefulWidget {
  const TelaAgendaMedica({Key? key}) : super(key: key);

  @override
  State<TelaAgendaMedica> createState() => _TelaAgendaMedicaState();
}

class _TelaAgendaMedicaState extends State<TelaAgendaMedica> {
  String diaSelecionado = 'SEG';
  String? filtroSelecionado;

  final List<String> diasDaSemana = ['DOM', 'SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB'];

  final List<ConsultaMedica> listaConsultas = [
    ConsultaMedica(
      nomeMedico: 'DR. PEDRO ANDRADE DOS SANTOS',
      especialidade: 'CARDIOLOGISTA',
      crmRqe: 'CRM-SE 1234 | RQE 5678',
      data: 'DATA: SEGUNDA 22/03/2026',
      horario: 'HORÁRIO: 14:00',
    ),
    ConsultaMedica(
      nomeMedico: 'DRA. AMANDA NICOLE DOS SANTOS',
      especialidade: 'DERMATOLOGISTA',
      crmRqe: 'CRM-SE 7865 | RQE 9023',
      data: 'DATA: QUINTA 22/03/2026',
      horario: 'HORÁRIO: 18:00',
    ),
    ConsultaMedica(
      nomeMedico: 'DR. ANDRE LUCAS BERENGER',
      especialidade: 'UROLOGISTA',
      crmRqe: 'CRM-SE 2245 | RQE 3113',
      data: 'DATA: QUARTA 12/07/2026',
      horario: 'HORÁRIO: 16:00',
    ),
  ];

  void _abrirDialogNovaConsulta() {
    final nomeCtrl    = TextEditingController();
    final espCtrl     = TextEditingController();
    final crmCtrl     = TextEditingController();
    final dataCtrl    = TextEditingController();
    final horarioCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Nova Consulta',
            style: TextStyle(fontWeight: FontWeight.w600, color: CoresApp.textoForte)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _campoTexto(nomeCtrl,    'Nome do Médico'),
              const SizedBox(height: 10),
              _campoTexto(espCtrl,     'Especialidade'),
              const SizedBox(height: 10),
              _campoTexto(crmCtrl,     'CRM | RQE'),
              const SizedBox(height: 10),
              _campoTexto(dataCtrl,    'Data (ex: SEGUNDA 22/03/2026)'),
              const SizedBox(height: 10),
              _campoTexto(horarioCtrl, 'Horário (ex: 14:00)'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar',
                style: TextStyle(color: CoresApp.textoSecundario)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CoresApp.cianoPrincipal,
              foregroundColor: CoresApp.textoForte,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              if (nomeCtrl.text.isNotEmpty) {
                setState(() {
                  listaConsultas.add(ConsultaMedica(
                    nomeMedico:    nomeCtrl.text.toUpperCase(),
                    especialidade: espCtrl.text.toUpperCase(),
                    crmRqe:        crmCtrl.text.toUpperCase(),
                    data:    'DATA: ${dataCtrl.text.toUpperCase()}',
                    horario: 'HORÁRIO: ${horarioCtrl.text}',
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  Widget _campoTexto(TextEditingController ctrl, String label) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(fontSize: 12, color: CoresApp.textoSecundario),
        border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(color: CoresApp.cianoPrincipal, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      style: const TextStyle(fontSize: 13),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirDialogNovaConsulta,
        backgroundColor: CoresApp.fundoCreme,
        foregroundColor: CoresApp.textoForte,
        elevation: 4,
        tooltip: 'Nova consulta',
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: CoresApp.gradienteBackground),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            children: [
              _construirCabecalhoNuvem(),
              Expanded(child: _construirCorpoPrincipal()),
              _construirRodapeNuvem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirCabecalhoNuvem() {
    final double statusBarH = MediaQuery.of(context).padding.top;
    const double brancaH = 155.0;
    const double zonaTituloH = 55.0;
    final double totalH = statusBarH + brancaH + zonaTituloH;

    return SizedBox(
      height: totalH,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: RecorteNuvemSuperior(),
              child: Container(
                height: statusBarH + brancaH,
                color: CoresApp.fundoCreme,
                padding: EdgeInsets.only(
                  top: statusBarH + 12,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _construirLogoPassaro(),
                    _BotaoIconeHover(
                      icon: Icons.notification_add_outlined,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Seta de voltar corrigida com mapeamento e efeito Hover
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _BotaoVoltarHover(
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  _construirTituloCabecalho(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirLogoPassaro() {
    return ClipOval(
      child: Image.asset(
        'assets/images/logo.png',
        width: 45,
        height: 45,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _construirTituloCabecalho() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: CoresApp.fundoCreme,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Text(
        'AGENDA MÉDICA',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          letterSpacing: 1.2,
          color: CoresApp.textoForte,
        ),
      ),
    );
  }

  Widget _construirCorpoPrincipal() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        _construirSeletorDiasDaSemana(),
        const SizedBox(height: 15),
        _construirFiltroSuspenso(),
        const SizedBox(height: 15),
        _construirListaConsultas(),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _construirSeletorDiasDaSemana() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: diasDaSemana.map((dia) {
        return _BotaoDia(
          dia: dia,
          estaSelecionado: diaSelecionado == dia,
          onTap: () => setState(() => diaSelecionado = dia),
        );
      }).toList(),
    );
  }

  Widget _construirFiltroSuspenso() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 70,
        height: 35,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: CoresApp.branco,
          borderRadius: BorderRadius.circular(6),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: filtroSelecionado,
            icon: const Icon(Icons.arrow_drop_down,
                color: CoresApp.textoSecundario),
            isExpanded: true,
            onChanged: (v) => setState(() => filtroSelecionado = v),
            items: ['Opc 1', 'Opc 2'].map((v) {
              return DropdownMenuItem(
                value: v,
                child: Text(v, style: const TextStyle(fontSize: 12)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _construirListaConsultas() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listaConsultas.length,
      itemBuilder: (context, index) {
        final consulta = listaConsultas[index];
        return CartaoConsulta(
          consulta: consulta,
          aoAlternarNotificacao: () =>
              setState(() => consulta.alternarNotificacao()),
        );
      },
    );
  }

  Widget _construirRodapeNuvem() {
    return ClipPath(
      clipper: RecorteNuvemInferior(),
      child: Container(
        height: 80,
        color: CoresApp.fundoCreme,
      ),
    );
  }
}

// NOVO WIDGET: Botão de voltar com Hover e cursor de clique para a Web
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
      onExit:  (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _hovering ? Colors.black.withOpacity(0.08) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios_new, // Ícone atualizado e mais elegante
            color: _hovering ? CoresApp.cianoPrincipal : CoresApp.textoForte,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _BotaoDia extends StatefulWidget {
  final String dia;
  final bool estaSelecionado;
  final VoidCallback onTap;
  const _BotaoDia(
      {required this.dia,
      required this.estaSelecionado,
      required this.onTap});
  @override
  State<_BotaoDia> createState() => _BotaoDiaState();
}

class _BotaoDiaState extends State<_BotaoDia> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit:  (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _hovering && !widget.estaSelecionado
                ? CoresApp.branco.withOpacity(0.80)
                : CoresApp.branco,
            borderRadius: BorderRadius.circular(10),
            border: widget.estaSelecionado
                ? Border.all(color: CoresApp.textoForte, width: 1.5)
                : _hovering
                    ? Border.all(color: CoresApp.textoSecundario, width: 1)
                    : null,
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(_hovering ? 0.12 : 0.05),
                blurRadius: _hovering ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            widget.dia,
            style: TextStyle(
              fontSize: 12,
              fontWeight: widget.estaSelecionado
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: widget.estaSelecionado || _hovering
                  ? CoresApp.textoForte
                  : CoresApp.textoSecundario,
            ),
          ),
        ),
      ),
    );
  }
}

class _BotaoIconeHover extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _BotaoIconeHover({required this.icon, required this.onTap});
  @override
  State<_BotaoIconeHover> createState() => _BotaoIconeHoverState();
}

class _BotaoIconeHoverState extends State<_BotaoIconeHover> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit:  (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _hovering
                ? Colors.black.withOpacity(0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            widget.icon,
            color: _hovering
                ? CoresApp.cianoPrincipal
                : CoresApp.textoForte,
            size: 28,
          ),
        ),
      ),
    );
  }
}