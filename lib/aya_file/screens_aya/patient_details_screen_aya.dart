import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/madel_aya/patient_aya.dart';
import 'package:mindpal/aya_file/screens_aya/edit_patient_screen_aya.dart';

class PatientDetailsScreen extends StatefulWidget {
  final Patient patient;

  const PatientDetailsScreen({Key? key, required this.patient})
      : super(key: key);

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  late Patient _patient;

  @override
  void initState() {
    super.initState();
    _patient = widget.patient;
  }

  void _navigateToEditScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPatientScreen(patient: _patient),
      ),
    );

    if (result != null && result is Patient) {
      setState(() {
        _patient = result;
      });
    }
  }

  Widget _buildInfoSection(String title, List<Map<String, String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['label']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['value']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_patient.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToEditScreen,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSection(
              'Personal Information',
              [
                {'label': 'Name', 'value': _patient.name},
                {'label': 'Age', 'value': _patient.age.toString()},
                {'label': 'Phone', 'value': _patient.phone},
                {'label': 'Email', 'value': _patient.email},
                {'label': 'Address', 'value': _patient.address},
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Medical Information',
              [
                {'label': 'Medical History', 'value': _patient.medicalHistory},
                {
                  'label': 'Current Medications',
                  'value': _patient.currentMedications
                },
                {'label': 'Allergies', 'value': _patient.allergies},
                {'label': 'Family History', 'value': _patient.familyHistory},
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Lifestyle & Social History',
              [
                {'label': 'Lifestyle', 'value': _patient.lifestyle},
                {'label': 'Social History', 'value': _patient.socialHistory},
                {
                  'label': 'Occupational History',
                  'value': _patient.occupationalHistory
                },
                {
                  'label': 'Developmental History',
                  'value': _patient.developmentalHistory
                },
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Mental Health History',
              [
                {
                  'label': 'Psychiatric History',
                  'value': _patient.psychiatricHistory
                },
                {'label': 'Substance Use', 'value': _patient.substanceUse},
                {'label': 'Legal History', 'value': _patient.legalHistory},
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Cultural & Spiritual',
              [
                {
                  'label': 'Cultural Background',
                  'value': _patient.culturalBackground
                },
                {
                  'label': 'Spiritual Beliefs',
                  'value': _patient.spiritualBeliefs
                },
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Support & Coping',
              [
                {'label': 'Support System', 'value': _patient.supportSystem},
                {
                  'label': 'Coping Mechanisms',
                  'value': _patient.copingMechanisms
                },
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Risk & Protective Factors',
              [
                {'label': 'Risk Factors', 'value': _patient.riskFactors},
                {
                  'label': 'Protective Factors',
                  'value': _patient.protectiveFactors
                },
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Strengths & Challenges',
              [
                {'label': 'Strengths', 'value': _patient.strengths},
                {'label': 'Challenges', 'value': _patient.challenges},
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Treatment & Goals',
              [
                {'label': 'Goals', 'value': _patient.goals},
                {
                  'label': 'Treatment Preferences',
                  'value': _patient.treatmentPreferences
                },
                {
                  'label': 'Barriers to Treatment',
                  'value': _patient.barriersToTreatment
                },
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Additional Information',
              [
                {'label': 'Motivation', 'value': _patient.motivation},
                {'label': 'Expectations', 'value': _patient.expectations},
                {'label': 'Concerns', 'value': _patient.concerns},
                {'label': 'Questions', 'value': _patient.questions},
                {'label': 'Other', 'value': _patient.other},
              ],
            ),
          ],
        ),
      ),
    );
  }
}
