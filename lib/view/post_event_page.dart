import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:waves/constants.dart';
import 'package:waves/components/customer_search_delegate.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waves/services/post.dart';
import 'package:waves/services/account.dart';
import 'package:waves/components/rating_bar.dart';
import 'package:waves/view/home_page.dart';

class PostEventPage extends StatefulWidget {
  const PostEventPage({super.key});

  @override
  State<PostEventPage> createState() => _PostEventPageState();
}

class _PostEventPageState extends State<PostEventPage> {
  final ImagePicker _picker = ImagePicker();
  final FocusNode _focus = FocusNode();
  final _fieldText = TextEditingController();
  String _locationName = '';
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  TimeOfDay? _time;
  Uint8List? _image;
  XFile? image;
  int likes = 0;
  int rating = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AccountService.fetchAccount();
    _focus.addListener(() {
      showSearch(
        context: context,
        delegate: CustomSearchDelegate(queryLocation: (locationName) {
          _locationName = locationName;
          _fieldText.text = _locationName;
        }),
      );
      _focus.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade300,
        title: const Text(
          'Waves',
          style: kSmallTitleTextStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () async {
              image = await _picker.pickImage(source: ImageSource.gallery);
              _image = await image!.readAsBytes();
              setState(() {});
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300.withOpacity(0.7),
        onPressed: () async {
          if (image != null) {
            await PostService.postPost(
              location: _locationName,
              initiator: AccountService.account['name'],
              lastUpdate: _selectedDay,
              image: image!,
              likes: likes,
              email: AccountService.account['email'],
              rating: rating,
            );
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Rate This Ocean now ! !',
                style: kSmallTitleTextStyle,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (rating != 0) {
                      await PostService.postPost(
                        email: AccountService.account['email'],
                        likes: likes,
                        location: _locationName,
                        initiator: AccountService.account['name'],
                        lastUpdate: _selectedDay,
                        image: image!,
                        rating: rating,
                      );
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                  child: const Text('Post'),
                ),
              ],
              content: RatingBar(
                update: (value) {
                  rating = value;
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.send),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              focusNode: _focus,
              controller: _fieldText,
              onChanged: (value) {
                _locationName = value;
              },
              decoration: kSearchBarInputDecoration,
            ),
          ),
          TableCalendar(
            calendarFormat: CalendarFormat.twoWeeks,
            currentDay: _selectedDay,
            focusedDay: _focusedDay,
            firstDay: DateTime(2023),
            lastDay: DateTime(2025),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          const Gap(10),
          TextButton(
            onPressed: () async {
              _time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              setState(() {});
            },
            child: Text(
              'Pick up a time to clean up',
              style: kSmallTitleTextStyle.copyWith(color: Colors.blue),
            ),
          ),
          _time != null
              ? Text(
                  '${_time!.hour} : ${_time!.minute}',
                  style: kSmallTitleTextStyle,
                )
              : const SizedBox(),
          const Gap(30.0),
          _image != null
              ? Expanded(child: Image.memory(_image!))
              : const SizedBox(),
          const MaxGap(1),
        ],
      ),
    );
  }
}
