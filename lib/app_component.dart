import 'package:angular/angular.dart';
import 'package:angular_app/src/hero_service.dart';
import 'package:angular_app/src/route_paths.dart';
import 'package:angular_app/src/routes.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: ['app_component.css'],
  directives: [routerDirectives],
  providers: [ClassProvider(HeroService)],
  exports: [RoutePaths, Routes]
)class AppComponent {
  final title = 'Tour of Heroes';
}