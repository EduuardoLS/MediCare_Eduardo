import 'package:flutter/material.dart';
import 'features/auth/apresentacao/paginas/tela_login.dart';

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
        useMaterial3: true,
        fontFamily: 'Serif',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const TelaLogin(),
    );
  }
}