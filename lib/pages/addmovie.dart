import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_fiebase/components/background.dart';
import 'package:project_flutter_fiebase/pages/homepage.dart';



class AddMovie extends StatefulWidget {
  AddMovie({Key key}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final TextEditingController _name= TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _type= TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  final CollectionReference _movie =
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
                      "Add Movie",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30),
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
                              return 'Please Enter Movie Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _date,
                          decoration: InputDecoration(
                              labelText: 'Date',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Date';
                            }
                            return null;
                          },
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
                              return 'Please Enter Movie Type';
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
                              return 'Please enter Time ';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _desc,
                          decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Description ';
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
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    await _movie
                                        .add({
                                          "name": _name.text,
                                          "date":_date.text,
                                          "type": _type.text,
                                          "time": double.parse(_time.text),
                                          "desc":_desc.text,
                                        })
                                        .then((value) => print("Movie Updated"))
                                        .catchError((error) =>
                                        print("Failed to update movie : $error"));

                                    _name.text = '';
                                    _date.text = '';
                                    _type.text = '';
                                    _time.text = '';
                                    _desc.text = '';

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
