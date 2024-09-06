// Function to navigate to different pages
import 'package:book_store/API/academic.dart';
import 'package:book_store/API/biography.dart';
import 'package:book_store/API/children.dart';
import 'package:book_store/API/history_fiction.dart';
import 'package:book_store/API/literature_fiction.dart';
import 'package:book_store/API/mystery.dart';
import 'package:book_store/API/romance.dart';
import 'package:book_store/API/science_fiction.dart';
import 'package:book_store/API/thriller.dart';
import 'package:flutter/material.dart';

void navigateToPage(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AcademicPage(context)));
      break;
    case 1:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BiographyPage(context)));
      break;
    case 2:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RomancePage(context)));
      break;
    case 3:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ThrillerPage(context)));
      break;
    case 4:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ScienceFictionPage(context)));
      break;
    case 5:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LiteraryFictionPage(context)));
      break;
    case 6:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChildrenPage(context)));
      break;
    case 7:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoricalFictionPage(context)));
      break;
    case 8:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MysteryPage(context)));
      break;
    default:
      break;
  }
}
