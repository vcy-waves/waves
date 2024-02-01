import 'package:flutter/material.dart';
import 'package:waves/model/event.dart';
import 'choose_location_page.dart';
import 'event_sign_up_page.dart';
import '../test_list.dart';

class JointEventPage extends StatefulWidget {
  const JointEventPage({Key? key}) : super(key: key);

  @override
  State<JointEventPage> createState() => _JointEventPageState();
}

class _JointEventPageState extends State<JointEventPage> {
  List<GestureDetector> createEventList(List<BeachCleanUpEvent> events) {
    List<GestureDetector> eventList = [];
    for (BeachCleanUpEvent item in events) {
      eventList.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventSignUpPage(
                  event: item,
                ),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            color: Colors.white70,
            shadowColor: Colors.blueGrey,
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    leading:
                        Image.asset("assets/images/${item.location.picture}"),
                    title: Text(
                      item.location.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      "${item.location.fullAddress}\norganizer：${item.organizer}",
                      style: const TextStyle(fontSize: 15),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          "${item.date.month}/${item.date.day} ${item.time.hour}:${item.time.minute} ",
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          "participants：${item.participants}",
                          style: const TextStyle(fontSize: 15),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
    }
    return eventList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Joint A Event！",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: createEventList(events),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, left: 40),
              child: Text(
                "Or create one →",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChooseLocationPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
