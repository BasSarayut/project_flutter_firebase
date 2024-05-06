import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_flutter_fiebase/components/background.dart';
import 'package:project_flutter_fiebase/pages/about.dart';
import 'package:project_flutter_fiebase/pages/addproduct.dart';
import 'package:project_flutter_fiebase/components/authentication.dart';
import 'package:project_flutter_fiebase/pages/chart.dart';
import 'package:project_flutter_fiebase/pages/login.dart';
import 'package:project_flutter_fiebase/pages/profile.dart';
import 'package:project_flutter_fiebase/components/signin_google.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _decs = TextEditingController();
  // Create a CollectionReference called _products that references the firestore collection
  final CollectionReference _movie =
  FirebaseFirestore.instance.collection('movie');

  Future<void> _Update([DocumentSnapshot documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _name.text = documentSnapshot['name'];
      _time.text = documentSnapshot['time'].toString();
      _type.text = documentSnapshot['type'].toString();
      _decs.text = documentSnapshot['decs'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 80),
            child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _name,
                      decoration: const InputDecoration(labelText: 'Movie Name'),
                    ),
                    TextField(
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      controller: _time,
                      decoration: const InputDecoration(
                        labelText: 'Time',
                      ),
                    ),
                    TextField(
                      controller: _type,
                      decoration: const InputDecoration(
                        labelText: 'Movie Type',
                      ),
                    ),
                    TextField(
                      controller: _decs,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    SizedBox(height: 30),
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
                            Navigator.pop(context);
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
                          onPressed: () {
                            _movie
                                .doc(documentSnapshot.id)
                                .update({
                              "name": _name.text,
                              "time": double.parse(_time.text),
                              "type": _type.text,
                              "decs": _decs.text
                            })
                                .then((value) => print("Food Updated"))
                                .catchError((error) =>
                                print("Failed to update food: $error"));

                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          );
        });
  }

  Future<void> _deleteFood(String foodID) async {
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove Movie?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box

                    _movie
                        .doc(foodID)
                        .delete()
                        .then((value) => print("Movie Deleted"))
                        .catchError(
                            (error) => print("Failed to delete movie: $error"));
                    // Close the dialog
                    Navigator.of(context).pop();

                    // Show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You have successfully deleted a movie')));
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Material(
          color: Colors.amberAccent.shade100,
          child: ListView
            (padding: EdgeInsets.symmetric(horizontal: 50, vertical: 70),
              children:<Widget>[
                const DrawerHeader(
                  margin: EdgeInsets.zero,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage('assets/images/ava.jpg'),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.local_movies_rounded),
                  title: const Text('Movies'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
                  },
                ),
                Divider(
                  color: Colors.black12,
                  indent: 30,
                  endIndent: 30,
                ),
                ListTile(
                  leading: Icon(Icons.add_box_rounded),
                  title: const Text('ADD MOVIES'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddProduct(),
                    ));
                  },
                ),
                Divider(
                  color: Colors.black12,
                  indent: 30,
                  endIndent: 30,
                ),
                ListTile(
                  leading: Icon(Icons.stacked_bar_chart_rounded),
                  title: const Text('CHART'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Chart(),
                    ));
                  },
                ),
                Divider(
                  color: Colors.black12,
                  indent: 30,
                  endIndent: 30,
                ),
                ListTile(
                  leading: Icon(Icons.people_alt_rounded),
                  title: const Text('ABOUT'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => About(),
                    ));
                  },
                ),
                Divider(
                  color: Colors.black12,
                  indent: 30,
                  endIndent: 30,
                ),
                ListTile(
                  leading: Icon(Icons.person_rounded),
                  title: const Text('PROFILE'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Profile(),
                    ));
                  },
                ),
                Divider(
                  color: Colors.black12,
                  indent: 30,
                  endIndent: 30,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: const Text(
                    'LOGOUT',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () async {
                    await handleSignOut().whenComplete(() => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => (Login())),
                    ));
                    AuthenticationHelper().signOut().then(
                          (_) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (contex) => Login()),
                      ),
                    );
                  },
                ),
              ]
          ),
        ),
      ),
      appBar: AppBar(
        // systemOverlayStyle:
        //     SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        title: Text(
          "MOVIE",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Background(
        child: StreamBuilder(
          stream: _movie.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data.docs[index];
                  return Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Card(
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 8,
                      child: Container(
                        child: Center(
                          child: ListTile(
                            title: Text(
                              documentSnapshot['name'],
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              "เวลา : " +
                                  documentSnapshot['time'].toString() +
                                  " นาที"+
                                  "\n" +
                                  "ประเภทหนัง" +
                                  " : " +
                                  documentSnapshot['type'].toString() +
                                  "\n" +
                                  "รายละเอียดหนัง" +
                                  " : " +
                                  documentSnapshot['decs'].toString(),
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  // Press this button to edit a single product
                                  IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () =>
                                          _Update(documentSnapshot)),
                                  // This icon button is used to delete a single product
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () =>
                                          _deleteFood(documentSnapshot.id)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class BottomNav extends StatefulWidget {
  BottomNav({Key key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    AddProduct(),
    Chart(),
    About(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: 'MOVIE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'ADD MOVIES',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'CHART',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'ABOUT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'PROFILE',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
