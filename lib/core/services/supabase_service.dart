// lib/core/services/supabase_service.dart

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static late SupabaseClient client;

  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://khywpgvcmkwvufquiudy.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtoeXdwZ3ZjbWt3dnVmcXVpdWR5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk1MDQ2NDAsImV4cCI6MjA4NTA4MDY0MH0.f-no2MOG1fBtbcV73E4z2ALxtWhsbKF4Hz7YwFQQtDA',
    );

    client = Supabase.instance.client;
  }
}
