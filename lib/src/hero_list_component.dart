import 'package:angular/angular.dart';
import 'package:angular_app/src/hero_service.dart';
import 'package:angular_app/src/route_paths.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'hero.dart';

@Component(
    selector: 'my-heroes',
    // load template with url
    templateUrl: 'hero_list_component.html',
    // you need directives with formDirectives prevent breaks
    //  add Hero Component to directives list so this component can reused
    directives: [
      coreDirectives, formDirectives /*HeroComponent*/
    ],
    // These styles apply only to the AppComponent and don’t affect the outer HTML.
    styleUrls: [
      'hero_list_component.css'
    ],
    //  To teach the injector how to make a HeroService
    providers: [
      ClassProvider(HeroService),
    ],
    // add pipes interpolation
    pipes: [
      commonPipes
    ])
class HeroListComponent implements OnInit {
  Hero selected;
  List<Hero> heroes;
  final title = 'Tour of Heroes';
  final Router _router;
  final HeroService _heroService;

  //field input for add hero
  String heroName;

  HeroListComponent(this._heroService, this._router);

  Future<void> _getHeroes() async {
    heroes = await _heroService.getAll();
  }

  void onSelect(Hero hero) => selected = hero;

  @override
  void ngOnInit() => _getHeroes();

  String _heroUrlBuilder(int id) {
    return RoutePaths.hero.toUrl(parameters: {idParam: "$id"});
  }

  // execute routing navigation to hero detail
  Future<NavigationResult> goToDetail() =>
      _router.navigate(_heroUrlBuilder(selected.id));

  //add new hero
  Future<void> add() async {
    if(heroName == null) return
    heroName  = heroName.trim();
    if(heroName.isEmpty) return null;
    heroes.add(await _heroService.create(heroName));
    //empty input value
    heroName = '';
    selected = null;
  }

  //  delete hero
  Future<void> delete(Hero hero, dynamic event) async {
    event.stopPropagation();
    await _heroService.delete(hero.id);
    heroes.remove(hero);
    if(selected == hero) selected == null;
  }
}
