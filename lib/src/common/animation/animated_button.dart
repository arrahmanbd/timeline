import 'package:flutter/material.dart';
import 'package:simple_animated_icon/simple_animated_icon.dart';

class AnimatedIconButton extends StatefulWidget {
  final IconData firstIcon;
  final IconData lastIcon;
  const AnimatedIconButton({
    Key? key,
    required this.firstIcon,
    required this.lastIcon,
  }) : super(key: key);

  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  bool _isOpened = false;
  late AnimationController _animationController;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            // call `build` on animation progress
            setState(() {});
          });

    _progress =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    if (_isOpened) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _isOpened = !_isOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: animate,
        iconSize: 48.0,
        icon: SimpleAnimatedIcon(
          color: Colors.black,
          // customize icon color
          size: 24.0,
          // customize icon size
          startIcon: widget.firstIcon,
          endIcon: widget.lastIcon,
          progress: _progress,
          transitions: [Transitions.zoom_in, Transitions.slide_in_left],
        ));
  }
}
