import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waves/constants.dart';
import 'package:waves/model/post.dart';
import 'package:waves/services/post.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    super.key,
    required this.post,
  });

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
          widget.post.image!,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last update : ${PostService.lastUpdate(post: widget.post)}',
                style: kSmallTitleTextStyle.copyWith(
                  fontSize: 15.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.post.like = !widget.post.like;
                  });
                },
                icon: widget.post.like
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
            'Initiator : ${widget.post.initiator}',
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
