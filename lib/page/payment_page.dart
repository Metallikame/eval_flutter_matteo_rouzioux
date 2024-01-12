import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>;
    final subtotal = double.parse(arguments['subtotal'] ?? '0.00');
    final tva = 0.20 * subtotal;
    final total = subtotal + tva;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalisation de la commande"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildElevatedContainer(context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Récapitulatif de votre commande"),
                  const SizedBox(height: 16.0),
                  // Ligne sous-total
                  _buildOrderSummaryRow(
                      "Sous-Total", '${subtotal.toStringAsFixed(2)}€'),
                  // Ligne TVA (20%)
                  _buildOrderSummaryRow(
                      "TVA (20%)", '${tva.toStringAsFixed(2)}€'),
                  // Ligne Total
                  _buildOrderSummaryRow(
                      "Total", '${total.toStringAsFixed(2)}€'),
                ],
              ),
            ),

            const SizedBox(height: 16.0),

            _buildElevatedContainer(context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Adresse de livraison"),
                  const SizedBox(height: 8.0),
                  // Bloc Adresse de livraison
                  _buildDeliveryAddress("Michel Le Poney",
                      "8 rue des ouvertures de portes, 93204 CORBEAUX"),
                ],
              ),
            ),

            const SizedBox(height: 16.0),

            _buildElevatedContainer(context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Méthode de paiement"),
                  const SizedBox(height: 8.0),
                  // Bloc Méthode de paiement
                  _buildPaymentMethods(),
                ],
              ),
            ),

            const SizedBox(height: 16.0),

            // Bouton Confirmer l'achat
            ElevatedButton(
              onPressed: () {
                // Ajoutez votre logique de traitement pour la confirmation de l'achat ici
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Theme
                      .of(context)
                      .colorScheme!
                      .outline),
                ),
              ),
              child: const Text("Confirmer l'achat"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(amount),
      ],
    );
  }

  Widget _buildDeliveryAddress(String name, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4.0),
        Text(address),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPaymentMethodIcon(FontAwesomeIcons.creditCard),
        _buildPaymentMethodIcon(FontAwesomeIcons.paypal),
        _buildPaymentMethodIcon(FontAwesomeIcons.googleWallet),
        _buildPaymentMethodIcon(FontAwesomeIcons.applePay),
      ],
    );
  }

  Widget _buildPaymentMethodIcon(IconData icon) {
    return IconButton(
      icon: FaIcon(icon),
      onPressed: () {
        // Ajoutez votre logique de sélection de la méthode de paiement ici
      },
    );
  }

  Widget _buildElevatedContainer(BuildContext context,
      {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme
            .of(context)
            .colorScheme!
            .outline),
      ),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          // Ajout de marges
          child: child,
        ),
      ),
    );
  }
}