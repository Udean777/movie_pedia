import 'package:flutter/material.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';

class NotFound extends StatelessWidget {
  final String image;
  final String title;

  const NotFound({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 100,
            height: 100,
          ),
          Text(
            title,
            style: TextStyle(
              color: getTextColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
