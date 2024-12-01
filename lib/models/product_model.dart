import 'package:ecommerce_app/core/int_ext.dart';

class ProductModel {
  final String name;
  final int price;
  final String image;
  final String description;

  ProductModel({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  String get priceFormat => price.currencyFormatRp;
}

List<ProductModel> products = [
  ProductModel(
    name: "Earphone",
    price: 150000,
    image: "assets/images/earphone.png",
    description: "Deskripsi produk A.",
  ),
  ProductModel(
    name: "Keyboard",
    price: 250000,
    image: "assets/images/keyboard.png",
    description: "Deskripsi produk B.",
  ),
  ProductModel(
    name: "Lamp",
    price: 350000,
    image: "assets/images/lampu.png",
    description: "Deskripsi produk C.",
  ),
  ProductModel(
    name: "Macbook",
    price: 450000,
    image: "assets/images/mac.png",
    description: "Deskripsi produk D.",
  ),
  ProductModel(
    name: "Sepatu Merah",
    price: 550000,
    image: "assets/images/sepatu.png",
    description: "Deskripsi produk E.",
  ),
  ProductModel(
    name: "Sepatu Putih",
    price: 550000,
    image: "assets/images/sepatu2.png",
    description: "Deskripsi produk E.",
  ),
];
