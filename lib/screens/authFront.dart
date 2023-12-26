import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesappver3/screens/loginPage.dart';
import 'package:notesappver3/screens/registerPage.dart';

class AuthFront extends StatefulWidget {
  const AuthFront({super.key});

  @override
  State<AuthFront> createState() => _AuthFrontState();
}

class _AuthFrontState extends State<AuthFront> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              "assets/authFrontBackground.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
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
                              LoginPage(),
                            ]);
                          });
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.3,
                        vertical: MediaQuery.of(context).size.height * 0.02,
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Text("Log in"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.012,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Lead to Register page");
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
                    },
                    child: Text(
                      "Don't have an account? Sign up",
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
