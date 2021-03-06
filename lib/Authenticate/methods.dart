import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

Future<User?> createAccount(String name, String email, String password,
    String address, BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print("Account created Succesfull");

    userCrendetial.user!.updateDisplayName(name);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "uid": _auth.currentUser!.uid,
      "address": address,
    });

    return userCrendetial.user;
  } catch (e) {
    // print(e);
    errorAlertDisplay(context, e);
    return null;
  }
}

Future<User?> logIn(String email, String password, BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    print("Login Sucessfull");
    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    // print(e);
    errorAlertDisplay(context, e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    // print("error");
    errorAlertDisplay(context, e);
  }
}

errorAlertDisplay(context, e) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Opps an error occured!"),
            content: Text(e.toString()),
            elevation: 0.0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel_outlined),
              )
            ],
          ));
}
