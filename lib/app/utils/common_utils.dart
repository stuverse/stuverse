import 'package:flutter/material.dart';

class CommonUtils {
  static String getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good morning 🌞 !!';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon 🌤️ !!';
    } else if (hour >= 17 && hour < 21) {
      return 'Good evening 🌆 !!';
    } else {
      return 'Hey there 🌃 !!';
    }
  }

  static String toTitleCase(String input) {
    if (input.isEmpty) {
      return input;
    }

    List<String> words = input.split(' ');

    List<String> titleCaseWords = words.map((word) {
      if (word.length > 1) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return word.toUpperCase();
      }
    }).toList();

    return titleCaseWords.join(' ');
  }

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String relativeTime(DateTime? date) {
    if (date == null) {
      return '';
    }
    DateTime now = DateTime.now();
    Duration diff = now.difference(date);
    if (diff.inDays > 365) {
      return '${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago';
    } else if (diff.inDays > 30) {
      return '${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago';
    } else if (diff.inDays > 7) {
      return '${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago';
    } else {
      return 'just now';
    }
  }

  static String formatNumberEnglish(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double result = number / 1000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}k';
    } else {
      double result = number / 1000000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
    }
  }

  static String getFirstLetter(String input) {
    if (input.isEmpty) {
      return '';
    }
    return input[0].toLowerCase();
  }
}
