import 'package:flutter/material.dart';
import 'package:waves/model/location.dart';

class HostEventPage extends StatefulWidget {
  final Location location;
  String dateText = "Choose a Date";
  DateTime date = DateTime.now();
  String timeText = "Choose a Time";
  TimeOfDay time = TimeOfDay.now();
  HostEventPage({Key? key, required this.location}) : super(key: key);

  @override
  State<HostEventPage> createState() => _HostEventPageState();
}

class _HostEventPageState extends State<HostEventPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool? isToolNeeded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            "Host an Event！",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
          ),
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                widget.location.name,
                style:
                const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "address：${widget.location.fullAddress}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Leave your information",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                controller: nameController,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'name',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 30),
              child: TextField(
                controller: phoneController,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'phone number',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    widget.date = (await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100, 12),
                    ))!;
                    widget.dateText =
                    "${widget.date.year}/${widget.date.month}/${widget.date.day}";
                    setState(() {});
                  },
                  child: Text(
                    widget.dateText,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    widget.time = (await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    ))!;
                    widget.timeText =
                    "${widget.time.hour}:${widget.time.minute}";
                    setState(() {});
                  },
                  child: Text(
                    widget.timeText,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      [
                        widget.location.name,
                        nameController.text,
                        widget.location.fullAddress,
                        phoneController.text,
                        widget.date,
                        widget.time,
                      ],
                    );
                  },
                  child: const Text(
                    "submit",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}