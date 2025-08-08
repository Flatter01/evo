import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn;
  final Dio dio = Dio(); // Создаем экземпляр Dio

  FirebaseServices(this.googleSignIn);

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(authCredential);

      final String? idToken = await userCredential.user?.getIdToken();

      return idToken;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: $e');
      return null;
    }
  }

  Future<void> googleSignOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }

  Future<void> sendTokenToBackend(String idToken) async {
    try {
      final response = await dio.post(
        'http://127.0.0.1:8000/auth/login/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('✅ Успешно отправлено на backend');
      } else {
        print('⚠️ Ошибка: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Ошибка при отправке токена: $e');
    }
  }
}
