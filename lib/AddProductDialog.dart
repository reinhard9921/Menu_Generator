import 'package:flutter/material.dart';
import 'package:menu_generator/AddPricingDialog.dart';
import 'package:menu_generator/models/Categories.dart';
import 'package:menu_generator/models/Pricing.dart';
import 'package:menu_generator/models/Product.dart';

class AddProductDialog extends StatefulWidget {
  final Categories categories;
  final VoidCallback? onProductAdded;

  AddProductDialog({required this.categories, this.onProductAdded});

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  String? productName;
  String? productDesc;
  List<Pricing> prices = [];

  void _addPrice(String? priceName, String? priceValue) {
    if (priceName != null && priceValue != null) {
      setState(() {
        prices.add(Pricing(name: priceName, price: priceValue));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Product'),
      content: SingleChildScrollView(
        // Wrap in SingleChildScrollView
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                productName = value;
              },
              decoration: InputDecoration(hintText: 'Enter Product Name'),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                productDesc = value;
              },
              decoration: InputDecoration(hintText: 'Enter Description'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Add Prices:'),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddPricingDialog(addPrice: _addPrice);
                      },
                    );
                  },
                  child: Text('Add Price'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Prices: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: prices.asMap().entries.map((entry) {
                final index = entry.key;
                final price = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: Text(price.name),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(price.price),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          prices.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (productName != null && productName!.isNotEmpty) {
                  widget.categories.products.add(
                    Product(
                        name: productName!, desc: productDesc!, prices: prices),
                  );
                  widget.onProductAdded
                      ?.call(); // Update UI after adding product
                  Navigator.pop(context); // Close dialog
                }
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
