import 'dart:convert';

/// id : "LV8375"
/// x : 15
/// y : 6
/// direction : "SW"

class Coordinates {
  late String id;
  late int x;
  late int y;
  late String direction;

  static List<Coordinates> parse(String stringData) {
    final data = jsonDecode(stringData);
    List<Coordinates> output = [];
    for (int i = 0; i < data.length; i++) {
      Coordinates coordinate = Coordinates();
      coordinate.id = data[i]['id'];
      coordinate.x = data[i]['x'];
      coordinate.y = data[i]['y'];
      coordinate.direction = data[i]['direction'];
      output.add(coordinate);
    }
    return output;
  }

  Map toJson() => {
        "id": id,
        "x": x,
        "y": y,
        "direction": direction,
      };
}
