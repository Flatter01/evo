import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn;

  FirebaseServices(this.googleSignIn);

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return false;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await auth.signInWithCredential(authCredential);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> googleSignOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}
