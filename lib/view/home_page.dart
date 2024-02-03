import 'package:waves/services/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waves/components/tool_box.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? location;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    NotificationService.getNotificationOnFirebase(
        flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/ocean/cover_1.jpg',
            opacity: const AlwaysStoppedAnimation(.5),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              left: 20,
              right: 20.0,
              bottom: 20.0,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                location ?? 'There is where you are',
                style:
                    const TextStyle(fontFamily: 'Playpen_Sans', fontSize: 20.0),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  height: 370,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 30, left: 20.0, bottom: 25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi Chi-Yu',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Playpen_Sans',
                                fontSize: 25.0,
                              ),
                            ),
                            Text(
                              'You have been clean up 3 times',
                              style: TextStyle(
                                fontFamily: 'Playpen_Sans',
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ToolBox(
                            color: Colors.blueGrey.shade300,
                            title: 'Clean  Up',
                            icon: Icons.opacity,
                            iconColor: Colors.blueAccent.shade200,
                            onTap: () async {
                              final url = Uri.parse(
                                  'https://www.google.com/maps/d/u/2/viewer?hl=zh-TW&ll=25.094785818256703,121.64989287560199&z=11&mid=1Gj56g49POVjUbeBmG_Pi_caT-r_7nuOX');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                          ),
                          ToolBox(
                            color: Colors.blueGrey.shade300,
                            title: 'Hold Event',
                            icon: Icons.library_books_rounded,
                            iconColor: Colors.amber.shade500,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                  title: Text('Hold Event ! ! !',
                                    style: TextStyle(
                                      fontFamily: 'Playpen_Sans',
                                      fontSize: 25.0,
                                    ),
                                  ),

                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ToolBox(
                            color: Colors.blueGrey.shade300,
                            title: 'Waves Rank',
                            icon: Icons.star_outline_rounded,
                            iconColor: Colors.deepOrangeAccent.shade200,
                            onTap: () {},
                          ),
                          ToolBox(
                            color: Colors.blueGrey.shade300,
                            title: 'Needs Help',
                            icon: Icons.help_rounded,
                            iconColor: Colors.green.shade300,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
