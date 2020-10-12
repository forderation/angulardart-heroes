import 'package:angular/angular.dart';
import 'package:angular_app/src/hero_service.dart';
import 'package:angular_app/src/route_paths.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'hero.dart';

@Component(
  selector: 'my-hero',
  templateUrl: 'hero_component.html',
  directives: [coreDirectives, formDirectives]
)
//get notified when a hero route is navigated with implement OnActive
class HeroComponent implements OnActivate{

  // // with annotation @Input() it retrieve the arg
  // @Input()
  // Hero hero;
  final HeroService _heroService;
  final Location _location;
  Hero hero;

  HeroComponent(this._heroService, this._location);

  @override
  void onActivate(RouterState previous, RouterState current) async {
    final id = getId(current.parameters);
    if(id != null) hero = await (_heroService.get(id));
  }

  void goBack() => _location.back();

  // map with key as param string on route, and value with parameter arg value
  int getId(Map<String, String> params){
    final id = params[idParam];
    //return null if not found
    return id == null ? null : int.tryParse(id);
  }

  Future<void> save() async {
    await _heroService.update(hero);
    goBack();
  }

}