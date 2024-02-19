import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:waves/constants.dart';
import 'package:waves/services/post.dart';
import 'package:waves/test_list.dart';

class HostEventPage extends StatefulWidget {
  HostEventPage({super.key});

  @override
  State<HostEventPage> createState() => _HostEventPageState();
}

class _HostEventPageState extends State<HostEventPage> {
  List posts = [];
  final DateTime updateTime = DateTime(2024, 2, 13, 9, 10);
  bool isVisible = true;

  Future<void> updatePost() async {
    await PostService.fetchPosts();
    posts = PostService.post;
    isVisible = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    updatePost();
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
      body: Column(
        children: [
          Visibility(
            visible: isVisible,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
          ),
          Visibility(
            visible: !isVisible,
            child: Expanded(
              child: ListView.builder(
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
            ),
          ),
        ],
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
          ListTile(
            leading: const CircleAvatar(
              backgroundImage:
                  AssetImage('images/ocean/baishawan/baishawan1.jpg'),
            ),
            title: Text(widget.location, style: kSmallTitleTextStyle),
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
          Text(
            'Initiator : ${widget.initiator}',
            style: kSmallTitleTextStyle.copyWith(
              fontSize: 17.0,
            ),
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
