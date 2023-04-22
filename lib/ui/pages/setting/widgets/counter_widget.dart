import 'package:flutter/material.dart';

class ButtonCounter extends StatelessWidget {
  const ButtonCounter({
    Key? key,
    required this.displayZone,
    required this.countDown,
    required this.countUp,
  }) : super(key: key);

  final Widget displayZone;
  final Function() countDown;
  final Function() countUp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: countDown,
            icon: const Icon(Icons.keyboard_arrow_down_sharp)
        ),
        displayZone,
        IconButton(
            onPressed: countUp,
            icon: const Icon(Icons.keyboard_arrow_up_sharp)
        )
      ],
    );
  }
}
