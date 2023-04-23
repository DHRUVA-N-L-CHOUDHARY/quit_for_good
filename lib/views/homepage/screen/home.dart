import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/controllers/group_controller.dart';
import 'package:quit_for_good/models/group_details_model.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/views/Login_screen.dart';
import 'package:quit_for_good/widgets/group_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getCustomUniqueId() {
    const String pushChars =
        '-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    int lastPushTime = 0;
    List lastRandChars = [];
    int now = DateTime.now().millisecondsSinceEpoch;
    bool duplicateTime = (now == lastPushTime);
    lastPushTime = now;
    List timeStampChars = List<String>.filled(8, '0');
    for (int i = 7; i >= 0; i--) {
      timeStampChars[i] = pushChars[now % 64];
      now = (now / 64).floor();
    }
    if (now != 0) {
      print("Id should be unique");
    }
    String uniqueId = timeStampChars.join('');
    if (!duplicateTime) {
      for (int i = 0; i < 12; i++) {
        lastRandChars.add((Random().nextDouble() * 64).floor());
      }
    } else {
      int i = 0;
      for (int i = 11; i >= 0 && lastRandChars[i] == 63; i--) {
        lastRandChars[i] = 0;
      }
      lastRandChars[i]++;
    }
    for (int i = 0; i < 8; i++) {
      uniqueId += pushChars[lastRandChars[i]];
    }
    return uniqueId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  // Get.toNamed(SearchScreen.routeName);
                },
                icon: const Icon(Icons.search))
          ],
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text(
            "Community",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontFamily: "Brugty",
                fontSize: 27.sp),
          )),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.symmetric(vertical: 50.h),
        children: [
          Icon(
            Icons.account_circle,
            size: 120.sp,
          ),
          SizedBox(height: 10.h),
          Center(
              child: Text(
            FirebaseAuth.instance.currentUser?.email.toString() ?? "User",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp),
          )),
          SizedBox(height: 30.h),
          const Divider(height: 5),
          ListTile(
            onTap: () {
              Get.back();
            },
            selectedColor: Theme.of(context).primaryColor,
            selected: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            leading: const Icon(Icons.group),
            title: const Text("Groups", style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            onTap: () {
              // Get.toNamed(ProfileScreen.routeName);
            },
            selectedColor: Theme.of(context).primaryColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            leading: const Icon(Icons.person),
            title: const Text("Profile", style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () async {
                               FirebaseAuth.instance.signOut();
                              print("signedout");
                              Get.offAll(() => LoginScreen());
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            )),
                      ],
                    );
                  });
            },
            selectedColor: Theme.of(context).primaryColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            leading: const Icon(Icons.logout),
            title: const Text("Logout", style: TextStyle(color: Colors.black)),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            popUpDialog(context);
          },
          elevation: 0,
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add, size: 30.sp)),
      body: groupList(),
    );
  }
   String value = "";
  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: Text(
                "Create a group",
                textAlign: TextAlign.left,
              ),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  onChanged: (val) {
                    value = val;
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(20.r)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(20.r)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(20.r)),
                  ),
                ),
              ]),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      print("sdlkjfds");
                      List<String> membersList = [];
                      membersList.add(FirebaseAuth.instance.currentUser?.email ?? "admin");
                      GroupDetailsModel groupDetailsModel = GroupDetailsModel(
                          admin: FirebaseAuth.instance.currentUser?.email,
                          groupIcon: "",
                          groupId: getCustomUniqueId(),
                          recentMessage: "",
                          recentMessageSender:
                              FirebaseAuth.instance.currentUser?.email,
                              groupName:value,
                              members:  membersList);
                      GroupInfController controller = GroupInfController();
                      await controller.addUserInfo(groupDetailsModel);
                      Get.back();
                      Fluttertoast.showToast(
                          msg: "Group created successfully.");
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Failed to create");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("CREATE"),
                )
              ],
            );
          }));
        });
  }

  Future<List<GroupDetailsModel>> getStarted_readData() async {
    List<GroupDetailsModel> productList = [];
    print("sdjkfhldskfhd");
    await FirebaseFirestore.instance
        .collection("groups")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((product) {
        var _product = product.data();
        print(_product);
        productList.add(GroupDetailsModel.fromJson(_product));
      });
    });
    print(productList);
    return productList;
  }

  groupList() {
    return FutureBuilder<List<GroupDetailsModel>>(
        future: getStarted_readData(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            List<GroupDetailsModel> productList = snapshot.data ?? [];
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                  int reverseIndex = productList.length - index - 1;
                  return GroupTile(
                      groupName: productList[reverseIndex].groupName.toString(),
                      userName: productList[reverseIndex].admin.toString(),
                      groupId: productList[reverseIndex].groupId.toString());
                });
          } else {
            return noGroupWidget(context);
          }
        });
  }

  noGroupWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  popUpDialog(context);
                },
                child: Icon(Icons.add_circle,
                    color: Colors.grey[700], size: 75.sp)),
            SizedBox(height: 20.h),
            const Text(
              "You've not joined any groups, tap on the add icon to create a group or also from top search button.",
              textAlign: TextAlign.center,
            )
          ]),
    );
  }
}
