import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(_controller);

    // Use the repeat method directly
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Row(
              children: [
                Icon(
                  Icons.sentiment_satisfied, // Replace with your desired icon
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text("En train d'écrire..."),
              ],
            ),
          ),
        );
      },
    );
  }
}
