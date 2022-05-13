import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gram_villa_latest/Constants.dart';
import 'package:gram_villa_latest/models/product_category.dart';
import 'package:gram_villa_latest/models/product_item.dart';
import 'package:gram_villa_latest/screens/categoryItems/category_items_screen.dart';
import 'package:gram_villa_latest/screens/search/search_bar_widget.dart';
import 'package:gram_villa_latest/service/db_service.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'category_item_card_widget.dart';

List<Color> gridColors = [
  Color(0xff53B175),
  Color(0xffF8A44C),
  Color(0xffF7A593),
  Color(0xffD3B0E0),
  Color(0xffFDE598),
  Color(0xffB7DFF5),
  Color(0xff836AF6),
  Color(0xffD73B77),
];

class SearchScreen extends StatefulWidget {

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductCategory> categories = List.empty();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: paddingScreen,
        child: Column(
          children: [
            getHeader(),
            SizedBox(height: 20,),
            Expanded(
              child: getStaggeredGridView(context),
            ),
          ],
        ),
      ),
    ));
  }

  Widget getHeader() {
    return Column(
      children: [
        Center(
          child: AppText(
            text: "Search Products",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SearchBarWidget(searchProductByQuery),
      ],
    );
  }

  Widget getStaggeredGridView(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount:4,
      children: categories.asMap().entries.map<Widget>((e) {
        int index = e.key;
        ProductCategory categoryItem = e.value;
        return GestureDetector(
          onTap: () {
            onCategoryItemClicked(context, categoryItem);
          },
          child: Container(
            //padding: EdgeInsets.all(10),
            child: CategoryItemCardWidget(
              item: categoryItem,
              color: gridColors[index % gridColors.length],
            ),
          ),
        );
      }).toList(),
      //Here is the place that we are getting flexible/ dynamic card for various images
      staggeredTiles: categories
          .map<StaggeredTile>((_) => StaggeredTile.fit(2))
          .toList(),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0, // add some space
    );
  }

  Future<List<ProductItem?>> fetchProductsForCategory(String categoryName) async {
    return await DBService().getProductsForCategory(categoryName, context);
  }

  void onCategoryItemClicked(BuildContext context, ProductCategory categoryItem) async {
    List<ProductItem?> productItems = await fetchProductsForCategory(categoryItem.name);
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return CategoryItemsScreen(productItems);
      },
    ));
  }

  Future<void> fetchCategories() async {
    categories = await DBService().getCategories();
    setState(() {
      categories = categories;
    });
  }

  void searchProductByQuery(String searchString) async {
    List<ProductItem?> productItems = await DBService().getProductsBySearchString(searchString, context);
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return CategoryItemsScreen(productItems);
      },
    ));
  }
}
