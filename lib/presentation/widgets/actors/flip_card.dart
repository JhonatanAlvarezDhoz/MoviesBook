// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trending_movies/config/theme/theme_colors.dart';
import 'package:trending_movies/domain/entities/actor.dart';

class FlipCard extends ConsumerStatefulWidget {
  final List<Actor> actors;
  final int index;
  const FlipCard({
    super.key,
    required this.actors,
    required this.index,
  });

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends ConsumerState<FlipCard>
    with SingleTickerProviderStateMixin {
  bool isFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    isFront = !isFront;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _flipCard,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value * pi;
            bool isShowingFront = angle < pi / 2;
            return Stack(
              children: [
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // Esto agrega el efecto 3D
                    ..rotateY(angle),
                  alignment: Alignment.center,
                  child: isShowingFront
                      ? _buildFront(widget.index, widget.actors)
                      : _buildBack(widget.index, widget.actors),
                ),
                if (!isShowingFront)
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle + pi),
                    alignment: Alignment.center,
                    child: _buildBack(widget.index, widget.actors),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFront(int index, List<Actor> actors) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: 140,
        height: 180,
        child: Image.network(
          actors[index].profilePath ?? "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBack(int index, List<Actor> actors) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Colors.indigo,
                Color.fromRGBO(63, 81, 181, 0.5),
                Colors.indigo,
                Color.fromRGBO(63, 81, 181, 0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.03,
                0.3,
                0.57,
                0.8,
              ],
            )),
        width: 140,
        height: 180,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                actors[index].name,
                style: const TextStyle(
                    color: ThemeColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 120,
                child: Text(
                  "personaje:",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: ThemeColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                actors[index].character ?? "",
                style: const TextStyle(
                    color: ThemeColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
