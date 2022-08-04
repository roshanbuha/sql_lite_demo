import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite_demo2/dbhelper.dart';
import 'package:sqflite_demo2/user.dart';

class MyListView extends StatefulWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<UserModel> userList = [];

  @override
  void initState() {
    // TODO: implement initState
    getUserList();
  }

  Future<void> getUserList() async {
    userList = await DbHelper().getAllUser();
    setState(() {});
    log("userList==> ${userList.first.user_name}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userList.isEmpty)
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "No Data Found",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(userList[index].user_name ?? ""),
                  subtitle: Text(userList[index].email ?? ""),
                );
              },
              itemCount: userList.length,
            ),
            ElevatedButton(
              child: const Text(
                '<-',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
