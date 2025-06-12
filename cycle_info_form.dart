import 'package:flutter/material.dart';

class CycleInfoForm extends StatefulWidget {
  const CycleInfoForm({Key? key}) : super(key: key);

  @override
  State<CycleInfoForm> createState() => _CycleInfoFormState();
}

class _CycleInfoFormState extends State<CycleInfoForm> {
  late TextEditingController _lastPeriodController;
  late TextEditingController _periodLastsController;
  late TextEditingController _cycleLengthController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _lastPeriodController = TextEditingController();
    _periodLastsController = TextEditingController();
    _cycleLengthController = TextEditingController();
  }

  @override
  void dispose() {
    _lastPeriodController.dispose();
    _periodLastsController.dispose();
    _cycleLengthController.dispose();
    super.dispose();
  }

  void _toggleEditing() => setState(() => _isEditing = !_isEditing);

  void _saveChanges() {
    setState(() => _isEditing = false);
    // Save logic goes here
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.93,
            margin: const EdgeInsets.only(top: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black54),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Cycle Information',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.pink[300],
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            _isEditing ? Colors.pink[100] : Colors.grey[200],
                          ),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        onPressed: _isEditing ? _saveChanges : _toggleEditing,
                        child: Text(
                          _isEditing ? 'Save' : 'Edit C/',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.brown[300],
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FieldLabel(
                            label: "The first day of your last menstrual period.",
                            child: TextField(
                              controller: _lastPeriodController,
                              enabled: _isEditing,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                hintText: '',
                              ),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                              readOnly: false,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _FieldLabel(
                            label: "Your period usually last for:",
                            child: TextField(
                              controller: _periodLastsController,
                              enabled: _isEditing,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                hintText: '',
                              ),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          _FieldLabel(
                            label: "Typical cycle length:",
                            child: TextField(
                              controller: _cycleLengthController,
                              enabled: _isEditing,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                hintText: '',
                              ),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldLabel({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}