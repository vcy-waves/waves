import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:waves/constants.dart';
import 'package:waves/services/post.dart';

class HostEventPage extends StatefulWidget {
  HostEventPage({super.key});

  @override
  State<HostEventPage> createState() => _HostEventPageState();
}

class _HostEventPageState extends State<HostEventPage> {
  List posts = [];
  final DateTime updateTime = DateTime(2024, 2, 13, 9, 10);

  @override
  void initState() {
    // TODO: implement initState
    PostService.fetchPosts();
    posts = PostService.post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        title: const Text(
          'Waves',
          style: kSmallTitleTextStyle,
        ),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostWidget(
            updateTime: DateTime.now(),
            image: posts[index].image,
            location: posts[index].location,
            initiator: posts[index].initiator,
          );
        },
      ),
    );
  }
}

class PostWidget extends StatefulWidget {
  const PostWidget({
    super.key,
    required this.updateTime,
    required this.image,
    required this.location,
    required this.initiator,
  });

  final DateTime updateTime;
  final Image image;
  final String location;
  final String initiator;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  AssetImage('images/ocean/baishawan/baishawan1.jpg'),
            ),
            title: Text('location name', style: kSmallTitleTextStyle),
          ),
          const Gap(10),
          widget.image,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last update : ${DateTime.now().difference(widget.updateTime).inHours} hr ago',
                style: kSmallTitleTextStyle.copyWith(
                  fontSize: 17.0,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.house),
              ),
            ],
          ),
          const Gap(10),
          const Divider(
            height: 0.1,
          ),
        ],
      ),
    );
  }
}
