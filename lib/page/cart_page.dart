import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../bo/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EPSI Shop"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: context.watch<Cart>().items.isNotEmpty
            ? const ListCart()
            : const EmptyCart(),
      ),
      bottomNavigationBar: context.watch<Cart>().items.isNotEmpty
          ? const ProceedToPaymentButton()
          : null,
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Votre panier total est de"), Text("0.00€")],
        ),
        Spacer(),
        Text("Votre panier est actuellement vide"),
        Icon(Icons.image),
        Spacer(),
      ],
    );
  }
}

class ListCart extends StatelessWidget {
  const ListCart({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, _) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Votre panier total est de"),
              Text(cart.priceTotalInEuro())
            ],
          ),
          Flexible(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) => ListTile(
                leading: Image.network(cart.items[index].image),
                title: Text(cart.items[index].nom),
                subtitle: Text(
                  cart.items[index].getPrixEuro(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: TextButton(
                  child: const Text("SUPPRIMER"),
                  onPressed: () =>
                      context.read<Cart>().removeArticle(cart.items[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProceedToPaymentButton extends StatelessWidget {
  const ProceedToPaymentButton({Key? key});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<Cart>();
    final subtotalInt = cart.priceTotal();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0), // Ajout de marges
      child: ElevatedButton(
        onPressed: () {
          context.go('/payment?subtotal=$subtotalInt');
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.red, elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ), // Couleur du texte
        ),
        child: const Text("Procéder au paiement"),
      ),
    );
  }
}
