import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: <Widget>[
          for (var i = 0; i < rating; i++)
            Icon(
              Icons.star,
              color: Colors.yellow.shade700,
            ),
          for (var i = 0; i < 5 - rating; i++)
            Icon(
              Icons.star,
              color: Colors.grey.shade300,
            )
        ],
      ),
    );
  }
}
