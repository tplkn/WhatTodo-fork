import 'package:flutter_driver/flutter_driver.dart';
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

    SerializableFinder projectsText = find.text('Projects');
    SerializableFinder addProjectKey = find.byValueKey('add-project');
    SerializableFinder addProjectButton = find.byValueKey('add-project-button');
    const projectName = 'Hello world';

    test('Create new project', () async {
      await driver.tap(projectsText);
      await driver.tap(addProjectKey);

      //input and add project
      await driver.tap(find.byValueKey('add-project-field'));
      await driver.enterText(projectName);
      await driver.tap(addProjectButton);

      //check the project
      await driver.waitFor(projectsText);
//      await driver.tap(addProjectKey);
      await driver.waitFor(find.text(projectName));
  });

  });

}