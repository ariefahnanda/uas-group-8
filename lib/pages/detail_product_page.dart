import 'package:ecommerce_app/core/colors.dart';
import 'package:ecommerce_app/core/database_helper.dart';
import 'package:ecommerce_app/models/favorite_product.dart';
import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/pages/cart_page.dart';
import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:flutter/material.dart';

class DetailProductPage extends StatefulWidget {
  final Products products;

  const DetailProductPage({
    super.key,
    required this.products,
  });

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();

    /// [Mengecek apakah produk sudah ada di favorit saat halaman load]
    _checkIfFavorite();
  }

  /// [Mengecek apakah produk ada di daftar favorit]
  void _checkIfFavorite() async {
    final favorites = await DatabaseHelper().getFavorites();
    final isFavorite = favorites.any((product) => product.id == widget.products.id);

    setState(() {
      isFavorited = isFavorite;
    });
  }

  /// [Fungsi untuk menambah atau menghapus produk dari favorit]
  void toggleFavorite() async {
    setState(() {
      isFavorited = !isFavorited;
    });

    if (isFavorited) {
      await DatabaseHelper().addFavorite(FavoriteProduct(
        id: widget.products.id,
        title: widget.products.title,
        imageUrl: widget.products.images[0],
        price: widget.products.priceFormat,
      ));
    } else {
      await DatabaseHelper().removeFavorite(widget.products.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.products.images.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.products.images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.products.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: toggleFavorite,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_outline,
                      color: isFavorited ? Colors.red : Colors.grey,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.products.priceFormat,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description Product :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.products.description,
              style: TextStyle(
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Button.filled(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            label: 'Add to Cart',
          ),
        ),
      ),
    );
  }
}
