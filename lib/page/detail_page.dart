import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/article.dart';
import '../bo/cart.dart';

class DetailPage extends StatelessWidget {
  final Article article;
  const DetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(article.nom),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                article.image,
                height: 200.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                article.nom,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                article.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                article.getPrixEuro(),
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                article.categorie,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () => context.read<Cart>().addArticle(article),
                  child: const Text("AJOUTER AU PANIER"))
            ],
          ),
        ));
  }
}
