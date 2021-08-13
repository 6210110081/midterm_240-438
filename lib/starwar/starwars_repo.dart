import 'package:dio/dio.dart';

class People {
  String name;
  String gender;
  String height;
  String mass;
  String bday;
  People(this.name, this.gender, this.height, this.mass, this.bday);

  factory People.fromJson(dynamic data) {
    return People(
      data['name'],
      data['gender'],
      data['height'],
      data['mass'],
      data['birth_year'],
    );
  }
}

class StarwarsRepo {
  var dio = Dio();
  Future<List<People>> repoPeopleStarwar(int page) async {
    var response = await dio.get('https://swapi.dev/api/people/?page=$page');
    List<dynamic> peopleStarwars = response.data['results'];
    return peopleStarwars.map((e) => People.fromJson(e)).toList();
  }
}
