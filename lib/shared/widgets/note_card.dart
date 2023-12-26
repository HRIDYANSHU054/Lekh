import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notesappver3/style/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  //Check if the fields exist in the document snapshot
  Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

  bool hasNoteTitle = data?.containsKey("note_title") ?? false;
  bool hasCreationDate = data?.containsKey("creation_date") ?? false;
  bool hasNoteContent = data?.containsKey("note_content") ?? false;

  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasNoteTitle)
            Text(
              doc["note_title"],
              style: AppStyle.mainTitle,
            ),
          if (hasCreationDate)
            Text(
              doc["creation_date"],
              style: AppStyle.dateTitle,
            ),
          const SizedBox(height: 8.0),
          if (hasNoteContent)
            Text(
              doc["note_content"],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    ),
  );
}
