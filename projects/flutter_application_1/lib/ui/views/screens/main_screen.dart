import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/event_controller.dart';
import 'package:flutter_application_1/models/event_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/ui/views/functions/getDate.dart';
import 'package:flutter_application_1/ui/views/widgets/drawer_widget.dart';
import 'package:flutter_application_1/utils/app_constanst.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainScreen extends StatefulWidget {
  final UserModel currentUserData;

  MainScreen({Key? key, required this.currentUserData}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        centerTitle: true,
        actions: const [
          Icon(Icons.notifications_none_outlined),
          SizedBox(width: 20),
        ],
      ),
      drawer: DrawerWidget(currentUserData: widget.currentUserData),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: context.read<EventController>().fetchEventStream(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No events available'),
                );
              }

              // Process data from the first stream
              final events = snapshot.data!.docs
                  .map((doc) => EventModel.fromDocumentSnapshot(doc))
                  .toList();

              return Column(
                children: [
                  Text('Recent 7 days', style: AppConstants.mainTextStyle),
                  Container(
                    height: 300,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                      items: events.map((event) {
                        String period = event.dateTime.toDate().hour < 12
                            ? 'AM'
                            : 'PM';

                        String formattedDate =
                            '${event.dateTime.toDate().hour}:${event.dateTime.toDate().minute.toString().padLeft(2, '0')} $period '
                            '${Getdate.getMonthName(event.dateTime.toDate().month)} '
                            '${event.dateTime.toDate().day} ';

                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    event.imageUrl ??
                                        'https://t4.ftcdn.net/jpg/02/16/94/65/360_F_216946587_rmug8FCNgpDCPQlstiCJ0CAXJ2sqPRU7.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.black,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              event.dateTime
                                                  .toDate()
                                                  .day
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              Getdate.getMonthName(
                                                  event.dateTime
                                                      .toDate()
                                                      .month),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          child: Icon(Icons.favorite_outline),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('Description: ${event.description ?? 'No description'}'),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: context.read<EventController>().fetchEventStream(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No events available'),
                  );
                }

                // Process data from the second stream
                final events = snapshot.data!.docs
                    .map((doc) => EventModel.fromDocumentSnapshot(doc))
                    .toList();

                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    EventModel event = events[index];

                    String period =
                        event.dateTime.toDate().hour < 12 ? 'AM' : 'PM';

                    String formattedDate =
                        '${event.dateTime.toDate().hour}:${event.dateTime.toDate().minute.toString().padLeft(2, '0')} $period '
                        '${Getdate.getMonthName(event.dateTime.toDate().month)} '
                        '${event.dateTime.toDate().day} ';

                    final isLiked = event.likedUsers
                        .contains(FirebaseAuth.instance.currentUser!.uid);

                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.shade300, width: 1.0),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            margin: const EdgeInsets.only(right: 16.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7)),
                            width: 100,
                            height: 100,
                            child: Image.network(
                              event.imageUrl ??
                                  'https://t4.ftcdn.net/jpg/02/16/94/65/360_F_216946587_rmug8FCNgpDCPQlstiCJ0CAXJ2sqPRU7.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.title,
                                  style: AppConstants.mainTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'date: $formattedDate',
                                  style: AppConstants.eventInfotext,
                                ),
                                Text(
                                  'location: ${event.locationName!}',
                                  style: AppConstants.eventInfotext,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<EventController>()
                                  .toggleLike(event, context);
                            },
                            child: CircleAvatar(
                              child: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
