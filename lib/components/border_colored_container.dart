import 'package:flutter/material.dart';

class BorderColoredContainer extends StatelessWidget {
  final String month;
  final Color bordercolor;
  final bool hasEvent;

  const BorderColoredContainer({
    super.key,
    required this.month,
    required this.bordercolor,
    this.hasEvent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            color: Colors.grey[800]!.withAlpha(160),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: bordercolor,

            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Text(
            month,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (hasEvent)
          Positioned(
            top: 48,
            left: 35,
            child: Image.asset(
              'assets/images/mge_logo.png',
              height: 30,
            ),
          ),
      ],
    );
  }
}