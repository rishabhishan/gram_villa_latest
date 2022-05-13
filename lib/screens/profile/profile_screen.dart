

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gram_villa_latest/screens/welcome_screen.dart';
import 'package:gram_villa_latest/service/auth_service.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';
import 'package:provider/provider.dart';

import 'profile_item.dart';

class ProfileScreen extends StatelessWidget {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: Stack(
        //alignment: Alignment.center,
        children: [
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                        Provider.of<AuthService>(context, listen: false)
                            .getUser!
                            .photoURL!),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                AppText(
                  text: Provider.of<AuthService>(context, listen: false)
                      .getUser!
                      .displayName!,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
                AppText(
                  text: Provider.of<AuthService>(context, listen: false)
                      .getUser!
                      .email!,
                  //fontWeight: FontWeight.w700,
                  fontSize: 14,
                )
              ]),
              Container(
                padding: EdgeInsets.fromLTRB(25, 20, 25, 12),
                alignment: Alignment.topLeft,
                child: AppText(
                  text: "Order Summary",
                  fontWeight: FontWeight.w700,
                  //fontSize: 22,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.secondaryColor.withOpacity(0.1)),
                    child: Column(
                      children: [
                        AppText(
                          text: "385",
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AppText(text: "Total Orders", fontSize: 14)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.secondaryColor.withOpacity(0.1)),
                    child: Column(
                      children: [
                        AppText(
                          text: "35",
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AppText(
                          text: "Completed",
                          fontSize: 14,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.secondaryColor.withOpacity(0.1)),
                    child: Column(
                      children: [
                        AppText(
                          text: "5",
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AppText(text: "Pending", fontSize: 14)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: profileItems.map((e) {
                  return getAccountItemWidget(e);
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              logoutButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: RaisedButton(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: Color(0xffF2F3F2),
        textColor: Colors.white,
        elevation: 0.0,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                "assets/icons/account_icons/logout_icon.svg",
              ),
            ),
            Text(
              "Log Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
            Container()
          ],
        ),
        onPressed: () async {
          await Provider.of<AuthService>(context, listen: false).signOut();
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) {
              return WelcomeScreen();
            },
          ));
        },
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/account_image.jpg";
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(imagePath),
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    );
  }

  Widget getAccountItemWidget(ProfileItem accountItem) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) {
            return accountItem.screen;
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                accountItem.iconPath,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              accountItem.label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppColors.secondaryColor.withOpacity(0.5);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 200, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
