import 'package:flutter/material.dart';

class telaBuscar extends StatefulWidget {
  const telaBuscar({super.key});

  @override
  State<telaBuscar> createState() => _telaBuscarState();
}

class _telaBuscarState extends State<telaBuscar> {
  String filtroSelecionado = "DOR";
  String remedioSelecionado = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1ED),

      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF00D9E6),
              ),
              child: Text(
                "MENU",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.medication),
              title: Text("Medicamentos"),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Favoritos"),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Lembretes"),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 230,
                  width: double.infinity,
                  color: const Color(0xFF00D9E6),
                ),

                // NUVEM CERTA
                Positioned(
                  top: -85,
                  left: -20,
                  right: -20,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      9,
                      (index) => Container(
                        width: 110,
                        height: 110,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF4F1ED),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),

                  child: Column(
                    children: [
                      // TOPO
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          // LOGO
                          Container(
                            width: 70,
                            height: 70,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                              color: Colors.white,
                            ),

                            child: ClipOval(
                              child: Image.asset(
                                'assets/Logo (1).png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // SINO
                          Stack(
                            children: [
                              const Icon(
                                Icons.notifications,
                                size: 40,
                                color: Colors.black,
                              ),

                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 18,
                                  height: 18,

                                  decoration:
                                      const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),

                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 35),

                      // VOLTAR
                      Row(
                        children: const [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 40,
                            color: Colors.black,
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // ABAS
                      Row(
                        children: [
                          abaWidget(
                            texto: "BUSCAR",
                            ativo: true,
                          ),

                          abaWidget(
                            texto: "FAVORITOS",
                            ativo: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // PESQUISA
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Container(
                height: 72,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    const SizedBox(width: 14),

                    Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context)
                                .openDrawer();
                          },

                          child: Container(
                            width: 60,
                            height: 60,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(
                                      16),

                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.black12,
                                  blurRadius: 6,
                                ),
                              ],
                            ),

                            child: const Icon(
                              Icons.menu,
                              size: 36,
                            ),
                          ),
                        );
                      },
                    ),

                    const Spacer(),

                    const Icon(
                      Icons.search,
                      size: 52,
                    ),

                    const SizedBox(width: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // FILTROS
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [
                  filtroWidget("DOR"),
                  filtroWidget("VITAMINA"),
                  filtroWidget("CARDÍACO"),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // LISTA
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                children: [
                  remedioCard(
                    nome: "CARDALI",
                    horario: "14:00",
                    imagem:
                        "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=1200&auto=format&fit=crop",
                  ),

                  remedioCard(
                    nome: "MEBENDAZOL",
                    horario: "18:00",
                    imagem:
                        "https://images.unsplash.com/photo-1587854692152-cbe660dbde88?q=80&w=1200&auto=format&fit=crop",
                  ),

                  remedioCard(
                    nome: "SÍBUS",
                    horario: "22:00",
                    imagem:
                        "https://images.unsplash.com/photo-1471864190281-a93a3070b6de?q=80&w=1200&auto=format&fit=crop",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ABAS
  Widget abaWidget({
    required String texto,
    required bool ativo,
  }) {
    return Expanded(
      child: Container(
        height: 70,

        decoration: BoxDecoration(
          color: ativo
              ? const Color(0xFF006E75)
              : const Color(0xFF00C8D6),

          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
                ativo ? 18 : 0),
            topRight: Radius.circular(
                !ativo ? 18 : 0),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Center(
          child: Text(
            texto,

            style: TextStyle(
              color: ativo
                  ? Colors.white
                  : Colors.white70,
              fontSize: 22,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  // FILTROS
  Widget filtroWidget(String texto) {
    bool ativo =
        filtroSelecionado == texto;

    return GestureDetector(
      onTap: () {
        setState(() {
          filtroSelecionado = texto;
        });
      },

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 250),

        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color: ativo
              ? const Color(0xFF008D95)
              : Colors.white,

          borderRadius:
              BorderRadius.circular(40),

          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            ),
          ],
        ),

        child: Text(
          texto,

          style: TextStyle(
            color:
                ativo ? Colors.white : Colors.grey,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  // CARD
  Widget remedioCard({
    required String nome,
    required String horario,
    required String imagem,
  }) {
    bool ativo =
        remedioSelecionado == nome;

    return GestureDetector(
      onTap: () {
        setState(() {
          remedioSelecionado = nome;
        });
      },

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 250),

        margin:
            const EdgeInsets.only(bottom: 22),

        height: 170,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(24),

          border: ativo
              ? Border.all(
                  color:
                      const Color(0xFF00AEB8),
                  width: 3,
                )
              : null,

          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft:
                    Radius.circular(24),
              ),

              child: Image.network(
                imagem,
                width: 170,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            nome,

                            style:
                                const TextStyle(
                              fontSize: 30,
                              fontWeight:
                                  FontWeight.w300,
                            ),
                          ),
                        ),

                        Icon(
                          ativo
                              ? Icons.favorite
                              : Icons
                                  .notifications_none,
                          size: 42,
                          color: ativo
                              ? Colors.red
                              : Colors.black,
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "OBS: NENHUMA",

                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),

                    const Spacer(),

                    Align(
                      alignment:
                          Alignment.bottomRight,

                      child: Text(
                        "HORÁRIO: $horario",

                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}