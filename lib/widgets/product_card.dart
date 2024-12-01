import 'package:ecommerce_app/core/colors.dart';
import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/pages/detail_product_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Products data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductPage(products: data),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.3),
                  blurRadius: 1.0,
                  spreadRadius: 0,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    data.images[0],
                    width: double.infinity,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Flexible(
                  child: Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  data.priceFormat,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
