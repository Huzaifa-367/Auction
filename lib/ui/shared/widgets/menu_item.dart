import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  Function? onPressed;
  final List<MenuItem>? childItems; // List of child menu items

  MenuItem({
    Key? key,
    required this.text,
    required this.icon,
    this.isActive = false,
    this.onPressed,
    this.childItems,
  }) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isHovered = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isParentActive = widget.isActive ||
        (widget.childItems != null &&
            widget.childItems!.any((item) => item.isActive));

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: isHovered
          ? Colors.white.withOpacity(0.1)
          : isParentActive
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isParentActive ? null : () => widget.onPressed!(),
          onHover: (value) => setState(() => isHovered = value),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(widget.icon, color: Colors.white.withOpacity(0.3)),
                    const SizedBox(width: 10),
                    Text(
                      widget.text,
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: Colors.white.withOpacity(0.8)),
                    ),
                    if (widget.childItems != null &&
                        widget.childItems!.isNotEmpty)
                      IconButton(
                        icon: Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        onPressed: () {
                          setState(() => isExpanded = !isExpanded);
                        },
                      ),
                  ],
                ),
                if (isExpanded &&
                    widget.childItems != null &&
                    widget.childItems!.isNotEmpty)
                  // Display child items using ExpansionTile
                  Container(
                    constraints: const BoxConstraints(
                        maxHeight: 200), // Adjust the height as needed
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (var childItem in widget.childItems!)
                          MenuItem(
                            text: childItem.text,
                            icon: childItem.icon,
                            isActive: childItem.isActive,
                            onPressed: childItem.onPressed,
                            childItems: childItem
                                .childItems, // Pass child items recursively
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
