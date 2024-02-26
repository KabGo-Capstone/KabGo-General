// ignore: file_names
List<Map<String, String>> convertStringToListOfMaps(String input) {
  input = input.replaceAll('[', '').replaceAll(']', '');
  List<String> pairs = input.split(', ');
  List<Map<String, String>> result = [];

  for (var pair in pairs) {
    List<String> keyValueStrings = pair.split(' / ');
    Map<String, String> keyValueMap = {};

    for (var keyValueString in keyValueStrings) {
      List<String> keyValue = keyValueString.split(': ');
      if (keyValue.length == 2) {
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();
        keyValueMap[key] = value;
      }
    }

    result.add(keyValueMap);
  }

  return result;
}
