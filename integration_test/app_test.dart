import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:v2_product_arena/main.dart' as app;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';

void main() {
  group('Testing App Performance Tests', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    test('can configure Amplify', () async {
      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
      await Amplify.addPlugin(authPlugin);

      try {
        await Amplify.configure(amplifyconfig);
      } on AmplifyAlreadyConfiguredException {
        safePrint(
            "Tried to reconfigure Amplify: This can occur when your app restarts on Android.");
      }
    });
    testWidgets('Test1', (tester) async {});
    testWidgets('Test2', (tester) async {});
  });
}
