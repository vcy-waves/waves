import 'package:flutter/material.dart';
import 'package:waves/constants.dart';

class RankingBarNotification extends Notification {
  RankingBarNotification(this.ranking);

  final int ranking;
}

class RatingBar extends StatefulWidget {
  RatingBar({
    super.key,
    required this.update,
  });

  Function(int) update;

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
    return Column(
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
                widget.update(1);
                setState(() {});
              },
              icon: Icon(
                Icons.star,
                color: rankingStarColor(1),
              ),
            ),
            IconButton(
              onPressed: () {
                rating = 2;
                RankingBarNotification(rating).dispatch(context);
                ratingComment = "Noticeable pollution on the beach";
                widget.update(2);
                setState(() {});
              },
              icon: Icon(
                Icons.star,
                color: rankingStarColor(2),
              ),
            ),
            IconButton(
              onPressed: () {
                rating = 3;
                RankingBarNotification(rating).dispatch(context);
                ratingComment = "Some areas show litter";
                widget.update(3);
                setState(() {});
              },
              icon: Icon(
                Icons.star,
                color: rankingStarColor(3),
              ),
            ),
            IconButton(
              onPressed: () {
                rating = 4;
                RankingBarNotification(rating).dispatch(context);
                ratingComment = "Generally clean";
                widget.update(4);
                setState(() {});
              },
              icon: Icon(
                Icons.star,
                color: rankingStarColor(4),
              ),
            ),
            IconButton(
              onPressed: () {
                rating = 5;
                RankingBarNotification(rating).dispatch(context);
                ratingComment = "With no litter or pollution";
                widget.update(5);
                setState(() {});
              },
              icon: Icon(
                Icons.star,
                color: rankingStarColor(5),
              ),
            ),
          ],
        ),
        Text(
          ratingComment,
          style: kSmallTitleTextStyle.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
