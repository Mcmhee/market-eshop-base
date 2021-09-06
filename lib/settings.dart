import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
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
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://avatars2.githubusercontent.com/u/2400215?s=120&v=4"),
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
              const Center(
                child: Text(
                  "John Doe",
                  style: TextStyle(
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
