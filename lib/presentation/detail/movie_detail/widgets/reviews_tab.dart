import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';

class ReviewsTab extends StatelessWidget {
  final MovieDetailModel movie;

  const ReviewsTab({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    if (movie.reviews.isEmpty) {
      return NotFound(
        image: 'assets/movie.png',
        title: 'No reviews found',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 16),
      itemCount: movie.reviews.length,
      itemBuilder: (context, index) {
        final review = movie.reviews[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/40'),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.author,
                        style: TextStyle(
                          color: getTextColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            review.rating.toString(),
                            style: TextStyle(
                              color: getTextColor(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                review.content,
                style: TextStyle(
                  color: getTextColor(context),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
