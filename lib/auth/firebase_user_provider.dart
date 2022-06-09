import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseIntegrationFirebaseUser {
  FirebaseIntegrationFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

FirebaseIntegrationFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FirebaseIntegrationFirebaseUser>
    firebaseIntegrationFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FirebaseIntegrationFirebaseUser>(
            (user) => currentUser = FirebaseIntegrationFirebaseUser(user));
