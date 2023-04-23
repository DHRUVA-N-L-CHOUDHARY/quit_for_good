import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [profilesection()],
      ),
    );
  }

  Widget profilesection() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "username",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("email", style: TextStyle(fontSize: 15)),
              const SizedBox(height: 8),
              Text(
                'Sponsor Name: sponsorname',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              const Text('Profile ID: 202210533',
                  style: TextStyle(fontSize: 15)),
              const SizedBox(height: 8)
            ],
          ),
          ClipOval(
            child: CircleAvatar(
                radius: 30,
                child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/freelanceproject-21af8.appspot.com/o/h2epcRjd9DQout5VGWy2mTkgCw63%2Fprofile_page_image_icon.png?alt=media&token=3b51e940-daaa-4140-8255-8c7c9d8b2a90")),
          )
        ],
      ),
    );
  }
}
