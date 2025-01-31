import 'package:firebase_auth/firebase_auth.dart';
import '../../app/extensions.dart';
import '../../domain/entities/auth_entity.dart';
import '../network/requests.dart';

abstract class RemoteDataSource {
  Future<AuthenticationEntity> login(LoginRequest loginRequest);
  Future<AuthenticationEntity> register(RegisterRequest registerRequest);
  Future<void> logout();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  RemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<AuthenticationEntity> login(LoginRequest loginRequest) async {
    final UserCredential credential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: loginRequest.email,
      password: loginRequest.password,
    );
    return AuthenticationEntity(
        uid: credential.user!.uid,
        name: credential.user!.displayName.orEmpty(),
        email: credential.user!.email.orEmpty());
  }

  @override
  Future<AuthenticationEntity> register(RegisterRequest registerRequest) async {
    final UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: registerRequest.email,
      password: registerRequest.password,
    );
    // Update user's profile with displayName
    await credential.user?.updateDisplayName(registerRequest.userName);
    // Optionally, reload the user to get updated info
    await credential.user?.reload();
    //return the AuthenticationEntity with updated data.
    return AuthenticationEntity(
        uid: credential.user!.uid,
        name: registerRequest.userName,
        email: credential.user!.email.orEmpty());
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
