
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'data.dart';


class UpdateCollection extends StatefulWidget {
  const UpdateCollection({super.key,required this.id});


  final String id;

  @override
  State<UpdateCollection> createState() => _UpdateCollectionState();
}

class _UpdateCollectionState extends State<UpdateCollection> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;




  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // Map<String,dynamic>? data;
  getData()async{
    DocumentSnapshot<Map<String, dynamic>> data=await FirebaseFirestore.instance.collection('waseem').doc(widget.id).get();
print("data:${data.data()}");
_nameController.text=data.data()!['name'];
_emailController.text=data.data()!['email'];
_ageController.text=data.data()!['age'];

  }
  @override
  void deactivate() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
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
                onPressed: _updateData,
                child: Text('Update')),


          ],
        ),
      ),
    );
  }

  void _updateData() async {
    try {
      // Reference to the Firestore collection
      CollectionReference users = _firestore.collection('waseem');

      // Data to be added
      // Add the data to the collection
      await users.doc(widget.id).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'age': _ageController.text,
      });
      _nameController.clear();
      _emailController.clear();
      _ageController.clear();

      print('Data Updated successfully!');
      Navigator.pop(context);
    } catch (e) {
      print('Error adding data: $e');
    }
  }
}



