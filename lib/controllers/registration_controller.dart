import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/registration_model.dart';

class RegistrationController {
  final _supabase = Supabase.instance.client;

  Future<List<Registration>> fetchRegistrations() async {
    final response = await _supabase.from('registrations').select();
    return response.map((e) => Registration.fromJson(e)).toList();
  }

  Future<void> addRegistration(Registration registration) async {
    await _supabase.from('registrations').insert(registration.toJson());
  }

  Future<void> updateRegistration(Registration registration) async {
    await _supabase
        .from('registrations')
        .update(registration.toJson())
        .eq('id', registration.id!);
  }

  Future<void> deleteRegistration(String id) async {
    await _supabase.from('registrations').delete().eq('id', id);
  }
}