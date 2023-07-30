/*
LUHNY.DART by Alexander Abraham, a.k.a. "Angel Dollface".
Licensed under the MIT license.
*/

/// Checks whether the supplied character is
/// an integer. Returns a boolean depending on this. 
bool isInt(String subject) {
    bool result = true;
    try {
        int.parse(subject);
    }
    catch(e){
        result  = false;
    }
    return result;
}

/// Checks whether the supplied IMEI string
/// only contains integers.
/// Returns a boolean depending on this. 
bool isNumberSequence(String imei){
    bool result = true;
    List<String> charList = imei.split('');
    for (var i = 0; i < charList.length; i++){
        if (isInt(charList[i]) == false){
            result = false;
        }
        else {
            // Do nothing.
        }
    }
    return result;
}

/// Gets every second number starting from the left.
List<String> getImportantNumbers(String imei){
    List<String> result = [];
    List<String> charList = imei.split('');
    for (var i = 0; i < charList.length; i++){
        int currIndex = i + 1;
        if (currIndex % 2 == 0){
           result.add(charList[i]);
        }
        else {
            // Do nothing.
        }
    }
    return result;
}

/// Gets all the numbers that remain.
/// Removes the check digit because this is not allowed when
/// adding all the remaining numbers together.
List<String> getTrashNumbers(String imei){
    List<String> result =[];
    List<String> charList = imei.split('');
    for (var i = 0; i < charList.length; i++){
        int currIndex = i + 1;
        if (currIndex % 2 == 0){
            // Do nothing.
        }
        else {
            result.add(charList[i]);
        }
    }
    int resultLen = result.length;
    int lastIndex = resultLen -1;
    result.removeAt(lastIndex);
    return result;
}

/// Converts all the "important" numbers, doubles them, and returns them
/// in an array.
List<int> doubleImportantNumbers(String imei){
    List<String> impNums = getImportantNumbers(imei);
    List<int> result = [];
    for (var i = 0; i < impNums.length; i++){
        result.add((int.parse(impNums[i])) * 2);
    }
    return result;
}

/// Adds all the remaining numbers in a lump sum.
int addTrashNumbers(String imei){
    List<String> impNums = getTrashNumbers(imei);
    int result = 0;
    for (var i = 0; i < impNums.length; i++){
        result = result + (int.parse(impNums[i]));
    }
    return result;
}

/// Because this is neccessary and we can't play fast and loose with types
/// we need to convert between the arrays' types. 
List<String> convertNumberArrayToStringArray(List<int> arr){
    List<String> result =[];
    for (var i = 0; i < arr.length; i++){
        String num = arr[i].toString();
        List<String> nums = num.split('');
        for (var x = 0; x < nums.length;x++) {
            result.add(nums[x]);
        }
    }
    return result;
}

/// Splits all the characters in the "important" numbers and adds them all
/// together in a lump sum.
int addImportantDoubleDigits(String imei){
    int result = 0;
    List<int> doubles = doubleImportantNumbers(imei);
    List<String> digitArr = convertNumberArrayToStringArray(doubles);
    for (var i = 0; i < digitArr.length; i++){
        result = result + int.parse(digitArr[i]);
    }
    return result;
}

/// Gets the last item of a string array and returns it.
String getLastItem(List<String> arr) {
    if (arr.isEmpty) {
        // Handle the case when the list is empty, return a default value or null.
        // For example:
        // return '';
        return ''; // Or return null if you prefer.
    }

    int arrayLength = arr.length;
    int lastItemIndex = arrayLength - 1;
    return arr[lastItemIndex];
}
String getLastItem(List<String> arr) {
    int arrayLength = arr.length;
    int lastItemIndex = arrayLength -1;
    return arr[lastItemIndex];
}

/// Gets the check digit of your IMEI, adds the "important" and the
/// "other" numbers together, subtracts the "mod 10" from 10 of that sum, makes
/// a type conversion, compares the check digit and the calculated check digit,
/// and returns true or false depending on whether they are equal or not.
bool validateIMEI(String imei){
    bool result = false;
    if (isNumberSequence(imei)) {
        List<String> imeiChars = imei.split('');
        String checkDigit = getLastItem(imeiChars);
        int sum = addImportantDoubleDigits(imei) + addTrashNumbers(imei);
        int computedCheckDigit = (10 - (sum%10));
        String computedConvertedCD = computedCheckDigit.toString();
        if (
            checkDigit == computedConvertedCD && 
            imeiChars.length == 15
        ){
            result = true;
        }
        else {
            // Do nothing.
        }
    }
    else {
        // Do nothing.
    }
    return result;
}

/// Tests the most important functions
/// from above.
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
