import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/save_success_screen_aya.dart';
import 'package:mindpal/models/PatientResponseM.dart';

class EditUserScreen extends StatefulWidget {
  static const String routeName = "EditUserScreen";

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  Medicines? medicine;
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _pillsPerDayController;
  TimeOfDay _pillTime = TimeOfDay(hour: 10, minute: 30);
  String _hoursApart = 'Every 2 hours';
  String _takingInterval = 'Every 3 days';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 30));

  final List<String> genders = ['Male', 'Female'];
  final List<String> alzStages = [
    'The First Stage',
    'The Second Stage',
    'The Third Stage',
    'The Fourth Stage',
  ];
  final List<String> hoursApartOptions = [
    'Every 1 hour',
    'Every 2 hours',
    'Every 3 hours',
    'Every 4 hours',
  ];
  final List<String> takingIntervals = [
    'Every day',
    'Every 2 days',
    'Every 3 days',
    'Every 5 days',
  ];

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
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: medicine?.name ?? '');
    _amountController = TextEditingController(text: medicine?.dosage ?? '');
    _pillsPerDayController =
        TextEditingController(text: medicine?.schedule ?? '');
    _hoursApart = medicine?.schedule ?? 'Every 2 hours';
    _takingInterval = medicine?.dosage ?? 'Every 3 days';
    String timeString = medicine?.timeToTake ?? '10:30';
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    _pillTime = TimeOfDay(hour: hour, minute: minute);
    _startDate = DateTime.tryParse(medicine?.startDate ?? '') ?? DateTime.now();

    _endDate = DateTime.tryParse(medicine?.endDate ?? '') ??
        DateTime.now().add(const Duration(days: 30));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _pillsPerDayController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFA27AFC),
              surface: Color(0xFF23232B),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF18181B),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _pillTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFA27AFC),
              surface: Color(0xFF23232B),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF18181B),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _pillTime = picked;
      });
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
          'medication details..',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  medicine?.name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.edit,
                      color: Color(0xFFA27AFC), size: 22),
                  tooltip: 'Edit patient details',
                  onPressed: () {
                    // Optionally scroll to the first field
                    // You can add a ScrollController for smooth scroll if desired
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                'This table pertains to the first type of medication.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 13,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField('Medicine Name', _nameController),
            const SizedBox(height: 16),
            _buildTextField('Amount(per one reception)', _amountController),
            const SizedBox(height: 16),
            _buildTextField(
                'Number of pills intake a day', _pillsPerDayController),
            const SizedBox(height: 16),
            _buildTimePicker(
                'Time to take a pill', _pillTime, () => _pickTime(context)),
            const SizedBox(height: 16),
            _buildDropdown(
                'How many hours apart is it taken in a day?',
                _hoursApart,
                hoursApartOptions,
                (val) => setState(() => _hoursApart = val)),
            const SizedBox(height: 16),
            _buildDropdown(
                'Pill taking interval',
                _takingInterval,
                takingIntervals,
                (val) => setState(() => _takingInterval = val)),
            const SizedBox(height: 16),
            _buildDatePicker(
                'Start of course', _startDate, () => _pickDate(context, true)),
            const SizedBox(height: 16),
            _buildDatePicker(
                'End of course', _endDate, () => _pickDate(context, false)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final updatedUser = {
                    'name': _nameController.text,
                    'amount': _amountController.text,
                    'pillsPerDay': _pillsPerDayController.text,
                    'pillTime': _pillTime,
                    'hoursApart': _hoursApart,
                    'takingInterval': _takingInterval,
                    'startDate': _startDate,
                    'endDate': _endDate,
                  };
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SaveSuccessScreen(
                        patientName: _nameController.text,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
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
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF23232B),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFA892F5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFA892F5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFA892F5), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items,
      ValueChanged<String> onChanged) {
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF23232B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFA27AFC)),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: const Color(0xFF23232B),
            iconEnabledColor: const Color(0xFFA27AFC),
            underline: const SizedBox(),
            style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: (val) {
              if (val != null) onChanged(val);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay time, VoidCallback onTap) {
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
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF23232B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFA27AFC)),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: Color(0xFFA27AFC)),
                const SizedBox(width: 8),
                Text(
                  time.format(context),
                  style:
                      const TextStyle(color: Colors.white, fontFamily: 'Inter'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label, DateTime date, VoidCallback onTap) {
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
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF23232B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFA27AFC)),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today,
                    color: Color(0xFFA892F5), size: 18),
                const SizedBox(width: 8),
                Text(
                  '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}',
                  style:
                      const TextStyle(color: Colors.white, fontFamily: 'Inter'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
