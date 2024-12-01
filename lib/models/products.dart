import 'package:intl/intl.dart';

class Products {
  final int id;
  final String title;
  final int price;
  final String description;
  final List<String> images;
  final DateTime creationAt;
  final DateTime updatedAt;
  final Category category;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    required this.category,
  });

  String get priceFormat => (price * 1000).currencyFormatRp;

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as int),
      description: json['description'],
      images: List<String>.from(json['images']),
      creationAt: DateTime.parse(json['creationAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      category: Category.fromJson(json['category']),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String image;
  final DateTime creationAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      creationAt: DateTime.parse(json['creationAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

extension IntExt on int {
  String get currencyFormatRp => NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp ',
        decimalDigits: 0,
      ).format(this);
}
