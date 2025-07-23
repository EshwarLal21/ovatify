import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? _user;

  Future<void> _loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Get access token
        final accessToken = result.accessToken;

        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken!.tokenString);

        // Sign in with Firebase
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        setState(() {
          _user = userCredential.user;
        });
      } else {
        print('Facebook login failed: ${result.message}');
      }
    } catch (e) {
      print('Error during Facebook login: $e');
    }
  }

  Future<void> _logout() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
    setState(() {
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook Login Demo'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Center(
        child: _user == null
            ? ElevatedButton.icon(
          icon: const Icon(Icons.facebook),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade800,
            padding: const EdgeInsets.symmetric(
                vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: _loginWithFacebook,
          label: const Text(
            'Login with Facebook',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
              _user!.photoURL != null ? NetworkImage(_user!.photoURL!) : null,
              child: _user!.photoURL == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              'Hello, ${_user!.displayName ?? 'User'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              _user!.email ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
