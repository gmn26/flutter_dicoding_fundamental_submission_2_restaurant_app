import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.counter});

  final int counter;

  List<Icon> insertStar(int counter) {
    List<Icon> stars = [];
    for (int i = 1; i <= counter; i++) {
      stars.add(const Icon(
        Icons.star,
        color: Color.fromARGB(255, 255, 188, 2),
      ));
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    List<Icon> rateStars = insertStar(counter);

    return Row(
      children: rateStars,
    );
  }
}
