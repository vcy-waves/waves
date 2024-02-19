import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:waves/constants.dart';
import 'package:waves/components/customer_search_delegate.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waves/services/post.dart';
import 'package:waves/services/account.dart';

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
  TimeOfDay? _time;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
        backgroundColor: Colors.blueGrey.shade100,
        title: const Text(
          'Waves',
          style: kSmallTitleTextStyle,
        ),
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
            focusedDay: DateTime.now(),
            currentDay: _selectedDay,
            firstDay: DateTime(2023),
            lastDay: DateTime(2025),
            onDaySelected: (selectDay, anotherDay) {
              setState(() {
                _selectedDay = selectDay;
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
            child: const Text(
              'Pick up a time to clean up',
              style: kSmallTitleTextStyle,
            ),
          ),

          TextButton(
            onPressed: () async {
              XFile? image =
                  await _picker.pickImage(source: ImageSource.camera);
              if (image != null)
                PostService.postPost(
                    location: _locationName,
                    initiator: AccountService.account['email'],
                    lastUpdate: _selectedDay,
                    image: image);
            },
            child: const Text(
              'Upload Current Image',
              style: kSmallTitleTextStyle,
            ),
          ),
          const MaxGap(1),
        ],
      ),
    );
  }
}

