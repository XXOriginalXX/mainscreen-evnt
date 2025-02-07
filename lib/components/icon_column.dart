import 'package:flutter/material.dart';

class IconColumn extends StatelessWidget {
  final String assetPath;
  final String label;
  final String value;
  final bool isMultilineValue;

  const IconColumn({super.key, 
    required this.assetPath,
    required this.label,
    required this.value,
    this.isMultilineValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 70),
      child: Column(
        children: [
          Image.asset(
            assetPath,
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 13),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: Colors.orange),
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: isMultilineValue ? 2 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
