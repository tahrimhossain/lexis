
class LogInWithEmailAndPasswordFailure implements Exception {

  final String message;

  const LogInWithEmailAndPasswordFailure({this.message = 'An unknown exception occurred.'});

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(message: 'Email is not valid or badly formatted.');
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(message: 'This user has been disabled. Please contact support for help.');
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(message: 'Email is not found, please create an account.');
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(message: 'Incorrect password, please try again.');
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }


}