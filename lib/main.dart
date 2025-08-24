import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PageAccueil(),
    );
  }
}

// Page d'accueil
class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.pink,
        // Title
        title: Text('Magazine Infos', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        // Leading
        leading: IconButton(
          onPressed: () {},
          icon: Icon(color: Colors.white, Icons.menu),
        ),
        // Action
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(color: Colors.white, Icons.search),
          ),
        ],
      ),
      // Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/magazin-infos.jpg",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            PartieTitre(),
            PartieText(),
            PartieIcone(),
            PartieRubrique(),
          ],
        ),
      ),
    );
  }
}

// Partie titre
class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Bienvenue au magazine infos",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "Votre magazine Numérique, votre source d'inspiration",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// Partie texte
class PartieText extends StatelessWidget {
  const PartieText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Text(
        "Magazine infos numérique est bien plus qu'un simple magazine d'informations. C'est votre passerelle vers le monde, une source inestimable de connaissance et d'actualités soigneusement sélectionnées pour vous éclairer sur les enjeux mondiaux, la culture, la science et voir même le divertissement (le jeux).",
      ),
    );
  }
}

// Partie icone
class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIcone(Icons.phone, 'tel'),
        _buildIcone(Icons.mail, 'mail'),
        _buildIcone(Icons.send, 'Partage'),
      ],
    );
  }
}

Widget _buildIcone(IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 40, color: Colors.pink),
        SizedBox(height: 5),
        Text(text.toUpperCase(), style: TextStyle(color: Colors.pink)),
      ],
    ),
  );
}

// Partie rubrique
class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/image-papier.jpg",
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/image-a-la-une-papier-entete.jpg",
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
