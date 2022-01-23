import 'package:flutter/material.dart';

class MenuDrawerTileWidget extends StatelessWidget {
  const MenuDrawerTileWidget({
    Key? key,
    required this.title,
    required this.leading,
    required this.selected,
    required this.routeName,
  }) : super(key: key);

  final String title;
  final Widget leading;
  final bool selected;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: leading,
      selectedTileColor: Theme.of(context).primaryColor,
      selectedColor: Colors.white,
      selected: selected,
      onTap: () => Navigator.of(context).pushReplacementNamed(routeName),
    );
  }
}
