# sprints_tourist_guide_app

![Status](https://img.shields.io/badge/Status-Active-brightgreen)
![Dart](https://img.shields.io/badge/Dart-100%25-brightgreen)
![Flutter](https://img.shields.io/badge/Flutter-Cross%20Platform-blue)

A new Flutter project for learning purposes.

## 👀 Overview

This project is a mobile application designed for tourists visiting Egypt. The app helps users explore landmarks, museums, and attractions across various Egyptian governorates, providing a user-friendly interface and engaging features. Different states of the app are managed using Bloc State Management.

## ✨ Features:

- **Firebase Auth:** login | register via user name and password, forgot password.
- **Edit** user profile.
- **FireStore database:** store and retrieving users data using express queries.
- **Client-Side Validation** on login, register, forgot password pages.
- Animations (Transition Animation, Lottie, etc.).
- Custom Light/Dark Mode.
- Modern UI with New Material Widgets.
- Support both **Arabic and English** locales.
- **Navigation & Routing** using google maps (mobile & tablet only)
- Like | Unlike Places.
- **And much more...**

## 📑 Screens Description

### 1. Authentication

- **Signup:** Users enter Full Name, Email, Password, and optional Phone Number.
- **Login:** Users enter Email and Password to access the app.

### 2. Home Page

- **Suggested Places:** Grid view of recommended places.
- **Popular Places:** Scrollable cards with an image, name, governorate, and a favorite button.

### 3. Governments Page

- List of three Egyptian governorates.
- Selecting one shows details of two landmarks in that area.
- **Google Maps Integration:** Users can view the location of landmarks and navigate to them.

### 4. Profile Page

- Shows user details (Full Name, Email, Avatar).
- Users can edit their name, phone, and avatar.
- Language (Arabic/English) and theme (Light/Dark) toggle.

### 5. Favorites Page

- Displays saved places like the "Popular Places" section.

## 📸 Screens 0.0.1

 <div style="display: flex; gap: 10px;">
    <img src="readme/vol1/login_1.jpg" alt="splash Screen" width="200">
    <img src="readme/vol1/login_2.jpg"alt="home" width="200">
    <img src="readme/vol1/home_1.jpg" alt="bottom sheet" width="200">
    <img src="readme/vol1/home_2.jpg" alt="bottom sheet" width="200">
 </div>

 <div style="display: flex; gap: 10px;">
    <img src="readme/vol1/home_3.jpg" alt="home" width="200">
    <img src="readme/vol1/home_4.jpg" alt="home" width="200">
    <img src="readme/vol1/home_5.jpg" alt="home" width="200">
    <img src="readme/vol1/home_6.jpg" alt="home" width="200">
 </div>

 <div style="display: flex; gap: 10px;">
    <img src="readme/vol1/home_7.jpg" alt="home" width="200">
    <img src="readme/vol1/home_8.jpg" alt="home" width="200">
    <img src="readme/vol1/home_9.jpg" alt="home" width="200">
    <img src="readme/vol1/home_10.jpg" alt="home" width="200">
 </div>

## 📸 Screens 0.0.2

 <div style="display: flex; gap: 10px;">
    <img src="readme/version2/login_1.jpg" alt="login" width="200">
    <img src="readme/version2/image_picker_1.jpg" alt="login" width="200">
    <img src="readme/version2/login_2.jpg"alt="login" width="200">
    <img src="readme/version2/login_3.jpg" alt="login" width="200">
    
 </div>

 <div style="display: flex; gap: 10px;">
   <img src="readme/version2/login_4.jpg" alt="login" width="200">
   <img src="readme/version2/home_1.jpg" alt="home" width="200">
   <img src="readme/version2/home_2.jpg" alt="home" width="200">
   <img src="readme/version2/home_3.jpg" alt="home" width="200">
 </div>

 <div style="display: flex; gap: 10px;">
   <img src="readme/version2/home_4.jpg" alt="home" width="200">
   <img src="readme/version2/maps_1.jpg" alt="home" width="200">
   <img src="readme/version2/home_5.jpg" alt="home" width="200">
   <img src="readme/version2/maps_4.jpg" alt="home" width="200">
 </div>

 <div style="display: flex; gap: 10px;">
   <img src="readme/version2/permission_1.jpg" alt="home" width="200">
   <img src="readme/version2/home_7.jpg" alt="home" width="200">
   <img src="readme/version2/home_8.jpg" alt="home" width="200">
   <img src="readme/version2/home_9.jpg" alt="home" width="200">
 </div>

---

# 🧪 Unit Testing for LikeUnlikeCubit

Unit testing ensures that the `LikeUnlikeCubit` correctly handles the toggling of favorite places. The tests validate:

- The correct state transitions (`Loading`, `Success`, `Failure`).
- The interaction with the `ToggleFavouriteUsecase`.

## Implementation of Unit Tests

### Test Dependencies

The following dependencies were used:

```yaml
flutter_test:
  sdk: flutter
build_runner: ^2.4.14
bloc_test: ^9.1.0
mockito: ^5.4.0
```

### Test Setup

A mock version of `ToggleFavouriteUsecase` was created using Mockito:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:sprints_tourist_guide_app/domain/entities/place_entity.dart';
import 'package:sprints_tourist_guide_app/domain/usecase/toggle_favourite_usecase.dart';
import 'package:sprints_tourist_guide_app/presentation/cubit/like_unlike/like_unlike_cubit.dart';
import 'like_unlike_cubit_test.mocks.dart';

@GenerateMocks([ToggleFavouriteUsecase])
void main() {
  late LikeUnlikeCubit cubit;
  late MockToggleFavouriteUsecase mockUsecase;
  late PlaceEntity testPlace;

  setUp(() {
    mockUsecase = MockToggleFavouriteUsecase();
    cubit = LikeUnlikeCubit(mockUsecase);
    testPlace = PlaceEntity(id: '1', name: 'Test Place', likes: []);
  });
```

then rung this command in the terminal to generate the mock using build runner:

```sh
flutter pub run build_runner build --delete-conflicting-output
```

### Test Cases

#### 1. Successful Toggle

```dart
  blocTest<LikeUnlikeCubit, LikeUnlikeState>(
    'emits [LikeUnlikeLoading, LikeUnlikeSuccess] when toggle is successful',
    build: () {
      when(mockUsecase.execute(testPlace)).thenAnswer((_) async => Right(true));
      return cubit;
    },
    act: (cubit) => cubit.toggle(place: testPlace),
    expect: () => [LikeUnlikeLoading(), LikeUnlikeSuccess()],
  );
```

#### 2. Failure Case

```dart
  blocTest<LikeUnlikeCubit, LikeUnlikeState>(
    'emits [LikeUnlikeLoading, LikeUnlikeFailure] when toggle fails',
    build: () {
      when(mockUsecase.execute(testPlace)).thenAnswer((_) async => Left(Failure('Error', 500)));
      return cubit;
    },
    act: (cubit) => cubit.toggle(place: testPlace),
    expect: () => [LikeUnlikeLoading(), LikeUnlikeFailure('Error 500')],
  );
```

## 💣 Issues Faced

1. **Undefined Name 'main' Error**

   - Cause: Test files were missing a `main()` function.
   - Solution: We deleted the default widet test instead of comment all the content of the file.

2. **State Comparison Issue**
   - Cause: Expected and actual states were not being recognized as identical.
   - Solution: Implemented `Equatable` in state classes for proper comparison:
   ```dart
   class LikeUnlikeState extends Equatable {
     @override
     List<Object> get props => [];
   }
   ```

## ✔ Final Result

<img src="readme/test_outputs/output_1.png" alt="test" >

# 🧪 Widget Testing for CustomTextFormField widget

Widget testing ensures that the `CustomTextFormField` correctly renders, handles password visibility toggling, and validates email input. The tests validate:

- The correct rendering of UI elements.
- The toggling of password visibility.
- The interaction with the `IValidationService` for validation.

## Implementation of Widget Tests

### Test Dependencies

The following dependencies were used:

```yaml
flutter_test:
  sdk: flutter
mockito: ^5.4.0
get_it: ^7.2.0
```

### Test Setup

A mock version of `IValidationService` was created using Mockito:

```dart
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
    getIt.registerSingleton<IValidationService>(mockValidationService);
  });

  tearDown(() {
    getIt.unregister<IValidationService>();
  });
```

### Test Cases

#### 1. Widget Renders Correctly

```dart
testWidgets('CustomTextFormField renders correctly', (WidgetTester tester) async {
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
```

#### 2. Toggles Password Visibility

```dart
testWidgets('CustomTextFormField toggles password visibility', (WidgetTester tester) async {
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
```

#### 3. Validates Email Input

```dart
testWidgets('CustomTextFormField validates email input', (WidgetTester tester) async {
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
  await tester.pumpAndSettle();

  // Manually trigger validation
  formKey.currentState?.validate();
  await tester.pumpAndSettle();

  // Assert
  expect(find.textContaining('Invalid email'), findsOneWidget);
});
```

## 💣 Issues Faced

1. **Mocking Dependency Injection Conflict**

   - Cause: `GetIt` instance was not cleared between tests.
   - Solution: Used `tearDown()` to unregister dependencies after each test.

2. **Visibility Toggle Not Updating Immediately**
   - Cause: The widget tree did not rebuild after state change.
   - Solution: Called `pump()` after tapping the visibility icon to trigger a rebuild.

## ✔ Final Result

<img src="readme/test_outputs/output_2.png" alt="test" >
