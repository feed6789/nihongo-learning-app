import 'package:supabase_flutter/supabase_flutter.dart';

class AuthHelper {
  static User? get currentUser => Supabase.instance.client.auth.currentUser;

  static bool get isGuest => currentUser == null;
}
