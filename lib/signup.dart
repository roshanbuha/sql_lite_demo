import 'package:flutter/material.dart';
import 'package:sqflite_demo2/dbhelper.dart';
import 'package:sqflite_demo2/getTextFormField.dart';
import 'package:sqflite_demo2/list.dart';
import 'package:sqflite_demo2/user.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _conUserId = TextEditingController();
  final TextEditingController _conUserName = TextEditingController();
  final TextEditingController _conEmail = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();
  final TextEditingController _conCPassword = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Signup'),
      ),
      body: Form(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                getTextFormField(
                  controller: _conUserName,
                  icon: Icons.person_outline,
                  inputType: TextInputType.name,
                  hintName: 'User Name',
                ),
                const SizedBox(height: 10),
                getTextFormField(
                  controller: _conEmail,
                  icon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  hintName: 'Email',
                ),
                const SizedBox(height: 10),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Password',
                ),
                const SizedBox(height: 10),
                getTextFormField(
                  controller: _conCPassword,
                  icon: Icons.lock,
                  hintName: 'Confirm Password',
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  width: double.infinity,
                  child: Column(
                    children: [
                      MaterialButton(
                        child: const Text(
                          'get all users',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          UserModel user = UserModel(
                            user_name: _conUserName.text.toString(),
                            email: _conEmail.text.toString(),
                            password: _conPassword.text.toString(),
                          );
                          DbHelper().insert(user);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyListView(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
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
