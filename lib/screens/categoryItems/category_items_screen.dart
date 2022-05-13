import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gram_villa_latest/models/product_category.dart';
import 'package:gram_villa_latest/models/product_item.dart';
import 'package:gram_villa_latest/service/db_service.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';
import 'package:gram_villa_latest/widgets/grocery_item_card_widget.dart';

class CategoryItemsScreen extends StatefulWidget {
  final List<ProductItem?> productItems;

  CategoryItemsScreen(this.productItems);

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  List<ProductItem?> productItems = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    productItems = widget.productItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(left: 25),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          title: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: AppText(
              text: "Search Result",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: StaggeredGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 0.0,
          children: productItems.asMap().entries.map<Widget>((e) {
            ProductItem? productItem = e.value;
            if(productItem == null) return Container();
            return GestureDetector(
              onTap: () {
                //onItemClicked(context, productItem);
              },
              child: GroceryItemCardWidget(
                item: productItem,
              ),
            );
          }).toList(),
          staggeredTiles: productItems
              .map<StaggeredTile>((_) => StaggeredTile.fit(2))
              .toList(),
        ));
  }

  void onItemClicked(BuildContext context, ProductItem productItem) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => ProductDetailsScreen(groceryItem)),
    //   );
    // }
  }
}
