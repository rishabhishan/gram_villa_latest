import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gram_villa_latest/models/address.dart';
import 'package:gram_villa_latest/models/order.dart';
import 'package:gram_villa_latest/screens/cart/checkout_bottom_sheet.dart';
import 'package:gram_villa_latest/widgets/app_button.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';

import '../../Constants.dart';

class AddAddressScreen extends StatefulWidget {
  Order order;

  AddAddressScreen(this.order, {Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late double lat, lng;
  final flat_no_controller = TextEditingController();
  final street_controller = TextEditingController();
  final pincode_controller = TextEditingController();
  final city_controller = TextEditingController();
  final state_controller = TextEditingController();
  final address_tag_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: new Wrap(
        runSpacing: 16.0,
        children: <Widget>[
          AppText(
            text: "Delivery Address",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          GestureDetector(
            onTap: () {
              findCurrentLocation();
            },
            child: Container(
              padding: EdgeInsets.all(16),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Color(0xFFF2F3F2),
                borderRadius: BorderRadius.circular(borderRadius / 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      child: Icon(
                    Icons.location_pin,
                    color: Colors.white,
                  )),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Use my current location",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      //color: Color(0xFF7C7C7C)
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
          ),

          TextFormField(
            controller: flat_no_controller,
            decoration: InputDecoration(
              labelText: 'Flat#, Building',
              border: OutlineInputBorder(),
            ),
          ),
          TextFormField(
            controller: street_controller,
            decoration: InputDecoration(
              labelText: 'Street',
              border: OutlineInputBorder(),
            ),
          ),
          TextFormField(
            controller: pincode_controller,
            decoration: InputDecoration(
              labelText: 'Pincode',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: city_controller,
                  enabled: true,
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  controller: state_controller,
                  enabled: true,
                  decoration: InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          // TextFormField(
          //   controller: address_tag_controller,
          //   decoration: InputDecoration(
          //       labelText: 'Address Title',
          //       hintText: 'Home, Office',
          //       border: OutlineInputBorder(),
          //       prefixIcon: Icon(Icons.tag_rounded)),
          // ),
          AppButton(
            label: "Continue",
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.symmetric(
              vertical: 25,
            ),
            onPressed: () {
              Order order = widget.order;
              order.deliveryAddress = getAddress();
              Navigator.pop(context);
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext bc) {
                    return CheckoutBottomSheet(order);
                  });
            },
          )
        ],
      ),
    );
  }

  Address getAddress() {
    return Address(
        flat_no_controller.text,
        street_controller.text,
        pincode_controller.text,
        city_controller.text,
        state_controller.text,
        DateTime.now(),
        lat,
        lng,
        DateTime.now().add(Duration(days: 1)),
        null);
  }

  Widget getHeader() {
    return Column(
      children: [
        // SizedBox(
        //   height: 16,
        // ),
        Center(
          child: AppText(
            text: "Add Address",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location service is disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permission is permanently denied.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'en_US');
    print(placemarks);
    Placemark place = placemarks[0];
    street_controller.text = place.subLocality! + ", " + place.thoroughfare!;
    pincode_controller.text = place.postalCode!;
    state_controller.text = place.administrativeArea!;
    city_controller.text = place.locality!;

    print(
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}');
    setState(() {});
  }

  Future<void> findCurrentLocation() async {
    Position position = await _getGeoLocationPosition();
    lat = position.latitude;
    lng = position.longitude;
    _getAddressFromLatLong(position);
  }
}
