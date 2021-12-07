import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseOperation extends StatefulWidget {
  const FirebaseOperation({Key? key}) : super(key: key);

  @override
  _FirebaseOperationState createState() => _FirebaseOperationState();
}

class _FirebaseOperationState extends State<FirebaseOperation> {
  Map? data;

  void createDb() {
    CollectionReference db = FirebaseFirestore.instance.collection('Database');
    db.add({'Name': 'Deepak', 'Mobile': '9770855576'});
  }

  void fetchDb() async {
    var collection = FirebaseFirestore.instance.collection('Database');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var name = data['Name'];
      var mobile = data['Mobile'];
    }
  }

  void updateDb() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Database');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference
        .update({"Name": "Raju", "Mobile": "8959056592"});
  }

  void deleteDb({required String docId}) async {
    final collection = FirebaseFirestore.instance.collection('Database');
    collection
        .doc(docId) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
  }

  @override
  void initState() {
    fetchDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('Database').snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView(
                    children: [
                      Center(
                        child: TextButton(
                          onPressed: () {
                            createDb();
                          },
                          child: const Text('Create'),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            fetchDb();
                          },
                          child: const Text('fetch'),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            updateDb();
                          },
                          child: const Text('update'),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            deleteDb(docId: snapshot.data!.docs[0].id);
                          },
                          child: const Text('delete'),
                        ),
                      ),
                      Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: snapshot.data!.size,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Text('${snapshot.data!.docs[index]['Name']}'),
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        deleteDb(
                                            docId:
                                                snapshot.data!.docs[index].id);
                                      })
                                ],
                              );
                            }),
                      )
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
