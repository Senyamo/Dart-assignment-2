import 'dart:io';
import 'package:intl/intl.dart';

void main() async {
  List<Map<String, String>> entries = [];
  DateFormat dateFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  while (true) {
    String userInput = getUserInput('Enter a string (or type "exit" to quit): ');

    if (userInput.toLowerCase() == 'exit') break;

    String reversedString = reverseString(userInput);
    int length = userInput.length;
    String upperCase = userInput.toUpperCase();
    String lowerCase = userInput.toLowerCase();
    String currentDateTime = dateFormatter.format(DateTime.now());

    entries.add({
      'original': userInput,
      'reversed': reversedString,
      'length': length.toString(),
      'uppercase': upperCase,
      'lowercase': lowerCase,
      'timestamp': currentDateTime,
    });

    printResults(userInput, reversedString, length, upperCase, lowerCase, currentDateTime);
  }

  await saveToFile(entries);
}

String reverseString(String input) {
  return input.split('').reversed.join('');
}

String getUserInput(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync() ?? '';
}

void printResults(String original, String reversed, int length, String upper, String lower, String timestamp) {
  print('\n--- String Manipulation Results ---');
  print('Original: $original');
  print('Reversed: $reversed');
  print('Length: $length');
  print('Uppercase: $upper');
  print('Lowercase: $lower');
  print('Timestamp: $timestamp');
  print('-----------------------------------\n');
}

Future<void> saveToFile(List<Map<String, String>> entries) async {
  File file = File('output.txt');

  try {
    IOSink sink = file.openWrite();
    for (var entry in entries) {
      sink.writeln('--- Entry ---');
      sink.writeln('Original: ${entry['original']}');
      sink.writeln('Reversed: ${entry['reversed']}');
      sink.writeln('Length: ${entry['length']}');
      sink.writeln('Uppercase: ${entry['uppercase']}');
      sink.writeln('Lowercase: ${entry['lowercase']}');
      sink.writeln('Timestamp: ${entry['timestamp']}');
      sink.writeln('-----------------------');
    }
    await sink.flush();
    await sink.close();
    print('Data saved to output.txt');
  } catch (e) {
    print('Error saving data: $e');
  }
}
