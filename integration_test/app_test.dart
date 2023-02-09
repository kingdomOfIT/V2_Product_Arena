// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:v2_product_arena/main.dart' as app;

void main() {
  group('Testing App Performance Tests', () {
    // ignore: unnecessary_cast
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Test1', (tester) async {});
    testWidgets('Test2', (tester) async {});
  });
}
