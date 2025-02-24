import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:get_it/get_it.dart';
import 'package:sprints_tourist_guide_app/app/validation_service.dart';
import 'package:sprints_tourist_guide_app/presentation/01_auth_screens/widgets/text_form_field.dart';

class MockValidationService extends Mock implements IValidationService {}

void main() {
  late MockValidationService mockValidationService;
  final getIt = GetIt.instance;

  setUp(() {
    mockValidationService = MockValidationService();
    // Register the mock service in GetIt
    getIt.registerSingleton<IValidationService>(mockValidationService);
  });

  tearDown(() {
    // Unregister the service after each test to avoid conflicts
    getIt.unregister<IValidationService>();
  });

  testWidgets('CustomTextFormField renders correctly',
      (WidgetTester tester) async {
    // Arrange
    final controller = TextEditingController();
    const labelText = 'Email';
    const prefixIcon = Icon(Icons.email);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextFormField(
            controller: controller,
            labelText: labelText,
            prefixIcon: prefixIcon,
            inputType: TextInputType.emailAddress,
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(labelText), findsOneWidget);
    expect(find.byIcon(Icons.email), findsOneWidget);
  });

  testWidgets('CustomTextFormField toggles password visibility',
      (WidgetTester tester) async {
    // Arrange
    final controller = TextEditingController();
    const labelText = 'Password';
    const prefixIcon = Icon(Icons.lock);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextFormField(
            controller: controller,
            labelText: labelText,
            prefixIcon: prefixIcon,
            isPasswordField: true,
            inputType: TextInputType.visiblePassword,
          ),
        ),
      ),
    );

    // Initially, the password should be obscured
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsNothing);

    // Tap the visibility toggle button
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();

    // After tapping, the password should be visible
    expect(find.byIcon(Icons.visibility_off), findsNothing);
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });

  testWidgets('CustomTextFormField validates email input',
      (WidgetTester tester) async {
    // Arrange
    final controller = TextEditingController();
    const labelText = 'Email';
    const prefixIcon = Icon(Icons.email);
    final formKey = GlobalKey<FormState>();

    // Mock the validation service to return an error message
    when(mockValidationService.validateEmail(any))
        .thenAnswer((_) => 'Invalid email');

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: CustomTextFormField(
              controller: controller,
              labelText: labelText,
              prefixIcon: prefixIcon,
              inputType: TextInputType.emailAddress,
              validator: mockValidationService.validateEmail,
            ),
          ),
        ),
      ),
    );

    // Enter invalid email
    await tester.enterText(find.byType(TextFormField), 'invalid-email');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(); // Ensure UI updates fully

    // Manually trigger validation
    formKey.currentState?.validate();
    await tester.pumpAndSettle();

    // Assert
    expect(find.textContaining('Invalid email'), findsOneWidget);
  });
}
