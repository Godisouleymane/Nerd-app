import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // connexion avec google,
  Future<UserCredential> signInWithGoogle() async {
    // declancher le flux d'authentification

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // obtenir les details d'autorisation de la demande

    final googleAuth = await googleUser!.authentication;

    // creer un nouvel identifiant

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    // une fois connecter renvoyer l'identifiant de l'utilisateur;

    return await _auth.signInWithCredential(credential);
  }

  // L'etat de l'utilisateur en temps reel

  Stream<User?> get user => _auth.authStateChanges();

  // deconnexion
  
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}


