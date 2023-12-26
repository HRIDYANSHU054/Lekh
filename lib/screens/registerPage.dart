import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesappver3/services/userAuth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserAuth _auth = UserAuth();
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? _validatePasswordLength(String? pass) {
    if (pass!.length <= 8) {
      return "too Short";
    } else if (pass.length >= 15) {
      return "Strong Password";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
          height: MediaQuery.sizeOf(context).height * 0.85,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              // hero image
              Container(
                child: Image.asset(
                  "assets/bigHeroRegister.png",
                  width: MediaQuery.of(context).size.width * 0.35,
                ),
              ),

              Text(
                "Create an Account",
                textAlign: TextAlign.center,
                style: GoogleFonts.indieFlower(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * 0.05,
                ),
              ),
              SizedBox(
                  // height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
              // name
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(20, 12, 12, 12),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 19, 20, 21),
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black87,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),

              // email
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(20, 12, 12, 12),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 19, 20, 21),
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black87,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              // Password
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: showPassword
                          ? Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(20, 12, 12, 12),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 19, 20, 21),
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black87,
                  validator: _validatePasswordLength,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.validate();
                        _auth.registerUser(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text);
                        //after user authentication code
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.15,
                          vertical: MediaQuery.of(context).size.height * 0.02,
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text("Join in"),
                    ),
                    Text("or"),
                    GestureDetector(
                      onTap: () {
                        _auth.googleLogIn();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 155, 155, 155),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                                MediaQuery.of(context).size.height * 0.015),
                          ),
                        ),
                        child: Image.asset(
                          "assets/GoogleLogo.png",
                          width: MediaQuery.of(context).size.width * 0.12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          )),
    );
  }
}
