import 'package:flutter/material.dart';
import 'package:gram_villa_latest/Constants.dart';
import 'package:gram_villa_latest/models/order.dart';
import 'package:gram_villa_latest/service/auth_service.dart';
import 'package:gram_villa_latest/service/db_service.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getHeader(context),
            Expanded(
              child: FutureBuilder(
                builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    return Container();
                  } else {
                    return ListView.separated(
                      itemCount: snapshot.data == null ? 0: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Order order = snapshot.data![index];
                        return getOrderCard(order);
                      }, separatorBuilder: (BuildContext context, int index) {
                        return Divider( thickness: 5,);
                    },
                    );
                  }
                },
                future: getUserOrders(
                    Provider.of<AuthService>(context, listen: false).getUser!.uid),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Order>> getUserOrders(String uid) async {
    return await DBService().getOrders(uid);
  }

  Widget getHeader(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, ),
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              AppText(
                text: "MY ORDERS",
                fontSize: 16,
                //fontWeight: FontWeight.,
              ),
            ],
          ),
        ),
        Divider(thickness: 2,),
      ],
    );
  }

  Widget getOrderCard(Order order){
    DateTime today = order.createdAt;
    String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    print(dateSlug);
    String itemsList  = order.productItems.map((e) => e.displayName + " x " + e.cart_quantity.toString()).toString();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: "#"+order.orderId, fontSize: 14, fontWeight: FontWeight.w600,),
                  SizedBox(height: 3,),
                  AppText(text: DateFormat('MMMM d, yyyy  kk:mm a').format(order.createdAt), fontSize: 14,fontWeight: FontWeight.w600),
                ],
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.red.withOpacity(0.5)),
                child: AppText(text: describeEnum(order.status).toUpperCase(), fontSize: 12, fontWeight: FontWeight.bold,),
              )
            ],
          ),

          SizedBox(height: 12,),
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(text: order.productItems.length.toString() + " Items", fontSize: 14, fontWeight: FontWeight.w600),
              AppText(text: "Rs " + order.billAmount.toStringAsFixed(2), fontSize: 14, fontWeight: FontWeight.w600),

            ],
          ),
          SizedBox(height: 4,),
          AppText(text: itemsList.substring(1, itemsList.length-1), fontSize: 14,),
          SizedBox(height: 12,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, size: 18,),
              SizedBox(width: 2,),
              Expanded(child: AppText(text: order.deliveryAddress!.getFullAddress(), fontSize: 14,)),
            ],
          ),
        ],
      ),
    );
  }
}
