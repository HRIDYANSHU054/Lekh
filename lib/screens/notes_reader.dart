import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesappver3/style/app_style.dart';

// ignore: must_be_immutable
class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {super.key});
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc['color_id'];
    print(widget.doc["color_id"] ?? "na");
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 18, 227),
        elevation: 0.0,
        iconTheme:
            IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc.data().toString().contains("note_title")
                  ? widget.doc.get("note_title")
                  : "NOTE TITLE",
              style: GoogleFonts.roboto(
                  fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              widget.doc.data().toString().contains("creation_date")
                  ? widget.doc.get("creation_date")
                  : "Date",
              style: GoogleFonts.nunito(
                  fontSize: 16.0, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 50),
            Text(
              widget.doc.data().toString().contains("note_content")
                  ? widget.doc.get("note_content")
                  : "Content",
              style: GoogleFonts.roboto(
                  fontSize: 13.0, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
