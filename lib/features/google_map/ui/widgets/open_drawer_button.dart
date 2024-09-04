
import 'package:flutter/material.dart';

class OpenDrawerButton extends StatelessWidget {
  const OpenDrawerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Container(
        height: 50,
        width: 48,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
            )),
        child: const Icon(Icons.menu),
      ),
    );
  }
}