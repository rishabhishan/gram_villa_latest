import 'package:flutter/material.dart';
import 'package:gram_villa_latest/styles/colors.dart';

class ItemCounterWidget extends StatefulWidget {
  final Function onAmountChanged;
  final int amount;

  const ItemCounterWidget({Key? key, required this.onAmountChanged, required this.amount}) : super(key: key);

  @override
  _ItemCounterWidgetState createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> {
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    amount = widget.amount;
    return Row(
      children: [
        iconWidget(Icons.remove,
            iconColor: AppColors.darkGrey, onPressed: decrementAmount),
        SizedBox(width: 18),
        Container(
            width: 30,
            child: Center(
                child: getText(
                    text: amount.toString(), fontSize: 18, isBold: true))),
        SizedBox(width: 18),
        iconWidget(Icons.add,
            iconColor: AppColors.primaryColor, onPressed: incrementAmount)
      ],
    );
  }

  void incrementAmount() {
    setState(() {
      amount = amount + 1;
      updateParent();
    });
  }

  void decrementAmount() {
    if (amount <= 0) return;
    setState(() {
      amount = amount - 1;
      updateParent();
    });
  }

  void updateParent() {
    if (widget.onAmountChanged != null) {
      widget.onAmountChanged(amount);
    }
  }

  Widget iconWidget(IconData iconData, {Color? iconColor, onPressed}) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Color(0xffE2E2E2),
          ),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor ?? Colors.black,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget getText(
      {required String text,
        double? fontSize,
        bool isBold = false,
        color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    );
  }
}