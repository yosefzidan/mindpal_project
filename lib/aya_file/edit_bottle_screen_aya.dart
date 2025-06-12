import 'package:flutter/material.dart';

class EditBottleScreen extends StatefulWidget {
  static const String routeName = "EditBottleScreen";

  final Map<String, String> bottle;
  final Function(Map<String, String>) onSave;

  const EditBottleScreen({
    Key? key,
    required this.bottle,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditBottleScreen> createState() => _EditBottleScreenState();
}

class _EditBottleScreenState extends State<EditBottleScreen> {
  late TextEditingController _nameController;
  late TextEditingController _countController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.bottle['name']);
    _countController = TextEditingController(text: widget.bottle['count']);
    _descController = TextEditingController(text: widget.bottle['desc']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final purple = const Color(0xFFA27AFC);
    final dark = const Color(0xFF191919);

    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
        backgroundColor: dark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Bottle',
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
            const Text(
              'Bottle Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              label: 'Medicine Name',
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Count',
              controller: _countController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Description',
              controller: _descController,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final updatedBottle = {
                    ...widget.bottle,
                    'name': _nameController.text,
                    'count': _countController.text,
                    'desc': _descController.text,
                  };
                  widget.onSave(updatedBottle);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Changes',
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
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
              borderSide: BorderSide.none,
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
}
