class Patient {
  final String id;
  final String name;
  final int age;
  final String phone;
  final String email;
  final String address;
  final String medicalHistory;
  final String currentMedications;
  final String allergies;
  final String familyHistory;
  final String lifestyle;
  final String socialHistory;
  final String occupationalHistory;
  final String developmentalHistory;
  final String psychiatricHistory;
  final String substanceUse;
  final String legalHistory;
  final String culturalBackground;
  final String spiritualBeliefs;
  final String supportSystem;
  final String copingMechanisms;
  final String riskFactors;
  final String protectiveFactors;
  final String strengths;
  final String challenges;
  final String goals;
  final String treatmentPreferences;
  final String barriersToTreatment;
  final String motivation;
  final String expectations;
  final String concerns;
  final String questions;
  final String other;
  final DateTime createdAt;
  final DateTime updatedAt;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.email,
    required this.address,
    required this.medicalHistory,
    required this.currentMedications,
    required this.allergies,
    required this.familyHistory,
    required this.lifestyle,
    required this.socialHistory,
    required this.occupationalHistory,
    required this.developmentalHistory,
    required this.psychiatricHistory,
    required this.substanceUse,
    required this.legalHistory,
    required this.culturalBackground,
    required this.spiritualBeliefs,
    required this.supportSystem,
    required this.copingMechanisms,
    required this.riskFactors,
    required this.protectiveFactors,
    required this.strengths,
    required this.challenges,
    required this.goals,
    required this.treatmentPreferences,
    required this.barriersToTreatment,
    required this.motivation,
    required this.expectations,
    required this.concerns,
    required this.questions,
    required this.other,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phone': phone,
      'email': email,
      'address': address,
      'medicalHistory': medicalHistory,
      'currentMedications': currentMedications,
      'allergies': allergies,
      'familyHistory': familyHistory,
      'lifestyle': lifestyle,
      'socialHistory': socialHistory,
      'occupationalHistory': occupationalHistory,
      'developmentalHistory': developmentalHistory,
      'psychiatricHistory': psychiatricHistory,
      'substanceUse': substanceUse,
      'legalHistory': legalHistory,
      'culturalBackground': culturalBackground,
      'spiritualBeliefs': spiritualBeliefs,
      'supportSystem': supportSystem,
      'copingMechanisms': copingMechanisms,
      'riskFactors': riskFactors,
      'protectiveFactors': protectiveFactors,
      'strengths': strengths,
      'challenges': challenges,
      'goals': goals,
      'treatmentPreferences': treatmentPreferences,
      'barriersToTreatment': barriersToTreatment,
      'motivation': motivation,
      'expectations': expectations,
      'concerns': concerns,
      'questions': questions,
      'other': other,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      phone: json['phone'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      medicalHistory: json['medicalHistory'] as String,
      currentMedications: json['currentMedications'] as String,
      allergies: json['allergies'] as String,
      familyHistory: json['familyHistory'] as String,
      lifestyle: json['lifestyle'] as String,
      socialHistory: json['socialHistory'] as String,
      occupationalHistory: json['occupationalHistory'] as String,
      developmentalHistory: json['developmentalHistory'] as String,
      psychiatricHistory: json['psychiatricHistory'] as String,
      substanceUse: json['substanceUse'] as String,
      legalHistory: json['legalHistory'] as String,
      culturalBackground: json['culturalBackground'] as String,
      spiritualBeliefs: json['spiritualBeliefs'] as String,
      supportSystem: json['supportSystem'] as String,
      copingMechanisms: json['copingMechanisms'] as String,
      riskFactors: json['riskFactors'] as String,
      protectiveFactors: json['protectiveFactors'] as String,
      strengths: json['strengths'] as String,
      challenges: json['challenges'] as String,
      goals: json['goals'] as String,
      treatmentPreferences: json['treatmentPreferences'] as String,
      barriersToTreatment: json['barriersToTreatment'] as String,
      motivation: json['motivation'] as String,
      expectations: json['expectations'] as String,
      concerns: json['concerns'] as String,
      questions: json['questions'] as String,
      other: json['other'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Patient copyWith({
    String? name,
    int? age,
    String? phone,
    String? email,
    String? address,
    String? medicalHistory,
    String? currentMedications,
    String? allergies,
    String? familyHistory,
    String? lifestyle,
    String? socialHistory,
    String? occupationalHistory,
    String? developmentalHistory,
    String? psychiatricHistory,
    String? substanceUse,
    String? legalHistory,
    String? culturalBackground,
    String? spiritualBeliefs,
    String? supportSystem,
    String? copingMechanisms,
    String? riskFactors,
    String? protectiveFactors,
    String? strengths,
    String? challenges,
    String? goals,
    String? treatmentPreferences,
    String? barriersToTreatment,
    String? motivation,
    String? expectations,
    String? concerns,
    String? questions,
    String? other,
  }) {
    return Patient(
      id: id,
      name: name ?? this.name,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      currentMedications: currentMedications ?? this.currentMedications,
      allergies: allergies ?? this.allergies,
      familyHistory: familyHistory ?? this.familyHistory,
      lifestyle: lifestyle ?? this.lifestyle,
      socialHistory: socialHistory ?? this.socialHistory,
      occupationalHistory: occupationalHistory ?? this.occupationalHistory,
      developmentalHistory: developmentalHistory ?? this.developmentalHistory,
      psychiatricHistory: psychiatricHistory ?? this.psychiatricHistory,
      substanceUse: substanceUse ?? this.substanceUse,
      legalHistory: legalHistory ?? this.legalHistory,
      culturalBackground: culturalBackground ?? this.culturalBackground,
      spiritualBeliefs: spiritualBeliefs ?? this.spiritualBeliefs,
      supportSystem: supportSystem ?? this.supportSystem,
      copingMechanisms: copingMechanisms ?? this.copingMechanisms,
      riskFactors: riskFactors ?? this.riskFactors,
      protectiveFactors: protectiveFactors ?? this.protectiveFactors,
      strengths: strengths ?? this.strengths,
      challenges: challenges ?? this.challenges,
      goals: goals ?? this.goals,
      treatmentPreferences: treatmentPreferences ?? this.treatmentPreferences,
      barriersToTreatment: barriersToTreatment ?? this.barriersToTreatment,
      motivation: motivation ?? this.motivation,
      expectations: expectations ?? this.expectations,
      concerns: concerns ?? this.concerns,
      questions: questions ?? this.questions,
      other: other ?? this.other,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
