import 'package:flutter/material.dart';
import 'package:waves/model/location.dart';
import 'host_event_page.dart';
import '../test_list.dart';
import 'rating_star.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({Key? key}) : super(key: key);

  @override
  State<ChooseLocationPage> createState() => _JointEventPageState();
}

class _JointEventPageState extends State<ChooseLocationPage> {
  List<GestureDetector> createEventList(List<Location> events) {
    List<GestureDetector> eventList = [];
    for (Location item in events) {
      eventList.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HostEventPage(
                  location: item,
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
                  leading: Image.asset("assets/images/${item.picture}"),
                  title: Row(
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      RatingStar(
                        rating: item.rate,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    item.fullAddress,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
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
            "Choose a Place！",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: createEventList(locations),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
