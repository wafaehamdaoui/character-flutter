import 'package:character/models/character.dart';
import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({super.key, required this.character});

  final Character character;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation _sizedAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _sizedAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween(begin: 25,end: 40), 
        weight: 50
      ),
      TweenSequenceItem<double>(
        tween: Tween(begin: 40,end: 25), 
        weight: 50
      ),
    ]).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: widget.character.isFav ? Colors.red : Colors.grey[800],
            size: _sizedAnimation.value,
          ),
          onPressed: () {
            _controller.reset();
            _controller.forward();
            widget.character.toggleiIsFav();
          } ,
        );
      }
    );
  }
}