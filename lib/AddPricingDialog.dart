import 'package:flutter/material.dart';

class AddPricingDialog extends StatefulWidget {
  final Function(String?, String?) addPrice;

  AddPricingDialog({required this.addPrice});

  @override
  _AddPricingDialogState createState() => _AddPricingDialogState();
}

class _AddPricingDialogState extends State<AddPricingDialog> {
  String? priceName;
  String? priceValue;
  bool quantityPerPrice = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Pricing'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Checkbox(
                value: quantityPerPrice,
                onChanged: (value) {
                  setState(() {
                    quantityPerPrice = value ?? false;
                    if (!quantityPerPrice) {
                      priceName =
                          null; // Reset price name if quantityPerPrice is unchecked
                    }
                  });
                },
              ),
              Text('Quantity Per Price'),
            ],
          ),
          if (quantityPerPrice)
            TextField(
              onChanged: (value) {
                priceName = value;
              },
              decoration: InputDecoration(labelText: 'Enter Unit Amount'),
            ),
          TextField(
            onChanged: (value) {
              priceValue = value;
            },
            decoration: InputDecoration(labelText: 'Enter Price In Rand'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                widget.addPrice(quantityPerPrice ? priceName : "", priceValue);
                // Close current dialog and show another AddPricingDialog
                Navigator.pop(context);
              },
              child: Text('Add Price'),
            ),
          ),
        ],
      ),
    );
  }
}
