// Fichier: lib/main.dart
import 'package:activite_4/components/appbar.dart';
import 'package:activite_4/components/drawer.dart';
import 'package:flutter/material.dart';

// Page d'accueil
class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // AppBar
      appBar: MyAppBar(title: 'Magazine Infos'),
      // Drawer
      drawer: MyDrawer(),
      // Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage("assets/images/magazin-infos.jpg"),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            PartieTitre(),
            PartieText(),
            PartieIcone(),
            SizedBox(height: 20), // Ajout d'un espacement
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _IconeColumn(icon: Icons.phone, text: 'Tel'),
          _IconeColumn(icon: Icons.mail, text: 'Mail'),
          _IconeColumn(icon: Icons.share, text: 'Partage'),
        ],
      ),
    );
  }
}

// Widget pour les colonnes d'icônes
class _IconeColumn extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconeColumn({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 40, color: Colors.pink),
        const SizedBox(height: 5),
        Text(text.toUpperCase(), style: const TextStyle(color: Colors.pink)),
      ],
    );
  }
}

// Partie rubrique
class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
