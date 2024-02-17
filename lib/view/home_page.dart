import 'package:waves/services/account.dart';
import 'package:waves/services/notification.dart';
import 'package:waves/view/login_page.dart';
import 'package:waves/view/search_event_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waves/components/tool_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waves/view/profile_page.dart';
import 'dart:io' show Platform;
import 'package:waves/view/post_event_page.dart';
import 'package:waves/constants.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initService();
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
    NotificationService.initial(flutterLocalNotificationsPlugin);
    NotificationService.getNotificationOnFirebase(
      flutterLocalNotificationsPlugin,
    );
    update();
  }

  Future<void> update() async {
    await AccountService.fetchAccount();
    setState(() {});
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
          const Padding(
            padding: EdgeInsets.only(
              top: 50.0,
              left: 20,
              right: 20.0,
              bottom: 20.0,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'There is where you are',
                style: TextStyle(fontFamily: 'Playpen_Sans', fontSize: 20.0),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 20.0),
                        child: GestureDetector(
                          onDoubleTap: () async {
                            await AccountService.logout();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi ${AccountService.account['name']}',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'Playpen_Sans',
                                  fontSize: 25.0,
                                ),
                              ),
                              const Text(
                                'You have been clean up 5 times',
                                style: TextStyle(
                                  fontFamily: 'Playpen_Sans',
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
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
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const PostEventPage()));
                              await NotificationService.promoteEvent(
                                notiType: NotiType.fine,
                                initiator: 'chiyu',
                                location: 'location',
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
                            title: 'Search\nEvent',
                            icon: Icons.search_rounded,
                            iconColor: Colors.deepOrangeAccent.shade200,
                            onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SearchPostPage(),
                                ),
                              );
                            },
                          ),
                          ToolBox(
                            color: Colors.blueGrey.shade300,
                            title: 'Setup\nProfile',
                            icon: Icons.help_rounded,
                            iconColor: Colors.green.shade300,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                    email: AccountService.account['email'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
