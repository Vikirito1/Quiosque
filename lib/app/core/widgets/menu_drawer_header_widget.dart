import 'package:flutter/material.dart';

class MenuDrawerHeaderWidget extends StatelessWidget {
  const MenuDrawerHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      alignment: Alignment.centerLeft,
      color: Theme.of(context).primaryColor,
      child: const DrawerHeader(
        margin: EdgeInsets.zero,
        child: SizedBox(
          width: double.maxFinite,
          child: Text(
            'Menu',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
