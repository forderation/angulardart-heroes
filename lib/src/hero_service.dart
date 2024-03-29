import 'dart:convert';
import 'package:http/http.dart';
import 'hero.dart';
import 'dart:async';

class HeroService {
  static const _heroesUrl = 'api/heroes';
  static final _headers = {'Content-Type': 'application/json'};

  final Client _http;

  HeroService(this._http);

  Future<List<Hero>> getAll() async {
    //throw error if fail retrieve data or connect to server
    try {
      final response = await _http.get(_heroesUrl);
      final heroes = (_extractData(response) as List)
          .map((json) => Hero.fromJson(json))
          .toList();
      return heroes;
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return Exception('Server error; cause: $e');
  }

  //get hero by id
  Future<Hero> get(int id) async {
    try {
      final response = await _http.get('$_heroesUrl/$id');
      return Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> update(Hero hero) async {
    try {
      final url = '$_heroesUrl/${hero.id}';
      final response =
      await _http.put(url, headers: _headers, body: json.encode(hero));
      return Hero.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> create(String name) async {
    try {
      final response = await _http.post(
          _heroesUrl, body: json.encode({'name': name}), headers: _headers);
      return Hero.fromJson(_extractData(response));
    }catch(e){
      throw _handleError(e);
    }
  }

  Future<void> delete(int id) async {
    try {
      final url = '$_heroesUrl/$id';
      await _http.delete(url, headers: _headers);
    }catch(e){
      throw _handleError(e);
    }
  }
}
