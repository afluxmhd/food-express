import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

class GenerateId {
  String generateOrderId(String userId) {
    Random random = Random();
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String randomPart = random.nextInt(10000).toString();

    String inputString = '$userId$timestamp$randomPart';

    List<int> bytes = utf8.encode(inputString);
    String hash = sha1.convert(bytes).toString();

    String orderId = 'FE-$hash'.substring(0, 7);
    return orderId;
  }
}
