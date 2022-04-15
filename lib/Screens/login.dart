import 'package:flutter/material.dart';
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
                      isLoading ? CircularProgressIndicator() : Text("Submit"),
                ),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // sendData();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
