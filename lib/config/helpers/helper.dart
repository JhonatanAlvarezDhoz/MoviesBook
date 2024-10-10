import 'package:flutter/material.dart';

class Helper {
  static Map<String, dynamic> splitOverView(
      {required String text, required int limit}) {
    if (text.length > limit) {
      int lastSpace = text.lastIndexOf(
          ' ', limit); // finded the last one space after the limit

      if (lastSpace == -1) {
        lastSpace = limit; // if there is'nt space, cut in the limit
      }

      String firstPart = text.substring(0, lastSpace).trim();
      String secondPart = text.substring(lastSpace).trim();

      return {
        'firstPart': firstPart,
        'secondPart': secondPart,
        'isDivide': true
      };
    } else {
      return {'firstPart': text, 'isDivide': false};
    }
  }

  static Color getGenereColor(String genre) {
    switch (genre.toLowerCase()) {
      case 'acción':
      case 'action':
        return Colors.red[700]!;
      case 'aventura':
      case 'adventure':
        return Colors.green[600]!;
      case 'animación':
      case 'animation':
        return Colors.yellow[800]!;
      case 'comedia':
      case 'comedy':
        return Colors.orange[300]!;
      case 'crimen':
      case 'crime':
        return Colors.blueGrey[800]!;
      case 'documental':
      case 'documentary':
        return Colors.lightBlue[100]!;
      case 'drama':
        return Colors.purple[300]!;
      case 'familia':
      case 'family':
        return Colors.green[300]!;
      case 'fantasía':
      case 'fantasy':
        return Colors.indigo[400]!;
      case 'historia':
      case 'history':
        return Colors.brown[400]!;
      case 'terror':
      case 'horror':
        return Colors.deepPurple[900]!;
      case 'música':
      case 'music':
        return Colors.pink[300]!;
      case 'misterio':
      case 'mystery':
        return Colors.indigo[700]!;
      case 'romance':
        return Colors.red[200]!;
      case 'ciencia ficción':
      case 'science fiction':
        return Colors.cyan[500]!;
      case 'película de tv':
      case 'tv movie':
        return Colors.amber[100]!;
      case 'suspenso':
      case 'thriller':
        return Colors.orange[900]!;
      case 'bélico':
      case 'war':
        return Colors.grey[700]!;
      case 'western':
        return Colors.brown[600]!;
      default:
        return Colors.grey[400]!;
    }
  }
}
