import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insertion_app/Screens/parcelInfoScreen.dart';
import 'package:insertion_app/Widgets/inputContainer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 230,
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        InputContainer(
                          label: "Email",
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputContainer(
                          label: "Password",
                          controller: passwordController,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child:
                      isLoading ? CircularProgressIndicator() : Text("Login"),
                ),
                onTap: () {
                  print("tapped");
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    login();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    String password = passwordController.text;
    String email = emailController.text;
    print("EMail: $email, Password: $password");
    try {
      var response = await Dio().post(
          "https://idms.backend.eastdevs.com/api/auth/local",
          data: {"identifier": email, "password": password});
      if (response.statusCode == 200) {
        var resp = await Dio().get(
            "http://idms.backend.eastdevs.com/api/employees?filters[email][\$eq]=$email");
        if (resp.statusCode == 200) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ParcelInfoScreen()));
        }
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }
}
