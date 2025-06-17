import 'package:mindpal/models/PatientResponseM.dart';

class SinglePatientResponseM {
  String? message;
  Patients? patient;

  SinglePatientResponseM({this.message, this.patient});

  SinglePatientResponseM.fromJson(dynamic json) {
    message = json['message'];
    patient =
        json['patient'] != null ? Patients.fromJson(json['patient']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (patient != null) {
      map['patient'] = patient?.toJson();
    }
    return map;
  }
}
