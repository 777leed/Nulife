import 'package:flutter/material.dart';
import 'Chameleon.dart';

class myAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String barTitle;
  const myAppBar({super.key, required this.barTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(barTitle),
      centerTitle: true,
      backgroundColor: chameleon.color_hunt[0],
      leading: BackButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      shadowColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);
}
