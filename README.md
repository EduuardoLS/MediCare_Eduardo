# 🏥 MediCare
Aplicativo móvel de monitoramento médico desenvolvido em Flutter.


# 👥 Equipe

| Desenvolvedor | Responsabilidade |
| --- | --- |
| **Lucas Gravatá Portilho** | Telas e funcionalidades de Gerenciamento de Medicamentos |
| **Carlos Eduardo Lima Santos** | Telas e funcionalidades de Agenda Médica e Tela Inicial |
| **Enzo Gabriel de Araújo Soares** |Tela de cadastro e confirmar cadastro
| **Lucca Derlan Barreto Costa** | Tela de Login.
| **Davi Gabriel dos Santos Mota** | Tela buscar.


## 🚀 Como rodar o projeto

### Pré-requisitos
Certifique-se de ter instalado em sua máquina:
* **Flutter SDK** — versão `^3.10.8`
* **Dart SDK** — incluso por padrão no Flutter
* **VS Code** com a extensão oficial do Flutter instalada
* Um emulador Android/iOS configurado ou um dispositivo físico conectado em modo de depuração USB

### Verificar ambiente
```bash
flutter doctor
```
Todos os itens devem estar com ✅ antes de continuar.

### Passo a passo
```bash
# 1. Clone o repositório
git clone [https://github.com/seu-usuario/medicare.git](https://github.com/seu-usuario/medicare.git)
cd medicare

# 2. Instale as dependências
flutter pub get

# 3. Rode o app
flutter run
```

Para rodar em um dispositivo específico:
```bash
flutter devices          # lista os dispositivos disponíveis
flutter run -d <id>      # roda no dispositivo desejado
```

---

## 📁 Estrutura de Pastas

```text
medicare/
│
├── assets/
│   └── images/            ← imagens e ícones do app (PNG, SVG)
│
├── lib/
│   ├── main.dart          ← ponto de entrada do app
│   │
│   ├── core/              ← recursos globais compartilhados por todas as features
│   │   └── temas/
│   │       └── cores_app.dart     ← paleta de cores e gradientes do app
│   │
│   └── features/          ← cada funcionalidade vive na sua própria pasta
│       │
│       ├── agenda/                ← módulo da agenda médica (Exemplo de feature)
│       │   ├── dados/
│       │   │   └── consulta_medica.dart      ← modelo de dados (classe)
│       │   └── apresentacao/
│       │       ├── paginas/
│       │       │   └── tela_agenda_medica.dart   ← tela principal
│       │       └── componentes/
│       │           ├── cartao_consulta.dart       ← widget do card
│       │           └── recortes_nuvem.dart        ← clippers das nuvens
│
├── pubspec.yaml           ← dependências e assets declarados aqui
└── README.md
```

---

## 🗂️ Regras da estrutura

| Pasta | O que colocar |
| --- | --- |
| `core/temas/` | Cores, tipografia, temas globais — usados por todo o app |
| `features/<nome>/dados/` | Classes de modelo (ex: ConsultaMedica, Medicamento) |
| `features/<nome>/apresentacao/paginas/` | Telas completas (StatefulWidget principal) |
| `features/<nome>/apresentacao/componentes/` | Widgets menores reutilizados dentro da feature |
| `assets/images/` | Imagens .png, .jpg, .svg — declarar também no pubspec.yaml |

> **Regra geral:** cada desenvolvedor trabalha dentro da sua própria pasta em `features/`. Qualquer coisa que precise ser compartilhada entre features vai em `core/`.

---

## 🎨 Cores do app

Todas as cores estão centralizadas em `lib/core/temas/cores_app.dart`.
Nunca use cores hardcoded — sempre referencie via `CoresApp`:

```dart
// ✅ Correto
color: CoresApp.cianoPrincipal

// ❌ Errado
color: Color(0xFF00E5FF)
```

| Token | Cor | Uso |
| --- | --- | --- |
| `cianoPrincipal` | `#00E5FF` | Cor principal do app |
| `cianoClaro` | `#CCF7FF` | Topo do gradiente de fundo |
| `azulCard` | `#0099BB` | Barra lateral dos cards |
| `fundoCreme` | `#F9F9F7` | Background do cabeçalho e rodapé |
| `textoForte` | `black87` | Títulos e textos primários |
| `textoSecundario` | `black54` | Subtítulos e textos de apoio |

---

## 📦 Adicionando assets (imagens)

Coloque o arquivo em `assets/images/`
Declare no `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

Rode `flutter pub get`
Use no código:

```dart
Image.asset('assets/images/nome_do_arquivo.png')
```

---

## 🐛 Problemas comuns

**`flutter pub get` falhando no `pubspec.yaml`** Verifique a indentação e o espaço após o `-` nos assets:

```yaml
# ✅ Correto
assets:
  - assets/images/

# ❌ Errado
assets:
  -assets/images
```

**App não encontra a imagem em runtime** Confirme que o arquivo está em `assets/images/` e que o `pubspec.yaml` foi salvo antes de rodar `flutter pub get`.
