import 'package:flutter/material.dart';
import 'package:waves/constants.dart';
import 'package:waves/components/post.dart';
import 'package:waves/services/post.dart';
import 'package:lottie/lottie.dart';
import 'package:waves/model/post.dart';

class HostEventPage extends StatefulWidget {
  const HostEventPage({super.key});

  @override
  State<HostEventPage> createState() => _HostEventPageState();
}

class _HostEventPageState extends State<HostEventPage>
    with TickerProviderStateMixin {
  List<Post> posts = [];
  final DateTime updateTime = DateTime(2024, 2, 13, 9, 10);
  bool isVisible = true;
  late final AnimationController _animationController;

  Future<void> updatePost() async {
    posts = await PostService.post;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.waves_rounded),
          ),
        ],
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
                    image: posts[index].image!,
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
