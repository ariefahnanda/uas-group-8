import 'dart:convert';
import 'package:ecommerce_app/core/colors.dart';
import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/pages/cart_page.dart';
import 'package:ecommerce_app/pages/favorite_page.dart';
import 'package:ecommerce_app/widgets/banner_slider.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:ecommerce_app/widgets/title_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// [fungsi untuk mengambil list data produk dari API]
  Future<List<Products>> getProducts() async {
    const String url = 'https://api.escuelajs.co/api/v1/products?limit=20&offset=15';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Products.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Ecommerce Store'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              );
            },
            icon: const Icon(Icons.favorite_outline),
          ),
          IconButton(
            onPressed: () {
              /// [Penggunaan Intents = perpindahan halaman, membawa data kehalaman berikutnya]
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            icon: Badge.count(
              count: 2,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const BannerSlider(
            items: [
              'assets/images/banner1.png',
              'assets/images/banner2.png',
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleContent(
                title: 'Product',
                onSeeAllTap: () {},
              ),

              /// [FutureBuilder digunakan untuk menunggu data dari API atau proses asinkron lainnya]
              FutureBuilder<List<Products>>(
                future: getProducts(),
                builder: (context, snapshot) {
                  /// [Saat Future masih berjalan (belum selesai), tampilkan loading indicator]
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );

                    /// [Jika terjadi error dalam Future, tampilkan pesan error]
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );

                    /// [Jika data berhasil diterima tapi kosong, tampilkan pesan bahwa produk tidak tersedia]
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No products available'),
                    );
                  }
                  final products = snapshot.data!;

                  /// [Penggunaan View (ListView, GridView) = menampilkan berbagai komponen]
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) => ProductCard(
                      data: products[index],
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
