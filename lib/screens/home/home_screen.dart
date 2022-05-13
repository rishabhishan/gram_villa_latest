import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gram_villa_latest/dao/product_dao.dart';
import 'package:gram_villa_latest/models/product_category.dart';
import 'package:gram_villa_latest/models/product_item.dart';
import 'package:gram_villa_latest/screens/categoryItems/category_items_screen.dart';
import 'package:gram_villa_latest/screens/loading_screen.dart';
import 'package:gram_villa_latest/service/auth_service.dart';
import 'package:gram_villa_latest/service/db_service.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';
import 'package:gram_villa_latest/widgets/grocery_item_card_widget.dart';
import 'package:gram_villa_latest/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

import 'category_item_widget.dart';
import 'home_banner_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? currentUser = null;
  List<ProductCategory> categories = List.empty();
  List<ProductItem?> bestSellers = List.empty();
  List<ProductItem?> discountedProducts = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    print("************* HomeScreen initState -- started");
    super.initState();
    fetchCategories();
    fetchBestSellers();
    fetchDiscountedProducts();
    print("************* HomeScreen initState -- ended");
  }

  @override
  Widget build(BuildContext context) {
    print("************* HomeScreen build -- started");
    this.currentUser = Provider.of<AuthService>(context, listen: false).getUser;
    print("************* HomeScreen build -- ended");
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                padded(headerWidget()),
                const SizedBox(
                  height: 25,
                ),
                padded(SearchBarWidget()),
                SizedBox(
                  height: 25,
                ),
                padded(HomeBanner()),

                SizedBox(
                  height: 15,
                ),
                padded(subTitle("Categories", viewAllEnabled: false),
                    edgeInsets: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25)),
                getCategories(),


                SizedBox(
                  height: 25,
                ),
                padded(subTitle("Best Selling", viewAllEnabled: false)),
                getHorizontalItemSlider(bestSellers),
                SizedBox(
                  height: 15,
                ),
                padded(subTitle("Discounted Products", viewAllEnabled: false)),
                getHorizontalItemSlider(discountedProducts),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCategories() {
    return Container(
      height: 60,
      child: ListView.separated(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                onCategoryItemClicked(context, categories[index]);
              },
              child: CategoryCard(
                categories[index],
                color: Color(0xffF8A44C),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 20);
        },
      ),
    );
  }

  Widget padded(Widget widget,
      {EdgeInsets edgeInsets =
          const EdgeInsets.symmetric(horizontal: 25, vertical: 6)}) {
    return Padding(
      padding: edgeInsets,
      child: widget,
    );
  }

  Widget getHorizontalItemSlider(List<ProductItem?> items) {
    return Container(
      height: 220,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.where((element) => element != null).length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GroceryItemCardWidget(
            item: items[index]!,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 16,
          );
        },
      ),
    );
  }

  void onItemClicked(BuildContext context, ProductItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoadingScreen()
          //ProductDetailsScreen(groceryItem)

          ),
    );
  }

  Widget subTitle(String text, {bool viewAllEnabled = true}) {
    if (viewAllEnabled) {
      return Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            "View All",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      );
    }
  }

  Widget headerWidget() {
    String locationIconPath = "assets/icons/app_icon_color.svg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black12.withOpacity(0.1)),
              child: SvgPicture.asset(
                locationIconPath,
                height: 24,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(width: 16,),
            AppText(
              text: "GRAMVILLA",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),

        Material(
          elevation: 5,
          shape: CircleBorder(),
          color: Colors.transparent,
          child: CircleAvatar(
            backgroundImage: NetworkImage(this.currentUser!.photoURL!),
            backgroundColor: Colors.transparent,
            radius: 20,
          ),
        ),
      ],
    );
  }

  Future<void> fetchCategories() async {
    categories = await DBService().getCategories();
    setState(() {
      categories = categories;
    });
  }

  Future<void> fetchBestSellers() async {
    bestSellers = await DBService().getProductsByTag("best_seller", context);
    ProductDao productService = Provider.of<ProductDao>(context, listen: false);
    Map<String, ProductItem> items = productService.getProductsCache();
    items.values.forEach((element) {
      print(element.displayName + "  -  " + element.cart_quantity.toString());
    });
    setState(() {
      bestSellers = bestSellers;
    });
  }

  Future<void> fetchDiscountedProducts() async {
    discountedProducts =
        await DBService().getProductsByTag("discounted", context);
    setState(() {
      discountedProducts = discountedProducts;
    });
  }

  Future<List<ProductItem?>> fetchProductsForCategory(
      String categoryName) async {
    return await DBService().getProductsForCategory(categoryName, context);
  }

  void onCategoryItemClicked(
      BuildContext context, ProductCategory categoryItem) async {
    List<ProductItem?> productItems =
        await fetchProductsForCategory(categoryItem.name);
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return CategoryItemsScreen(productItems);
      },
    ));
  }
}
