import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesappver3/screens/home_screen.dart';
import 'package:notesappver3/screens/registerPage.dart';
import 'package:notesappver3/services/userAuth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserAuth _auth = UserAuth();

  bool showPassword = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                "assets/bigHeroLogin.png",
                width: MediaQuery.of(context).size.width * 0.35,
              ),
            ),

            Text(
              "Welcome back!",
              style: GoogleFonts.indieFlower(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.04,
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
                    onPressed: () async {
                      User? user = await _auth.loginUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (user != null) {
                        print("${user.email} just signed in");
                        print("successfully logged in");
                      } else {
                        print("some error is there");
                      }
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.15,
                        vertical: MediaQuery.of(context).size.height * 0.02,
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Text("Log in"),
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
            GestureDetector(
              onTap: () {
                print("lead to register modal");
                showModalBottomSheet(

                    //for shaping the top borders of the modalbottomsheet
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                            MediaQuery.of(context).size.height * 0.04),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    ////////////////////////////////////////

                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Wrap(children: [
                        RegisterPage(),
                      ]);
                    });
                setState(() {
                  _emailController.clear();
                  _passwordController.clear();
                });
              },
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.quicksand(
                    color: Colors.black,
                  ),
                  text: "Don't have an account?",
                  children: [
                    TextSpan(
                      text: " Sign up",
                      style: GoogleFonts.quicksand(
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
