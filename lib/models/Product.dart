import 'package:menu_generator/models/Pricing.dart';

class Product {
  String name;
  String? desc;
  List<Pricing> prices;

  Product({required this.name, required this.prices, this.desc});
}
