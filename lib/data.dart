import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/update_collection.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('waseem').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          print(snapshot.data);
          return ListView.builder(
              itemCount:snapshot.data!.docs.length,
              itemBuilder: (context,index){
                Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                //
                String id=snapshot.data!.docs[index].id;

                print("Id:$id");
                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['email']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdateCollection(id: id)));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async{
                          await FirebaseFirestore.instance.collection('waseem').doc(id).delete();
                        },
                      ),
                    ],
                  ),
                );
              });

        },
      ),
    );
  }
}



