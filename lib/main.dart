import 'package:flutter/material.dart';
// Certifique-se de que o caminho do import está correto de acordo com a sua estrutura
import 'features/home/apresentacao/paginas/tela_inicial.dart'; 

void main() {
  runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        useMaterial3: true,
      ),
      // Aqui nós definimos a nova tela inicial como a primeira tela do app
      home: const TelaInicial(),
    );
  }
}