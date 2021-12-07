import 'package:flutter/material.dart';

class ContactsListPage extends StatefulWidget {
  final List<dynamic>? connections;

  const ContactsListPage({Key? key, required this.connections})
      : super(key: key);

  @override
  _ContactsListPageState createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.connections!.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(
              widget.connections![index]['names'][0]['givenName'].toString());
        },
      ),
    );
  }
}
