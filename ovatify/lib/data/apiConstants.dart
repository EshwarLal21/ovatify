class ApiConstants {
  static const String baseUrl = 'https://ovatify.betfastwallet.com/api/user';

  // Auth Endpoints
  static const String register = '/register';
  static const String login = '/login';
  static const String forgetpassword = '/forget/password';
  static const String verify = '/email/verification';
  static const String resend = '/resend/email';
  static const String reset = '/reset/password';
  //static const String uploadTrack = '/music/creation';
  static const String uploadTrack = '$baseUrl/music/creation';
  static const String getProfile = '$baseUrl/me';



}
