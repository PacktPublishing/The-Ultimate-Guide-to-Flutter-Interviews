import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/widgets/home_screen_test.dart';
import '../test/widgets/list_books_screen_test.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('login flow', () {
    testWidgets('Home-Screen', (tester) => HomeWidgetTest(tester));
    testWidgets('Book-List-Screen', (tester) => ListBookWidgetTest(tester));
  });
}