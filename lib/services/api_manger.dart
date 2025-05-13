import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mindpal/models/PatientResponse.dart';
import 'package:mindpal/services/api_constants.dart';
import 'package:mindpal/services/end_points.dart';

class ApiManger {
  static Future<void> postPatient(Patient patient) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.patientApi);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': ApiConstants.patientPostToken,
        },
        body: jsonEncode(patient.toJsonForPost()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Patient added successfully');
      } else {
        throw Exception(
            '❌ Failed to add patient: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('❌ Exception in postPatient: $e');
      rethrow;
    }
  }

  static Future<List<Patient>> getAllPatients() async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.patientApi);
    try {
      final response = await http.get(
        url,
        headers: {
          'token': ApiConstants.patientGetAllToken,
        },
      );
      final List data = jsonDecode(response.body);
      return data.map((json) => Patient.fromJson(json)).toList();
    } catch (e) {
      throw e;
    }
  }

  static Future<Patient> getPatientById(String id) async {
    final Uri url =
        Uri.https(ApiConstants.baseUrl, '${EndPoints.patientApi}/$id');

    try {
      final response = await http.get(
        url,
        headers: {
          'token': ApiConstants.patientGetOneToken,
        },
      );

      if (response.statusCode == 200) {
        return Patient.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            '❌ Failed to load patient: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('❌ Exception in getPatientById: $e');
      rethrow;
    }
  }

  static Future<void> updatePatient(String id, Patient patient) async {
    final Uri url =
        Uri.https(ApiConstants.baseUrl, '${EndPoints.patientApi}/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': ApiConstants.patientUpdateToken,
        },
        body: jsonEncode(patient.toJson()),
      );

      if (response.statusCode == 200) {
        print('✅ Patient updated successfully');
      } else {
        throw Exception(
            '❌ Failed to update patient: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('❌ Exception in updatePatient: $e');
      rethrow;
    }
  }
}
