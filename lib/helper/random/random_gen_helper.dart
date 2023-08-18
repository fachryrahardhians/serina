import 'dart:math';

String generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final random = Random();
  final result = List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  return result;
}
