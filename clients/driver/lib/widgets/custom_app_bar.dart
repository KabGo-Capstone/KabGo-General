import 'package:driver/widgets/build_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function? onBackTap;
  final bool showBackArrow;
  final Color? backgroundColor;
  final List<Widget>? actionWidgets;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.onBackTap,
      this.showBackArrow = true,
      this.backgroundColor = Colors.white,
      this.actionWidgets});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: true,
      elevation: 0,
      actions: actionWidgets,
      title: Row(
        children: [
          buildText(title, Colors.black, 16, FontWeight.w500, TextAlign.start,
              TextOverflow.clip),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
