import 'package:angular/angular.dart';
import 'package:angular_app/in_memory_date_service.dart';
import 'package:angular_router/angular_router.dart';
import 'package:http/http.dart';
import 'package:angular_app/app_component.template.dart' as ng;
import 'main.template.dart' as self;

@GenerateInjector([
  routerProvidersHash, // You can use routerProviders in production
  // Using a real back end?
  // Import 'package:http/browser_client.dart' and change the above to:
  //   ClassProvider(Client, useClass: BrowserClient),
  ClassProvider(Client, useClass: InMemoryDataService),
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}