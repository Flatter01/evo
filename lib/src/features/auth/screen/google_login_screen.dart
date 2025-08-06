import 'package:evo/src/core/app_colors.dart';
import 'package:evo/src/features/auth/service/google_auth.dart';
import 'package:evo/src/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      if (mounted) {
        setState(() {});
      }
    });
    _googleSignIn.signInSilently().then((account) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GestureDetector(
            onTap: () async {
              bool result =
                  await FirebaseServices(_googleSignIn).signInWithGoogle();
              if (result) {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (_) => const HomePage()),
                // );
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Ошибка входа")));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.stoneGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/800px-Google_%22G%22_logo.svg.png",
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Войти через Google",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
