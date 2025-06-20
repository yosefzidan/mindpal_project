import 'package:flutter/material.dart';
import 'package:mindpal/models/PatientResponseM.dart';

class ViewMedicineScreen extends StatefulWidget {
  static const String routeName = "ViewMedicineScreen";

  @override
  State<ViewMedicineScreen> createState() => _ViewMedicineScreenState();
}

class _ViewMedicineScreenState extends State<ViewMedicineScreen> {
  Medicines? medicine;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      medicine = args['medicine'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final purple = const Color(0xFFA27AFC);
    final dark = const Color(0xFF18181B);

    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Medication Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      body: medicine == null
          ? const Center(
              child:
                  Text("No data found", style: TextStyle(color: Colors.white)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      medicine?.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildReadOnlyField('Medicine Name', medicine?.name),
                  const SizedBox(height: 16),
                  _buildReadOnlyField('Dosage', medicine?.dosage),
                  const SizedBox(height: 16),
                  _buildReadOnlyField('Schedule', medicine?.schedule),
                  const SizedBox(height: 16),
                  _buildReadOnlyField('Time to take', medicine?.timeToTake),
                  const SizedBox(height: 16),
                  _buildReadOnlyField(
                      'Start Date', medicine?.startDate?.split("T").first),
                  const SizedBox(height: 16),
                  _buildReadOnlyField(
                      'End Date', medicine?.endDate?.split("T").first),
                  const SizedBox(height: 16),
                  _buildReadOnlyField('Bottle Number', medicine?.numPottle),
                  const SizedBox(height: 16),
                  _buildReadOnlyField('Type', medicine?.type),
                ],
              ),
            ),
    );
  }

  Widget _buildReadOnlyField(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF23232B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFA27AFC)),
          ),
          child: Text(
            value ?? 'N/A',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
