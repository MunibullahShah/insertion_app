import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:insertion_app/Screens/parcelInfoScreen.dart';
import 'package:insertion_app/Widgets/appButton.dart';
import 'package:insertion_app/Widgets/inputContainer.dart';
import 'package:insertion_app/constants.dart';

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
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 214, 77, 1),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(5.0, 5.0),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      child: Image(
                        image: AssetImage("login.png"),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 230,
                              padding: const EdgeInsets.all(30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      InputContainer(
                                        label: "Email",
                                        controller: emailController,
                                        hintText: "Email",
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InputContainer(
                                        label: "Password",
                                        controller: passwordController,
                                        hintText: "Password",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            isLoading
                                ? CircularProgressIndicator()
                                : appButton(
                                    "Login",
                                    () {
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
                  ),
                ),
              ],
            ),
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
            "https://idms.backend.eastdevs.com/api/employees?filters[email][\$eq]=$email");
        if (resp.statusCode == 200) {
          print(resp.data);
          String id = resp.data["data"][0]["id"].toString();
          print("ID: $id");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ParcelInfoScreen(id)));
        }
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: "Login Failed");
      print(e.response);
    }
    setState(() {
      isLoading = false;
    });
  }
}
