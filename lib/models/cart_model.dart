import 'package:ecommerce_app/models/product_model.dart';

class CartModel {
  final ProductModel product;
  int quantity;

  CartModel({
    required this.product,
    required this.quantity,
  });
}

List<ProductModel> carts = [
  ProductModel(
    name: "Earphone",
    price: 150000,
    image: "assets/images/earphone.png",
    description: "Deskripsi produk A.",
  ),
  ProductModel(
    name: "Keyboard",
    price: 200000,
    image: "assets/images/keyboard.png",
    description: "Deskripsi produk B.",
  ),
];
