// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:gram_villa_latest/models/product_category.dart';
// import 'package:gram_villa_latest/service/db_service.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../constants.dart';
// import 'loading_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<ProductCategory> productCategories = [];
//   List<DocumentSnapshot> banners = [];
//   List<DocumentSnapshot> popularProducts = [];
//   DBService dbService = DBService();
//
//   // List<BookItem> latestBooks = [];
//   // List<UserNotification> notifications = [];
//
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     fetchProductCategories();
//     //fetchBanners();
//     //fetchPopularProducts();
//   }
//
//   List<Color> productCategoryBgcolors = [
//     Color(0xffDFECF8),
//     Color(0xffFCE8A8),
//     Color(0xFFc1cbd8),
//     Color(0xFFffd3b6),
//     Color(0xFFee96b5),
//     Color(0xffE2F3C2),
//     Color(0xFF929fb5),
//     Color(0xffFFDBC5)
//   ];
//
//   Future<void> fetchProductCategories() async {
//     setState(() {
//       isLoading = true;
//     });
//     final documents = await dbService.getCategories();
//     setState(() {
//       isLoading = false;
//       productCategories = documents;
//     });
//   }
//
//   Future<void> fetchBanners() async {
//     setState(() {
//       isLoading = true;
//     });
//     final QuerySnapshot result =
//         await FirebaseFirestore.instance.collection('banners').get();
//     final List<DocumentSnapshot> documents = result.docs;
//     setState(() {
//       isLoading = false;
//       banners = documents;
//     });
//   }
//
//   Future<void> fetchPopularProducts() async {
//     setState(() {
//       isLoading = true;
//     });
//     final QuerySnapshot result =
//         await FirebaseFirestore.instance.collection('categories').get();
//     final List<DocumentSnapshot> documents = result.docs;
//     setState(() {
//       isLoading = false;
//       popularProducts = documents;
//     });
//   }
//
//   Widget _buildCategoryListItem(BuildContext context, int index) {
//     var productCategory = productCategories[index];
//     var color = productCategoryBgcolors[index % 4];
//
//     return Column(
//       children: <Widget>[
//         Container(
//           height: 80,
//           width: 80,
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//           child: Image.network(
//             productCategory.iconURL,
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           productCategory.displayName,
//         )
//       ],
//     );
//
//     return Material(
//       //shadowColor: kShadowColor,
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//               context,
//               // MaterialPageRoute(
//               //     builder: (context) =>
//               //         SearchResultScreen(
//               //           latestBooks: latestBooks,
//               //           autoFocusSearch: false,
//               //           genres:
//               //           this.genres.map((genre) => genre['name']).toList(),
//               //           searchGenre: genre["name"],
//               //         ))
//               MaterialPageRoute(builder: (context) => LoadingScreen()));
//         },
//         child: Container(
//           padding: EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(borderRadius * 2.5),
//           ),
//           child: Center(
//             child: Text(productCategory.displayName,
//                 softWrap: true,
//                 style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                     color: Colors.white, fontWeight: FontWeight.w600)),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoadingCategoriesListItem(BuildContext context, int index) {
//     var color = productCategoryBgcolors[index % 4];
//     return Material(
//       child: Container(
//         width: 100,
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: new BorderRadius.circular(10.0),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoadingProductItem(x, y) {
//     return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 91.0,
//             height: 130.0,
//             color: Colors.white,
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 4.0),
//           ),
//           Container(width: 90, height: 8.0, color: Colors.white),
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 4.0),
//           ),
//           Container(width: 91, height: 8.0, color: Colors.white)
//         ]);
//   }
//
//   Widget _buildUserInfo() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         //TODO : dynamic name
//         // Text("Hey ${this.firebaseUser.displayName.split(" ")[0]},",
//         //     style: kHeadingextStyle),
//         Text("Hello, Rishabh!!", style: kHeadingextStyle),
//         Material(
//           elevation: 5,
//           shape: CircleBorder(),
//           color: Colors.transparent,
//           child: CircleAvatar(
//             backgroundImage:
//                 //NetworkImage(this.firebaseUser.photoUrl),
//                 NetworkImage(
//                     "https://lh3.googleusercontent.com/a-/AOh14Gg_ZvRYHmH5pMtD_HCSEa_5XnAq8vfwjmRW0snIWw=s96-c"),
//             backgroundColor: Colors.transparent,
//             radius: 25,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
//       decoration: BoxDecoration(
//         color: Color(0xFFF5F5F7),
//         borderRadius: BorderRadius.circular(borderRadius * 5),
//       ),
//       child: TextField(
//         readOnly: true,
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) {
//               // TODO : Search Screen
//               // return SearchResultScreen(
//               //   latestBooks: latestBooks,
//               //   autoFocusSearch: true,
//               //   genres: this
//               //       .genres
//               //       .map((genre) => genre['name'])
//               //       .toList(),
//               // );
//               return LoadingScreen();
//             }),
//           );
//         },
//         decoration: InputDecoration(
//           //enabled: false,
//           hintText: "Search For Items",
//           icon: Icon(LineAwesomeIcons.search),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoadingBanners() {
//     return Center(child: Image.asset('assets/images/banner.png'));
//   }
//
//   Widget _buildBanners() {
//     return Center(child: Image.asset('assets/images/banner_1.png'));
//   }
//
//   Widget _buildProductCategories() {
//     return productCategories.length == 0
//         ? SizedBox.fromSize(
//             size: const Size.fromHeight(45.0),
//             child: Shimmer.fromColors(
//                 baseColor: Colors.grey.shade300,
//                 highlightColor: Colors.grey.shade100,
//                 child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: _buildLoadingCategoriesListItem,
//                     separatorBuilder: (context, index) {
//                       return SizedBox(
//                         width: 16,
//                       );
//                     },
//                     itemCount: 3)),
//           )
//         : SizedBox.fromSize(
//             size: const Size.fromHeight(110.0),
//             child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: _buildCategoryListItem,
//                 separatorBuilder: (context, index) {
//                   return SizedBox(
//                     width: 16,
//                   );
//                 },
//                 itemCount: productCategories.length),
//           );
//   }
//
//   Widget _buildPopularProducts() {
//     return popularProducts.length == 0
//         ? SizedBox.fromSize(
//             size: const Size.fromHeight(210.0),
//             child: Shimmer.fromColors(
//                 baseColor: Colors.grey.shade300,
//                 highlightColor: Colors.grey.shade100,
//                 child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: _buildLoadingProductItem,
//                     separatorBuilder: (context, index) {
//                       return SizedBox(
//                         width: 20,
//                       );
//                     },
//                     itemCount: 3)),
//           )
//         : SizedBox.fromSize(
//             size: const Size.fromHeight(210.0),
//             child: ListView.separated(
//               itemCount: popularProducts.length,
//               itemBuilder: (BuildContext ctx, int index) {
//                 return _buildLoadingProductItem(ctx, index);
//               },
//               separatorBuilder: (context, index) {
//                 return SizedBox(
//                   width: 30,
//                 );
//               },
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.only(top: 12.0),
//             ),
//           );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: fetch user
//     // firebaseUser = Provider.of<User>(
//     //     context);
//     // fetchNotifications(firebaseUser.uid);
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: (Container(
//               padding: EdgeInsets.all(paddingScreen),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   _buildUserInfo(),
//                   //SizedBox(height: 20),
//                   // Text("Find grocery items you need",
//                   //     style: kSubheadingextStyle),
//                   SizedBox(height: 18),
//                   _buildSearchBar(),
//                   SizedBox(height: 18),
//                   _buildProductCategories(),
//                   SizedBox(height: 18),
//                   _buildBanners(),
//                   SizedBox(height: 36),
//                   Text(
//                     "Popular Products",
//                     style: Theme.of(context)
//                         .textTheme
//                         .subtitle1!
//                         .copyWith(fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(height: 12),
//                   _buildPopularProducts(),
//                 ],
//               ),
//             )),
//           ),
//         ));
//   }
// }
