import 'package:flutter/material.dart';
import 'package:gram_villa_latest/models/product_category.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';

class GroceryFeaturedItem {
  final String name;
  final String imagePath;

  GroceryFeaturedItem(this.name, this.imagePath);
}

var groceryFeaturedItems = [
  GroceryFeaturedItem("Pulses", "assets/images/pulses.png"),
  GroceryFeaturedItem("Rice", "assets/images/rise.png"),
];

class CategoryCard extends StatelessWidget {
  const CategoryCard(this.groceryFeaturedItem,
      {this.color = AppColors.primaryColor});

  final ProductCategory groceryFeaturedItem;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
          color: color.withOpacity(0.25),
          borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          Image(
            image: NetworkImage(groceryFeaturedItem.iconURL),
            width: 32,
            height: 32,
          ),
          SizedBox(
            width: 16,
          ),
          AppText(
            text: groceryFeaturedItem.displayName,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}
