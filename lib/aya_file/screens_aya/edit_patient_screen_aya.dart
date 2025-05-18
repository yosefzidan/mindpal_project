import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/madel_aya/patient_aya.dart';

class EditPatientScreen extends StatefulWidget {
  static const String routeName = "EditPatientScreen";

  final Patient patient;

  const EditPatientScreen({Key? key, required this.patient}) : super(key: key);

  @override
  State<EditPatientScreen> createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _medicalHistoryController;
  late TextEditingController _currentMedicationsController;
  late TextEditingController _allergiesController;
  late TextEditingController _familyHistoryController;
  late TextEditingController _lifestyleController;
  late TextEditingController _socialHistoryController;
  late TextEditingController _occupationalHistoryController;
  late TextEditingController _developmentalHistoryController;
  late TextEditingController _psychiatricHistoryController;
  late TextEditingController _substanceUseController;
  late TextEditingController _legalHistoryController;
  late TextEditingController _culturalBackgroundController;
  late TextEditingController _spiritualBeliefsController;
  late TextEditingController _supportSystemController;
  late TextEditingController _copingMechanismsController;
  late TextEditingController _riskFactorsController;
  late TextEditingController _protectiveFactorsController;
  late TextEditingController _strengthsController;
  late TextEditingController _challengesController;
  late TextEditingController _goalsController;
  late TextEditingController _treatmentPreferencesController;
  late TextEditingController _barriersToTreatmentController;
  late TextEditingController _motivationController;
  late TextEditingController _expectationsController;
  late TextEditingController _concernsController;
  late TextEditingController _questionsController;
  late TextEditingController _otherController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.patient.name);
    _ageController = TextEditingController(text: widget.patient.age.toString());
    _phoneController = TextEditingController(text: widget.patient.phone);
    _emailController = TextEditingController(text: widget.patient.email);
    _addressController = TextEditingController(text: widget.patient.address);
    _medicalHistoryController = TextEditingController(
      text: widget.patient.medicalHistory,
    );
    _currentMedicationsController = TextEditingController(
      text: widget.patient.currentMedications,
    );
    _allergiesController = TextEditingController(
      text: widget.patient.allergies,
    );
    _familyHistoryController = TextEditingController(
      text: widget.patient.familyHistory,
    );
    _lifestyleController = TextEditingController(
      text: widget.patient.lifestyle,
    );
    _socialHistoryController = TextEditingController(
      text: widget.patient.socialHistory,
    );
    _occupationalHistoryController = TextEditingController(
      text: widget.patient.occupationalHistory,
    );
    _developmentalHistoryController = TextEditingController(
      text: widget.patient.developmentalHistory,
    );
    _psychiatricHistoryController = TextEditingController(
      text: widget.patient.psychiatricHistory,
    );
    _substanceUseController = TextEditingController(
      text: widget.patient.substanceUse,
    );
    _legalHistoryController = TextEditingController(
      text: widget.patient.legalHistory,
    );
    _culturalBackgroundController = TextEditingController(
      text: widget.patient.culturalBackground,
    );
    _spiritualBeliefsController = TextEditingController(
      text: widget.patient.spiritualBeliefs,
    );
    _supportSystemController = TextEditingController(
      text: widget.patient.supportSystem,
    );
    _copingMechanismsController = TextEditingController(
      text: widget.patient.copingMechanisms,
    );
    _riskFactorsController = TextEditingController(
      text: widget.patient.riskFactors,
    );
    _protectiveFactorsController = TextEditingController(
      text: widget.patient.protectiveFactors,
    );
    _strengthsController = TextEditingController(
      text: widget.patient.strengths,
    );
    _challengesController = TextEditingController(
      text: widget.patient.challenges,
    );
    _goalsController = TextEditingController(text: widget.patient.goals);
    _treatmentPreferencesController = TextEditingController(
      text: widget.patient.treatmentPreferences,
    );
    _barriersToTreatmentController = TextEditingController(
      text: widget.patient.barriersToTreatment,
    );
    _motivationController = TextEditingController(
      text: widget.patient.motivation,
    );
    _expectationsController = TextEditingController(
      text: widget.patient.expectations,
    );
    _concernsController = TextEditingController(text: widget.patient.concerns);
    _questionsController = TextEditingController(
      text: widget.patient.questions,
    );
    _otherController = TextEditingController(text: widget.patient.other);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _medicalHistoryController.dispose();
    _currentMedicationsController.dispose();
    _allergiesController.dispose();
    _familyHistoryController.dispose();
    _lifestyleController.dispose();
    _socialHistoryController.dispose();
    _occupationalHistoryController.dispose();
    _developmentalHistoryController.dispose();
    _psychiatricHistoryController.dispose();
    _substanceUseController.dispose();
    _legalHistoryController.dispose();
    _culturalBackgroundController.dispose();
    _spiritualBeliefsController.dispose();
    _supportSystemController.dispose();
    _copingMechanismsController.dispose();
    _riskFactorsController.dispose();
    _protectiveFactorsController.dispose();
    _strengthsController.dispose();
    _challengesController.dispose();
    _goalsController.dispose();
    _treatmentPreferencesController.dispose();
    _barriersToTreatmentController.dispose();
    _motivationController.dispose();
    _expectationsController.dispose();
    _concernsController.dispose();
    _questionsController.dispose();
    _otherController.dispose();
    super.dispose();
  }

  void _savePatient() {
    if (_formKey.currentState!.validate()) {
      // Update patient data
      final updatedPatient = widget.patient.copyWith(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        phone: _phoneController.text,
        email: _emailController.text,
        address: _addressController.text,
        medicalHistory: _medicalHistoryController.text,
        currentMedications: _currentMedicationsController.text,
        allergies: _allergiesController.text,
        familyHistory: _familyHistoryController.text,
        lifestyle: _lifestyleController.text,
        socialHistory: _socialHistoryController.text,
        occupationalHistory: _occupationalHistoryController.text,
        developmentalHistory: _developmentalHistoryController.text,
        psychiatricHistory: _psychiatricHistoryController.text,
        substanceUse: _substanceUseController.text,
        legalHistory: _legalHistoryController.text,
        culturalBackground: _culturalBackgroundController.text,
        spiritualBeliefs: _spiritualBeliefsController.text,
        supportSystem: _supportSystemController.text,
        copingMechanisms: _copingMechanismsController.text,
        riskFactors: _riskFactorsController.text,
        protectiveFactors: _protectiveFactorsController.text,
        strengths: _strengthsController.text,
        challenges: _challengesController.text,
        goals: _goalsController.text,
        treatmentPreferences: _treatmentPreferencesController.text,
        barriersToTreatment: _barriersToTreatmentController.text,
        motivation: _motivationController.text,
        expectations: _expectationsController.text,
        concerns: _concernsController.text,
        questions: _questionsController.text,
        other: _otherController.text,
      );

      // Navigate back to patient details screen with updated patient
      Navigator.pop(context, updatedPatient);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Patient'),
        backgroundColor: Colors.blue,
        foregroundColor: Color(0x41ffffff),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSection('Personal Information', [
                  _buildTextField('Name', _nameController),
                  _buildTextField(
                    'Age',
                    _ageController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    'Phone',
                    _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    'Email',
                    _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildTextField('Address', _addressController, maxLines: 2),
                ]),
                const SizedBox(height: 16),
                _buildSection('Medical Information', [
                  _buildTextField(
                    'Medical History',
                    _medicalHistoryController,
                    maxLines: 3,
                  ),
                  _buildTextField(
                    'Current Medications',
                    _currentMedicationsController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Allergies',
                    _allergiesController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Family History',
                    _familyHistoryController,
                    maxLines: 2,
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection('Lifestyle & Social History', [
                  _buildTextField(
                    'Lifestyle',
                    _lifestyleController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Social History',
                    _socialHistoryController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Occupational History',
                    _occupationalHistoryController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Developmental History',
                    _developmentalHistoryController,
                    maxLines: 2,
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection('Mental Health History', [
                  _buildTextField(
                    'Psychiatric History',
                    _psychiatricHistoryController,
                    maxLines: 3,
                  ),
                  _buildTextField(
                    'Substance Use',
                    _substanceUseController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Legal History',
                    _legalHistoryController,
                    maxLines: 2,
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection('Cultural & Spiritual', [
                  _buildTextField(
                    'Cultural Background',
                    _culturalBackgroundController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Spiritual Beliefs',
                    _spiritualBeliefsController,
                    maxLines: 2,
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection('Support & Coping', [
                  _buildTextField(
                    'Support System',
                    _supportSystemController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Coping Mechanisms',
                    _copingMechanismsController,
                    maxLines: 2,
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection('Risk & Protective Factors', [
                  _buildTextField(
                    'Risk Factors',
                    _riskFactorsController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Protective Factors',
                    _protectiveFactorsController,
                    maxLines: 2,
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection('Strengths & Challenges', [
                  _buildTextField(
                    'Strengths',
                    _strengthsController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Challenges',
                    _challengesController,
                    maxLines: 2,
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection('Treatment & Goals', [
                  _buildTextField('Goals', _goalsController, maxLines: 2),
                  _buildTextField(
                    'Treatment Preferences',
                    _treatmentPreferencesController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Barriers to Treatment',
                    _barriersToTreatmentController,
                    maxLines: 2,
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection('Additional Information', [
                  _buildTextField(
                    'Motivation',
                    _motivationController,
                    maxLines: 2,
                  ),
                  _buildTextField(
                    'Expectations',
                    _expectationsController,
                    maxLines: 2,
                  ),
                  _buildTextField('Concerns', _concernsController, maxLines: 2),
                  _buildTextField(
                    'Questions',
                    _questionsController,
                    maxLines: 2,
                  ),
                  _buildTextField('Other', _otherController, maxLines: 2),
                ]),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _savePatient,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Color(0x41ffffff),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
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
        ...children,
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
