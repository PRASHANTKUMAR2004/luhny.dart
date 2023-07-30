/// Checks whether the supplied character is an integer.
/// Returns a boolean depending on this.
bool isInt(String subject) {
  bool result = true;
  try {
    int.parse(subject);
  } catch (e) {
    result = false;
  }
  return result;
}

/// Checks whether the supplied IMEI string only contains integers.
/// Returns a boolean depending on this.
bool isNumberSequence(String imei) {
  for (var char in imei.split('')) {
    if (!isInt(char)) {
      return false;
    }
  }
  return true;
}

/// Gets every second number starting from the left.
List<String> getImportantNumbers(String imei) {
  List<String> result = [];
  for (var i = 0; i < imei.length; i++) {
    if ((i + 1) % 2 == 0) {
      result.add(imei[i]);
    }
  }
  return result;
}

/// Gets all the numbers that remain.
/// Removes the check digit because this is not allowed when
/// adding all the remaining numbers together.
List<String> getTrashNumbers(String imei) {
  List<String> result = [];
  for (var i = 0; i < imei.length; i++) {
    if ((i + 1) % 2 != 0) {
      result.add(imei[i]);
    }
  }
  result.removeLast(); // Remove the check digit from the list.
  return result;
}

/// Converts all the "important" numbers, doubles them, and returns them in an array.
List<int> doubleImportantNumbers(String imei) {
  List<String> impNums = getImportantNumbers(imei);
  List<int> result = [];
  for (var impNum in impNums) {
    result.add(int.parse(impNum) * 2);
  }
  return result;
}

/// Adds all the remaining numbers in a lump sum.
int addTrashNumbers(String imei) {
  List<String> trashNums = getTrashNumbers(imei);
  int result = 0;
  for (var trashNum in trashNums) {
    result += int.parse(trashNum);
  }
  return result;
}

/// Splits all the characters in the "important" numbers and adds them all
/// together in a lump sum.
int addImportantDoubleDigits(String imei) {
  List<int> doubles = doubleImportantNumbers(imei);
  int result = 0;
  for (var doubleDigit in doubles) {
    for (var digit in doubleDigit.toString().split('')) {
      result += int.parse(digit);
    }
  }
  return result;
}

/// Gets the last item of a string array and returns it.
String getLastItem(List<String> arr) {
  return arr.last;
}

/// Gets the check digit of your IMEI, adds the "important" and the
/// "other" numbers together, subtracts the "mod 10" from 10 of that sum, makes
/// a type conversion, compares the check digit and the calculated check digit,
/// and returns true or false depending on whether they are equal or not.
bool validateIMEI(String imei) {
  if (isNumberSequence(imei)) {
    List<String> imeiChars = imei.split('');
    String checkDigit = getLastItem(imeiChars);
    int sum = addImportantDoubleDigits(imei) + addTrashNumbers(imei);
    int computedCheckDigit = (10 - (sum % 10)) % 10;
    String computedConvertedCD = computedCheckDigit.toString();
    return checkDigit == computedConvertedCD && imeiChars.length == 15;
  }
  return false;
}

/// Tests the most important functions from above.
void testAll() {
  String falseInt = 'A';
  String trueInt = '2';
  print(isInt(falseInt));
  print(isInt(trueInt));
  print(isNumberSequence('A1234'));
  print(isNumberSequence('1234'));
  print(validateIMEI('353879234252633'));
  print(validateIMEI('3A3879234252633'));
}
