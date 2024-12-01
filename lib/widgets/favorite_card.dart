import 'package:ecommerce_app/core/colors.dart';
import 'package:ecommerce_app/models/favorite_product.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final FavoriteProduct favoriteProduct;
  final Function() onDelete;
  const FavoriteCard({
    super.key,
    required this.favoriteProduct,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.grey.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Image.network(
              favoriteProduct.imageUrl,
              width: 68.0,
              height: 68.0,
            ),
          ),
          const SizedBox(
            width: 14.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favoriteProduct.title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  favoriteProduct.price,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
