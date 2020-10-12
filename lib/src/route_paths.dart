
import 'package:angular_router/angular_router.dart';

//prevent hardcode id param for route
const idParam = 'id';

class RoutePaths {
  //make list of all route paths here
  static final heroes = RoutePath(path: 'heroes');
  static final dashboard = RoutePath(path: 'dashboard');

  // routing detail hero with parameter
  static final hero = RoutePath(path: '${heroes.path}/:$idParam');



}