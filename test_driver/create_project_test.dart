import 'package:flutter_driver/flutter_driver.dart';
//import 'package:flutter_test/flutter_test.dart' as ftest; <- we cannot mix flutter tests and drive tests, due to errors "cannot find dart:ui"
import 'package:test/test.dart';

void main() {
  group('tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null)
        driver.close();
    });
//
    SerializableFinder drawerOpenButton = find.byTooltip('Open navigation menu'); //note: hack to open drawer
    SerializableFinder projectsText = find.text('Projects');
    SerializableFinder addProjectText = find.text('Add project');
    SerializableFinder addProjectKey = find.byValueKey('add-project');
    SerializableFinder addProjectButton = find.byValueKey('add-project-button');
    const projectName = 'Hello world';

    test('Create new project', () async {
      //open drawer
      await driver.tap(drawerOpenButton);
      await driver.waitFor(projectsText);

      //open "Add project" screen
      await driver.tap(projectsText);
      //await driver.waitFor(addProjectText); // <- does't work, see line below how
      await driver.tap(addProjectKey); //it works only when tap by widget with Key

      //input and add project
      await driver.tap(find.byValueKey('add-project-field')); //again doesn't work with find.text, doesn't work without force focus
      await driver.enterText(projectName);
      await driver.tap(addProjectButton); //again fab only with Key, due to driver finder is limited

      //open drawer and check the project
      await driver.tap(drawerOpenButton);
      await driver.waitFor(projectsText);
      await driver.tap(projectsText);
      //expect(find.text(projectName), ftest.findsOneWidget); <- cause error
      await driver.waitFor(find.text(projectName));
  });

  });

}