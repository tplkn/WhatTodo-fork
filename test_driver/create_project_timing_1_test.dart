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

    test('Create new project', () async {
      final int start = DateTime.now().millisecondsSinceEpoch;
      await driver.tap(projectsText);
      final int iterations = 20;
      int counter = 0;
      while(counter < iterations) {
        final String projectName = 'Hello world $counter';
        await driver.tap(addProjectKey);

        //input and add project
        await driver.tap(find.byValueKey('add-project-field'));
        await driver.enterText(projectName);
        await driver.tap(addProjectButton);

        //check the project
        await driver.waitFor(projectsText);
//      await driver.tap(addProjectKey);
        await driver.scrollIntoView(find.text(projectName));
        await driver.waitFor(find.text(projectName));
        counter++;
      }

      final int end = DateTime.now().millisecondsSinceEpoch;
      final int duration = end - start;
      print('$iterations iterations during $duration ms');
      print('average ${(duration/iterations).toStringAsFixed(2)} ms per test');

  });

  });

}