import 'package:flutter/material.dart';
import 'package:gram_villa_latest/styles/colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final double roundness;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final Function onPressed;
  Widget? trailingWidget;

  AppButton({
    Key? key,
    required this.label,
    this.roundness = 18,
    this.fontWeight = FontWeight.bold,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
    required this.onPressed,
    this.trailingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: RaisedButton(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundness),
        ),
        color: AppColors.primaryColor,
        textColor: Colors.white,
        elevation: 0.0,
        padding: padding,
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: fontWeight,
                ),
              ),
            ),
            if (trailingWidget != null)
              Positioned(
                top: 0,
                right: 25,
                child: trailingWidget!,
              )
          ],
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
