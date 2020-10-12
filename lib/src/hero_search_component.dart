import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_app/src/hero_search_service.dart';
import 'package:angular_app/src/route_paths.dart';
import 'package:angular_router/angular_router.dart';
import 'package:stream_transform/stream_transform.dart';

import 'hero.dart';

@Component(
    selector: 'hero-search',
    templateUrl: 'hero_search_component.html',
    styleUrls: ['hero_search_component.css'],
    directives: [coreDirectives],
    pipes: [commonPipes],
    providers: [ClassProvider(HeroSearchService)])
class HeroSearchComponent implements OnInit {
  HeroSearchService _heroSearchService;
  Router _router;

  //Stream provide sequence of asynchronous events
  Stream<List<Hero>> heroes;
  StreamController<String> _searchTerms = StreamController<String>.broadcast();

  //dependency injection by Class Provider
  HeroSearchComponent(this._heroSearchService, this._router) {}

  @override
  void ngOnInit() async {
    heroes = _searchTerms.stream
    // ignore: deprecated_member_use
        .transform(debounce(Duration(milliseconds: 300)))
        .distinct() //ensures that a request is sent only if the filter text changed.
    //It cancels and discards previous searches, returning only the latest search service stream element.
    // ignore: deprecated_member_use
        .transform(switchMap((term) => term.isEmpty
            ? Stream<List<Hero>>.fromIterable([<Hero>[]])
            : _heroSearchService.search(term).asStream()))
        .handleError((e) {
      print(e); // for demo purposes only
    });
  }

  String _heroUrl(int id) =>
      RoutePaths.hero.toUrl(parameters: {idParam: '$id'});

  void search(String term) => _searchTerms.add(term);

  Future<NavigationResult> gotoDetail(Hero hero) =>
      _router.navigate(_heroUrl(hero.id));
}
