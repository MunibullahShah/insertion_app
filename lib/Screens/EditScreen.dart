import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insertion_app/Screens/ProfileScreen.dart';
import 'package:insertion_app/Widgets/inputContainer.dart';
import 'package:insertion_app/models/employee.dart';

class EditScreen extends StatefulWidget {
  Employee user;
  EditScreen(this.user);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nicController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.user.name!;
    addressController.text = widget.user.address!;
    phoneController.text = widget.user.phone!;
    nicController.text = widget.user.phone!;
    super.initState();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromRGBO(131, 191, 234, 1),
            ),
            height: MediaQuery.of(context).size.height * (0.70),
            width: MediaQuery.of(context).size.width * (0.75),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(131, 160, 234, 1),
                        ),
                        // height: MediaQuery.of(context).size.height * (0.70),
                        width: (MediaQuery.of(context).size.width * (0.75)) *
                            (0.30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: (MediaQuery.of(context).size.width *
                                        (0.75)) *
                                    (0.30) *
                                    (0.80),
                                width: (MediaQuery.of(context).size.width *
                                        (0.75)) *
                                    (0.30) *
                                    (0.80),
                                child: Image(
                                  image: NetworkImage(
                                      "https://th.bing.com/th/id/R.cd6d11ef068a3f0d483a61b73044e4ea?rik=6L9rWMoFYxvwNg&pid=ImgRaw&r=0"),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Muhammad Abdullah Akmal Dar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(131, 191, 234, 1),
                        ),
                        height: MediaQuery.of(context).size.height * (0.70),
                        width: (MediaQuery.of(context).size.width * (0.75)) *
                            (0.70),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputContainer(
                              controller: nameController,
                              label: "Name",
                              hintText: "Name",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputContainer(
                              controller: addressController,
                              label: "Address",
                              hintText: "address",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputContainer(
                              controller: phoneController,
                              label: "Phone",
                              hintText: "123434",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputContainer(
                              controller: nicController,
                              label: "NIC",
                              hintText: "12345",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              child: Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(
                                    230,
                                    242,
                                    255,
                                    1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text("Submit"),
                              ),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  updateData();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  updateData() async {
    try {
      var response = await Dio()
          .put("https://idms.backend.eastdevs.com/api/Employees/1", data: {
        "data": {
          "name": nameController.text,
          "nic_no": nicController.text,
          "phone_num": phoneController.text,
          "address": addressController.text,
        }
      }).then((value) {
        setState(() {
          isLoading = false;
        });
        print(value);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      });
      print(response);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }
}