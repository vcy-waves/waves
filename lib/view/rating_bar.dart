import 'package:flutter/material.dart';

class RankingBarNotification extends Notification {
  RankingBarNotification(this.ranking);
  final int ranking;
}

class RatingBar extends StatefulWidget {
  const RatingBar({Key? key}) : super(key: key);

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int rating = 0;
  String ratingComment = "rate this place";

  Color rankingStarColor(int starLocation) {
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
                  RankingBarNotification(rating).dispatch(context);
                  ratingComment = "Heavily littered";
                  setState(() {});
                },
                icon: Icon(
                  Icons.star,
                  color: rankingStarColor(1),
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  rating = 2;
                  RankingBarNotification(rating).dispatch(context);
                  ratingComment = "Noticeable pollution on the beach";
                  setState(() {});
                },
                icon: Icon(
                  Icons.star,
                  color: rankingStarColor(2),
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  rating = 3;
                  RankingBarNotification(rating).dispatch(context);
                  ratingComment = "Some areas show litter";
                  setState(() {});
                },
                icon: Icon(
                  Icons.star,
                  color: rankingStarColor(3),
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  rating = 4;
                  RankingBarNotification(rating).dispatch(context);
                  ratingComment = "Generally clean";
                  setState(() {});
                },
                icon: Icon(
                  Icons.star,
                  color: rankingStarColor(4),
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  rating = 5;
                  RankingBarNotification(rating).dispatch(context);
                  ratingComment = "With no litter or pollution";
                  setState(() {});
                },
                icon: Icon(
                  Icons.star,
                  color: rankingStarColor(5),
                  size: 50,
                ),
              ),
            ],
          ),
          Text(
            ratingComment,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
