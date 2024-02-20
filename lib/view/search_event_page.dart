import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:waves/constants.dart';
import 'package:waves/model/post.dart';
import 'package:waves/services/post.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HostEventPage extends StatefulWidget {
  HostEventPage({super.key});

  @override
  State<HostEventPage> createState() => _HostEventPageState();
}

class _HostEventPageState extends State<HostEventPage>
    with TickerProviderStateMixin {
  List posts = [];
  final DateTime updateTime = DateTime(2024, 2, 13, 9, 10);
  bool isVisible = true;
  late final AnimationController _animationController;

  Future<void> updatePost() async {
    await PostService.fetchPosts();
    posts = PostService.post;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this);
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
              child: Center(
                child: Lottie.asset(
                  'assets/animations/Animation - 1708312765373.json',
                  controller: _animationController,
                  onLoaded: (composition) {
                    _animationController.duration = composition.duration;
                    _animationController.forward().then((value) {
                      _animationController.stop();
                      isVisible = false;
                      setState(() {});
                    });
                  },
                ),
              )),
          Visibility(
            visible: !isVisible,
            child: Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostWidget(
                    updateTime: PostService.lastUpdate(post: posts[index]),
                    image: posts[index].image,
                    location: posts[index].location,
                    initiator: posts[index].initiator,
                    id: posts[index].id,
                    like: PostService.fetchIsLiked(index),post: posts[index],
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
  PostWidget(
      {super.key,
      required this.updateTime,
      required this.image,
      required this.location,
      required this.initiator,
      required this.id,
      required this.like, required this.post});

  bool like;
  final String updateTime;
  final Image image;
  final String location;
  final String initiator;
  final int id;
  final Post post;

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
              backgroundImage: AssetImage('images/ocean/cover_7.JPG'),
            ),
            title: Text(
              widget.post.location,
              style: kSmallTitleTextStyle.copyWith(
                  fontFamily: 'ChenYuLuoYan',
                  fontSize: 23,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const Gap(10),
          widget.image,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last update : ${widget.updateTime} ago',
                style: kSmallTitleTextStyle.copyWith(
                  fontSize: 15.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.like = !widget.like;
                    PostService.updateLike(
                      post: widget.post,
                      isLiked: widget.like,
                      index: widget.id,
                    );
                    setState(() {});
                  });
                },
                icon: widget.like
                    ? const FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: Color(0xFFF28585),
                      )
                    : const FaIcon(
                        FontAwesomeIcons.heart,
                      ),
              ),
            ],
          ),
          Text(
            'Initiator : ${widget.initiator}',
            style: kSmallTitleTextStyle.copyWith(
              fontSize: 15.0,
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
