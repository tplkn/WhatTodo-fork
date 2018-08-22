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
      final duration = Duration(seconds: 20).inMilliseconds;
      await driver.tap(projectsText);
      int iteration = 0;
      while((start + duration) > DateTime.now().millisecondsSinceEpoch) {
        final String projectName = 'Hello world $iteration';
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
        iteration++;
      }

      print('$iteration iterations during $duration ms');
      print('average ${(duration/iteration).toStringAsFixed(2)} ms per test');

  });

  });

}