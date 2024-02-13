import 'package:flutter/material.dart';

class RatingStar extends StatefulWidget {
  double rating;
  RatingStar({Key? key, required this.rating}) : super(key: key);

  @override
  State<RatingStar> createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  List<double> shineStar = [0, 0, 0, 0, 0];

  void setStar(double rating) {
    shineStar = [0, 0, 0, 0, 0];
    for (int i = 0; i < 5; i++) {
      if ((rating - i) >= 1) {
        shineStar[i] = 1;
      } else if ((rating - i) >= 0) {
        shineStar[i] = rating - i;
      } else {
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setStar(widget.rating);

    return Placeholder(
      child: SizedBox(
        height: 30,
        width: 125,
        child: Row(
          children: [
            Stack(
              children: <Widget>[
                const Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: shineStar[0],
                    child: const Icon(
                      Icons.star,
                      color: Colors.yellowAccent,
                    ),
                  ),
                )
              ],
            ),
            Stack(
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: shineStar[1],
                    child: Icon(
                      Icons.star,
                      color: Colors.yellowAccent,
                    ),
                  ),
                )
              ],
            ),
            Stack(
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: shineStar[2],
                    child: Icon(
                      Icons.star,
                      color: Colors.yellowAccent,
                    ),
                  ),
                )
              ],
            ),
            Stack(
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: shineStar[3],
                    child: Icon(
                      Icons.star,
                      color: Colors.yellowAccent,
                    ),
                  ),
                )
              ],
            ),
            Stack(
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: shineStar[4],
                    child: Icon(
                      Icons.star,
                      color: Colors.yellowAccent,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
