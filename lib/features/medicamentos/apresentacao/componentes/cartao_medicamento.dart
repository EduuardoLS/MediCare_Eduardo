import 'package:flutter/material.dart';

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
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            decoration: BoxDecoration(
              color: corLateral,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MÉDICO(A): $medico',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$especialidade | $crm',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.notifications_none, size: 22, color: Colors.orange),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'MEDICAMENTO: $medicamento',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: onEditar,
                            child: const Icon(Icons.edit, size: 20, color: Colors.black87),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: onExcluir,
                            child: const Icon(Icons.delete_outline, size: 22, color: Colors.black87),
                          ),
                        ],
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