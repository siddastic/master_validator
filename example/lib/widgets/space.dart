import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double space;
  final bool isHorizontal;
  const Space(this.space, {super.key, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) return SizedBox(width: space);
    return SizedBox(height: space);
  }

  static Widget get def {
    return const Space(10);
  }

  static get horizontal {
    return const Space(
      15,
      isHorizontal: true,
    );
  }
}
