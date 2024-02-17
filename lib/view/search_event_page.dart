import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:waves/constants.dart';

class SearchPostPage extends StatelessWidget {
  final DateTime updateTime = DateTime(2024, 2, 13, 9, 10);

  SearchPostPage({super.key});

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
      body: ListView(
        children: [
          PostWidget(updateTime: updateTime),
          PostWidget(updateTime: updateTime),
          PostWidget(updateTime: updateTime)
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.updateTime,
  });

  final DateTime updateTime;

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
          Image.asset('images/ocean/baishawan/baishawan1.jpg'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last update : ${DateTime.now().difference(updateTime).inHours} hr ago',
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
