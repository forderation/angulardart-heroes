import 'package:angular_app/src/route_paths.dart';
import 'package:angular_router/angular_router.dart';

// NOTE: The Angular compiler generates component factories behind the scenes when you build the app
//access the factory you need to import the generated component template file
import 'hero_list_component.template.dart' as hero_list_template;
import 'dashboard_component.template.dart' as dashboard_template;
import 'hero_component.template.dart' as hero_template;

class Routes {
  //routes definition with component
  static final heroes = RouteDefinition(
    routePath: RoutePaths.heroes,
    component: hero_list_template.HeroListComponentNgFactory,
  );

  static final dashboard = RouteDefinition(
      routePath: RoutePaths.dashboard,
      component: dashboard_template.DashboardComponentNgFactory);

  static final hero = RouteDefinition(
      routePath: RoutePaths.hero,
      component: hero_template.HeroComponentNgFactory);

  //register to route definition list
  static final all = <RouteDefinition>[
    hero,
    heroes,
    dashboard,
    //  Redirect routes '/' to dashboard
    RouteDefinition.redirect(path: '', redirectTo: RoutePaths.dashboard.toUrl())
  ];
}
