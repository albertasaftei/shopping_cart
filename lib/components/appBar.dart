import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final bool? showBackArrow;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final Color? backArrowColor;

  const MyAppBar({
    super.key,
    this.title = const Text(
      '',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    this.actions,
    this.backgroundColor,
    this.elevation = 0.0,
    this.showBackArrow = false,
    this.leadingIcon,
    this.onLeadingPressed,
    this.backArrowColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: title,
      leading: showBackArrow!
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) => backArrowColor,
                ),
              ),
            )
          : IconButton(
              onPressed: onLeadingPressed,
              icon: Icon(leadingIcon),
            ),
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56.0);
}
