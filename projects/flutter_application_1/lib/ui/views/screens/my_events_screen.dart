import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/event_controller.dart';
import 'package:flutter_application_1/models/event_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/ui/views/functions/getDate.dart';
import 'package:flutter_application_1/ui/views/widgets/add_event_widget.dart';
import 'package:flutter_application_1/ui/views/widgets/drawer_widget.dart';
import 'package:flutter_application_1/ui/views/widgets/edit_event_widget.dart';
import 'package:flutter_application_1/ui/views/widgets/organized_widget.dart';
import 'package:flutter_application_1/utils/app_constanst.dart';
import 'package:provider/provider.dart';

class MyEventsScreen extends StatefulWidget {
  final UserModel currentUserData;
  MyEventsScreen({Key? key, required this.currentUserData}) : super(key: key);

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My events', style: AppConstants.mainTextStyle),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.notifications_none_outlined),
            ),
          ],
          bottom: TabBar(
            indicatorColor: AppConstants.orangeColor,
            labelColor: AppConstants.orangeColor,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Tashkil qilinganlarim'),
              Tab(text: 'Yaqinda'),
              Tab(text: 'Ishtirok etganlarim'),
              Tab(text: 'Bekor qilinganlar'),
            ],
          ),
        ),
        drawer: DrawerWidget(currentUserData: widget.currentUserData),
        body: TabBarView(
          children: [
            OrganizedWidget(),
            PlaceholderWidget(label: 'Yaqinda'),
            PlaceholderWidget(label: 'Ishtirok etganlarim'),
            PlaceholderWidget(label: 'Bekor qilinganlar'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddEventWidget()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String label;

  const PlaceholderWidget({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label),
    );
  }
}
