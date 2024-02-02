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
}
