class FavoriteProduct {
  final int id;
  final String title;
  final String imageUrl;
  final String price;

  FavoriteProduct({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });

  // Mengonversi ke Map untuk disimpan di SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  // Mengonversi dari Map ke model
  factory FavoriteProduct.fromMap(Map<String, dynamic> map) {
    return FavoriteProduct(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      price: map['price'],
    );
  }
}
