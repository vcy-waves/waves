import 'package:flutter/material.dart';
import 'package:waves/model/event.dart';

class EventSignUpPage extends StatefulWidget {
  final BeachCleanUpEvent event;

  const EventSignUpPage({Key? key, required this.event}) : super(key: key);

  @override
  State<EventSignUpPage> createState() => _EventSignUpPageState();
}

class _EventSignUpPageState extends State<EventSignUpPage> {
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
            "Sing Up",
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
                widget.event.location,
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "Organizer：${widget.event.organizer}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Date：${widget.event.date.year}/${widget.event.date.month}/${widget.event.date.day}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Time：${widget.event.date.hour}:${widget.event.date.minute}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "participants：${widget.event.participants}",
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
            const Text(
              "Do you need tool?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                SizedBox(
                  width: 175,
                  child: ListTile(
                    title: const Text(
                      "Yes",
                      style: TextStyle(fontSize: 20),
                    ),
                    leading: Radio(
                      value: true,
                      groupValue: isToolNeeded,
                      onChanged: (value) {
                        isToolNeeded = true;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 175,
                  child: ListTile(
                    title: const Text(
                      "No",
                      style: TextStyle(fontSize: 20),
                    ),
                    leading: Radio(
                      value: false,
                      groupValue: isToolNeeded,
                      onChanged: (value) {
                        isToolNeeded = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    [nameController.text, phoneController.text, isToolNeeded],
                  );
                },
                child: const Text(
                  "submit",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
