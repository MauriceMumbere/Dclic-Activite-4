import 'package:flutter/material.dart';
import 'package:activite_4/services/db_redacteur.dart';
import 'package:activite_4/models/redacteur.dart';
import 'package:activite_4/screens/home_page.dart';
import 'package:activite_4/components/appbar.dart';
import 'package:email_validator/email_validator.dart';

class RedacteurPage extends StatefulWidget {
  const RedacteurPage({super.key});

  @override
  State<RedacteurPage> createState() => _RedacteurPageState();
}

class _RedacteurPageState extends State<RedacteurPage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<Redacteur> _redacteurs = [];

  @override
  void initState() {
    super.initState();
    _loadRedacteurs();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadRedacteurs() async {
    final data = await DBHelper.getRedacteurs();
    setState(() {
      _redacteurs = data;
    });
  }

  void _submitForm() async {
    final nom = _nomController.text.trim();
    final prenom = _prenomController.text.trim();
    final email = _emailController.text.trim();

    if (nom.isEmpty || prenom.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    if (!EmailValidator.validate(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer un email valide")),
      );
      return;
    }

    final redacteur = Redacteur(nom: nom, prenom: prenom, email: email);
    await DBHelper.insertRedacteur(redacteur);

    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();
    await _loadRedacteurs();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Rédacteur ajouté : $nom $prenom")));
  }

  void _modifierRedacteur(int index) {
    final redacteur = _redacteurs[index];
    final nomController = TextEditingController(text: redacteur.nom);
    final prenomController = TextEditingController(text: redacteur.prenom);
    final emailController = TextEditingController(text: redacteur.email);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        // Utiliser un nouveau contexte pour le dialogue
        title: const Text("Modifier le rédacteur"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: prenomController,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              nomController.dispose();
              prenomController.dispose();
              emailController.dispose();
            },
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              final nom = nomController.text.trim();
              final prenom = prenomController.text.trim();
              final email = emailController.text.trim();

              if (nom.isEmpty || prenom.isEmpty || email.isEmpty) {
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  const SnackBar(
                    content: Text("Veuillez remplir tous les champs"),
                  ),
                );
                return;
              }

              final newRedacteur = Redacteur(
                id: redacteur.id,
                nom: nom,
                prenom: prenom,
                email: email,
              );

              await DBHelper.updateRedacteur(newRedacteur);
              await _loadRedacteurs();

              // S'assurer que le widget est toujours monté avant de naviguer
              if (mounted) {
                Navigator.pop(dialogContext);
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Rédacteur modifié : $nom $prenom")),
              );

              // Disposer les contrôleurs APRÈS la fermeture du dialogue
              nomController.dispose();
              prenomController.dispose();
              emailController.dispose();
            },
            child: const Text("Modifier"),
          ),
        ],
      ),
    );
  }

  void _supprimerRedacteur(int id, String nom, String prenom) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmer la suppression"),
        content: Text("Êtes-vous sûr de vouloir supprimer $prenom $nom ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        await DBHelper.deleteRedacteur(id);
        await _loadRedacteurs();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Rédacteur supprimé")));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de la suppression : $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageAccueil()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Rédacteur'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RedacteurPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _prenomController,
              decoration: const InputDecoration(
                labelText: 'Prénom',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.add),
              label: const Text("Ajouter un rédacteur"),
            ),
            const SizedBox(height: 24),
            const Text(
              "Liste des rédacteurs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _redacteurs.length,
                itemBuilder: (context, index) {
                  final redacteur = _redacteurs[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text("${redacteur.prenom} ${redacteur.nom}"),
                      subtitle: Text(redacteur.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _modifierRedacteur(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: redacteur.id != null
                                ? () => _supprimerRedacteur(
                                    redacteur.id!,
                                    redacteur.nom,
                                    redacteur.prenom,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
