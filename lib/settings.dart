import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50.0,
              ),
              Stack(
                children: [
                  Container(
                    //alignment: const Alignment(),
                    width: MediaQuery.of(context).size.width / 3,
                    height: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          _auth.currentUser!.photoURL ??
                              "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        ),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  _auth.currentUser!.displayName.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView(
                  reverse: true,
                  shrinkWrap: true,
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 28,
                        ),
                        title: const Text('Profile',
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.favorite,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 28,
                        ),
                        title: const Text('Favorite',
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.vpn_key,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 28,
                        ),
                        title: const Text('Change Password',
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 28,
                        ),
                        title: const Text('Logout',
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
