
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'data.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  @override
  void deactivate() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    // TODO: implement deactivate
    super.deactivate();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Center(child: Text('CRUD')),
      ),
      body: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                // initialValue: counter.toString(),
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ), Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                // initialValue: counter.toString(),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ), Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                // initialValue: counter.toString(),
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            ElevatedButton(
                onPressed: _addData,
                child: Text('Subscribe')),
            
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DataScreen()));
            }, child: Text('Get Data'))
          ],
        ),
      ),
    );
  }

  void _addData() async {
    try {
      // Reference to the Firestore collection
      CollectionReference users = _firestore.collection('waseem');

      // Data to be added
      String docId=DateTime.now().millisecondsSinceEpoch.toString();
      print("docId:$docId");
      // Add the data to the collection
      await users.doc(docId).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'age': _ageController.text,
      });
      _nameController.clear();
      _emailController.clear();
      _ageController.clear();

      print('Data added successfully!');
    } catch (e) {
      print('Error adding data: $e');
    }
  }
}



