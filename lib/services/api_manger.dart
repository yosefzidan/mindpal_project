import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mindpal/models/DoctorResponse.dart';
import 'package:mindpal/models/PatientResponseM.dart';
import 'package:mindpal/models/SignInResponse.dart';
import 'package:mindpal/models/single_patient_response_m.dart';
import 'package:mindpal/services/api_constants.dart';
import 'package:mindpal/services/end_points.dart';

class ApiManger {
  static Future<void> postPatient(Patients patients) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.patientApi);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': ApiConstants.Token!,
        },
        body: jsonEncode(patients.toJsonForPost()),
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

  static Future<List<Patients>> getAllPatients() async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.patientApi);
    try {
      final response = await http.get(
        url,
        headers: {
          'token': ApiConstants.Token!,
        },
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List patientsJson = data['patients'];

      return patientsJson.map((json) => Patients.fromJson(json)).toList();
    } catch (e) {
      throw e;
    }
  }

  static Future<Patients> getPatientById(String id) async {
    final Uri url =
        Uri.https(ApiConstants.baseUrl, '${EndPoints.patientApi}/$id');

    try {
      final response = await http.get(
        url,
        headers: {
          'token': ApiConstants.Token!,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final result = SinglePatientResponseM.fromJson(jsonData);
        return result.patient!;
      } else {
        throw Exception(
            '❌ Failed to load patient: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('❌ Exception in getPatientById: $e');
      rethrow;
    }
  }

  static Future<Patients> getPatientById1(String id) async {
    final Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.patientApi);

    try {
      final response = await http.get(
        url,
        headers: {
          'token': ApiConstants.Token!,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        PatientResponseM patientResponse = PatientResponseM.fromJson(data);

        final patient = patientResponse.patients?.firstWhere(
          (p) => p.id == id,
          orElse: () => throw Exception('❌ Patient with id $id not found'),
        );

        return patient!;
      } else {
        throw Exception(
            '❌ Failed to load patients: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('❌ Exception in getPatientById: $e');
      rethrow;
    }
  }

  static Future<void> updatePatient(String id, Patients patients) async {
    final Uri url =
        Uri.https(ApiConstants.baseUrl, '${EndPoints.patientApi}/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': ApiConstants.Token!,
        },
        body: jsonEncode(patients.toJson()),
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

  // doctor

  static Future<void> postDoctor(Doctor doctor) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.doctorsApi);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': ApiConstants.Token!,
        },
        body: jsonEncode(doctor.toJsonForPost()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Doctor added successfully');
      } else {
        throw Exception(
            '❌ Failed to add Doctor: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('❌ Exception in postDoctor: $e');
      rethrow;
    }
  }

  static Future<List<Doctor>> getAllDoctor() async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.doctorsApi);
    try {
      final response = await http.get(
        url,
        headers: {
          'token': ApiConstants.Token!,
        },
      );
      print(response.body);

      final Map<String, dynamic> data = jsonDecode(response.body);
      final List doctorsJson = data['doctors'];

      return doctorsJson.map((json) => Doctor.fromJson(json)).toList();
    } catch (e) {
      throw e;
    }
  }

  static Future<void> deleteDoctor(String id) async {
    Uri url = Uri.https(ApiConstants.baseUrl, '${EndPoints.doctorsApi}/$id');
    try {
      final response = await http.delete(
        url,
        headers: {
          'token': ApiConstants.Token!,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Doctor deleted successfully');
      } else {
        print('Failed to delete doctor. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      throw e;
    }
  }

  // signin

  static Future<SignInResponse> postSignIn(SignInRequest signInRequest) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.signinApi);

    try {
      print('🔵 Sending SignInRequest: ${jsonEncode(signInRequest.toJson())}');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(signInRequest.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return SignInResponse.fromJson(responseBody);
      } else {
        throw Exception(
            '❌ Failed to sign in: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('❌ Exception in postSignIn: $e');
      rethrow;
    }
  }

// Scan

// Medicine
  static Future<void> postMedicine(Medicines medicines) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.medicineApi);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': ApiConstants.Token!,
        },
        body: jsonEncode(medicines.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ medicines added successfully');
      } else {
        throw Exception(
            '❌ Failed to add medicines: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('❌ Exception in postMedicines: $e');
      rethrow;
    }
  }

  static Future<void> updateMedicine(String id, Medicines medicines) async {
    final Uri url =
        Uri.https(ApiConstants.baseUrl, '${EndPoints.medicineApi}/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': ApiConstants.Token!,
        },
        body: jsonEncode(medicines.toJson()),
      );

      if (response.statusCode == 200) {
        print('✅ Medicine updated successfully');
      } else {
        throw Exception(
            '❌ Failed to update Medicine: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('❌ Exception in updateMedicine: $e');
      rethrow;
    }
  }

  static Future<void> deleteMedicine(String id) async {
    Uri url = Uri.https(ApiConstants.baseUrl, '${EndPoints.medicineApi}/$id');
    try {
      final response = await http.delete(
        url,
        headers: {
          'token': ApiConstants.Token!,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Medicine deleted successfully');
      } else {
        print('Failed to delete Medicine. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      throw e;
    }
  }
}
