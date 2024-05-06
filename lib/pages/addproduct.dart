import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_fiebase/components/background.dart';
import 'package:project_flutter_fiebase/pages/homepage.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _decs = TextEditingController();

  final CollectionReference _foods =
  FirebaseFirestore.instance.collection('movie');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "ADD MOVIE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 36),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                      // prevent the soft keyboard from covering text fields
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // email
                        TextFormField(
                          controller: _name,
                          decoration: InputDecoration(
                              labelText: 'Movie Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Movie Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _time,
                          decoration: InputDecoration(
                              labelText: 'Time',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Time';
                            }
                            return null;
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _type,
                          decoration: InputDecoration(
                              labelText: 'Movie Type',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Movie Type';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _decs,
                          decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Description';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              color: Colors.red,
                              hoverColor: Colors.red[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNav()));
                              },
                            ),
                            RaisedButton(
                                color: Colors.blue,
                                hoverColor: Colors.blue[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  'Create',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    await _foods
                                        .add({
                                      "name": _name.text,
                                      "time":
                                      double.tryParse(_time.text),
                                      "type": _type.text,
                                      "decs": _decs.text,
                                    })
                                        .then((value) => print("Movie Added"))
                                        .catchError((error) => print(
                                        "Failed to add Movie: $error" +
                                            _time.text));

                                    _name.text = '';
                                    _time.text = '';
                                    _type.text = '';
                                    _decs.text = '';

                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => BottomNav()),
                                            (Route<dynamic> route) => false);
                                  }
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
