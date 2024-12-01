import 'package:ecommerce_app/core/colors.dart';
import 'package:ecommerce_app/core/database_helper.dart';
import 'package:ecommerce_app/models/favorite_product.dart';
import 'package:ecommerce_app/widgets/favorite_card.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<FavoriteProduct>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = _dbHelper.getFavorites();
  }

  void _refreshFavorites() {
    setState(() {
      _favoritesFuture = _dbHelper.getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: FutureBuilder<List<FavoriteProduct>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No product favorite'),
            );
          }
          final favorites = snapshot.data!;
          return ListView.separated(
            itemCount: favorites.length,
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const SizedBox(
              height: 16.0,
            ),
            itemBuilder: (context, index) {
              final product = favorites[index];
              return FavoriteCard(
                favoriteProduct: product,
                onDelete: () async {
                  /// [Hapus produk dari database dan perbarui UI]
                  await _dbHelper.removeFavorite(product.id);

                  /// [Memperbarui daftar favorit setelah penghapusan]
                  _refreshFavorites();
                },
              );
            },
          );
        },
      ),
    );
  }
}
