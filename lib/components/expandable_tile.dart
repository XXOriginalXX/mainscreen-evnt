import 'package:flutter/material.dart';

class ExpandableTile extends StatefulWidget {
  const ExpandableTile({
    super.key,
    required this.initialTitle,
    required this.expandedTitle,
    required this.titleColor,
    required this.containerColor,
    this.iconColor = Colors.white,
    this.children = const [],
  });

  final String initialTitle;
  final String expandedTitle;
  final Color titleColor;
  final Color containerColor;
  final Color iconColor;
  final List<Widget> children;

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.containerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 80,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 30, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isExpanded
                            ? widget.expandedTitle
                            : widget.initialTitle,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: widget.titleColor,
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.remove_circle_rounded
                            : Icons.add_circle_rounded,
                        color: widget.iconColor,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Column(
                  children: widget.children,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
