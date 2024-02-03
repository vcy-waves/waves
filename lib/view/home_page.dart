import 'package:waves/services/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waves/components/tool_box.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/location.dart';
import 'host_event_page.dart';
import 'package:waves/constants.dart';

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
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
    NotificationService.initial(flutterLocalNotificationsPlugin);
    NotificationService.getNotificationOnFirebase(
      flutterLocalNotificationsPlugin,
    );
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                flex: 4,
                child: SizedBox(),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30, left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi Yi-Tong',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Playpen_Sans',
                                fontSize: 25.0,
                              ),
                            ),
                            Text(
                              'You have been clean up 5 times',
                              style: TextStyle(
                                fontFamily: 'Playpen_Sans',
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Row(
                        children: [
                          ToolBox(
                            color: Colors.blueGrey.shade300,
                            title: 'Clean\nUp',
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
                            title: 'Hold\nEvent',
                            icon: Icons.library_books_rounded,
                            iconColor: Colors.amber.shade500,
                            onTap: () async {
                              await NotificationService.promoteEvent(
                                notiType: NotiType.fine,
                                location: 'New Taipei City',
                                initiator: 'Chi-Yu',
                                flutterLocalNotificationsPlugin:
                                    flutterLocalNotificationsPlugin,
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ToolBox(
                            color: Colors.blueGrey.shade300,
                            title: 'Waves\nRank',
                            icon: Icons.star_outline_rounded,
                            iconColor: Colors.deepOrangeAccent.shade200,
                            onTap: () {},
                          ),
                          ToolBox(
                            color: Colors.blueGrey.shade300,
                            title: 'Needs\nHelp',
                            icon: Icons.help_rounded,
                            iconColor: Colors.green.shade300,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HostEventPage(
                                    location: Location(
                                      name: 'name',
                                      city: 'city',
                                      district: 'district',
                                      fullAddress: 'fullAddress',
                                      street: 'street',
                                      streetNumber: 'streetNumber',
                                      village: 'village',
                                      picture: 'picture',
                                      rate: 3,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
