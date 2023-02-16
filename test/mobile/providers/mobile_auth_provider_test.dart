import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';

import 'mobile_auth_provider_test.mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'MockNavigatorObserver';
  }
}

class MockNavigatorState extends Mock implements NavigatorState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'MockNavigatorObserver';
  }
}

class MockMobileAuth extends MobileAuth {
  @override
  void notifyListeners() {}
}

class MockAuth extends Mock implements AuthCategory {
  @override
  Future<SignUpResult> signUp(
      {required String username,
      required String password,
      SignUpOptions? options}) async {
    var result = MockSignUpResult();
    when(result.isSignUpComplete).thenReturn(true);
    return result;
  }
}

@GenerateMocks([
  SignInResult,
  SignUpResult,
  AmplifyClass,
  BuildContext,
  SignOutResult,
  RestOperation
])
void main() {
  test('mobile auth provider ...', () async {
    MobileAuth mobileAuth = MockMobileAuth();
    MockBuildContext mockContext = MockBuildContext();
    MockAmplifyClass test = MockAmplifyClass();
    when(test.Auth).thenReturn(MockAuth());

    var mockNavigatorState = MockNavigatorState();
    when(mockContext.findAncestorStateOfType<NavigatorState>())
        .thenReturn(mockNavigatorState);

    // Add the stub for the push method
    when(mockNavigatorState.pushReplacementNamed('email-verification'))
        .thenAnswer((realInvocation) => Future.value());

    // context.
    AmplifyClass.instance = test;

    // Add the stub for findAncestorStateOfType method
    when(mockContext.findAncestorStateOfType<NavigatorState>())
        .thenReturn(mockNavigatorState);

    await mobileAuth.signUpUser(
        "name",
        "surname",
        "birthDate",
        "city",
        "status",
        "phone",
        "email",
        "password",
        mockContext,
        "/email_verification");

    verify(mobileAuth).called(1);
  });
}
