import 'package:flutter/material.dart';
import 'rating_bar.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController commentController = TextEditingController();
  int rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: NotificationListener<RankingBarNotification>(
        onNotification: (notification) {
          rating = notification.ranking;
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "Leave your comment",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RatingBar(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: commentController,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    // minLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Leave your comment',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.white60),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 30, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0, left: 0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "back",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context,
                            [rating, commentController.text, DateTime.now()]);
                      },
                      child: const Text(
                        "post",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
