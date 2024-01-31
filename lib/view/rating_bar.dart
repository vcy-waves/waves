import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  const RatingBar({Key? key}) : super(key: key);

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int rating = 0;
  String ratingComment = "rate this place";

  Color RankingStarColor(int starLocation) {
    Color color = Colors.grey;
    if (rating >= starLocation) {
      color = Colors.yellowAccent;
    } else {
      color = Colors.grey;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  rating = 1;
                  ratingComment = "Heavily littered";
                  setState(() {});
                },
                icon: Icon(
                  Icons.star,
                  color: RankingStarColor(1),
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  rating = 2;
                  ratingComment = "Noticeable pollution on the beach";
                  setState(() {});
                },
                icon: Icon(
                  Icons.star,
                  color: RankingStarColor(2),
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  rating = 3;
                  ratingComment = "Some areas show litter";
                  setState(() {});
                },
                icon: Icon(
                  Icons.star,
                  color: RankingStarColor(3),
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  rating = 4;
                  ratingComment = "Generally clean";
                  setState(() {});
                },
                icon: Icon(
                  Icons.star,
                  color: RankingStarColor(4),
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  rating = 5;
                  ratingComment = "With no litter or pollution";
                  setState(() {});
                },
                icon: Icon(
                  Icons.star,
                  color: RankingStarColor(5),
                  size: 50,
                ),
              ),
            ],
          ),
          Text(
            ratingComment,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
