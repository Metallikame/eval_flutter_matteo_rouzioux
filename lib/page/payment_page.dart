import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
            _buildElevatedContainer(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Récapitulatif de votre commande :",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16.0),
                  // Ligne sous-total
                  _buildOrderSummaryRow(
                      "Sous-Total :", '${subtotal.toStringAsFixed(2)}€'),
                  // Ligne TVA (20%)
                  _buildOrderSummaryRow(
                      "TVA (20%) :", '${tva.toStringAsFixed(2)}€'),
                  // Ligne Total
                  _buildOrderSummaryRow(
                      "Total :", '${total.toStringAsFixed(2)}€'),
                ],
              ),
            ),

            const SizedBox(height: 16.0),

            const Padding(
              padding: EdgeInsets.fromLTRB(0, 12.0, 12.0, 12.0),
              child: Text("Adresse de livraison",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            _buildElevatedContainer(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8.0),
                  // Bloc Adresse de livraison
                  _buildDeliveryAddress("Michel Le Poney",
                      "8 rue des ouvertures de portes", "93204 CORBEAUX"),
                ],
              ),
            ),

            const SizedBox(height: 16.0),

            const Padding(
              padding: EdgeInsets.fromLTRB(0, 12.0, 12.0, 12.0),
              child: Text("Méthode de paiement",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8.0),
                // Bloc Méthode de paiement
                _buildPaymentMethods(context),
              ],
            ),

            const SizedBox(height: 16.0),

            // Espace flexible pour pousser le bouton en bas de la page
            const Spacer(),

            // Texte d'acceptation
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 12.0),
              child: Text(
                "En cliquant sur \"confirmer l'achat\", vous acceptez les Conditions de vente de EPSI Shop Internationnal. Besoin d'aide ? Désolé on peut rien faire.\n"
                "En poursuivant, vous acceptez les Conditions d'utilisation du fournisseur de paiement CoffeeDis.",
                textAlign: TextAlign.left,
              ),
            ),

            // Bouton Confirmer l'achat
            ElevatedButton(
              onPressed: () {
                // Ajoutez votre logique de traitement pour la confirmation de l'achat ici
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side:
                      BorderSide(color: Theme.of(context).colorScheme!.outline),
                ),
                // Ajout de propriétés spécifiques au bouton de confirmation
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
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

  Widget _buildDeliveryAddress(String name, String address, String ville) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4.0),
        Text(address),
        Text(ville),
      ],
    );
  }

  Widget _buildPaymentMethods(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPaymentMethodContainer(context, FontAwesomeIcons.creditCard),
        _buildPaymentMethodContainer(context, FontAwesomeIcons.paypal),
        _buildPaymentMethodContainer(context, FontAwesomeIcons.googleWallet),
        _buildPaymentMethodContainer(context, FontAwesomeIcons.applePay),
      ],
    );
  }

  Widget _buildPaymentMethodContainer(BuildContext context, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme!.outline,
        ),
      ),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            icon: FaIcon(icon),
            onPressed: () {
              // Ajoutez votre logique de sélection de la méthode de paiement ici
            },
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedContainer(BuildContext context,
      {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme!.outline),
      ),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: child,
        ),
      ),
    );
  }
}
