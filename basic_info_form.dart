import 'package:flutter/material.dart';

class BasicInfoForm extends StatefulWidget {
  final String fullName;
  final int age;
  final String aboutMe;

  const BasicInfoForm({
    Key? key,
    this.fullName = "",
    this.age = 0,
    this.aboutMe = "",
  }) : super(key: key);

  @override
  State<BasicInfoForm> createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<BasicInfoForm> {
  late TextEditingController _fullNameController;
  late TextEditingController _ageController;
  late TextEditingController _aboutMeController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.fullName);
    _ageController = TextEditingController(text: widget.age == 0 ? "" : widget.age.toString());
    _aboutMeController = TextEditingController(text: widget.aboutMe);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }

  void _toggleEditing() => setState(() => _isEditing = !_isEditing);

  void _saveChanges() {
    setState(() => _isEditing = false);
    // Save logic here
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black54),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 4),
                Text(
                  'Basic Information',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.pink[300],
                    fontWeight: FontWeight.bold,
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
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                    label: "Full Name:",
                    child: TextField(
                      controller: _fullNameController,
                      enabled: _isEditing,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Enter your full name',
                      ),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(
                    label: "Age:",
                    child: TextField(
                      controller: _ageController,
                      enabled: _isEditing,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Enter your age',
                      ),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "About me:",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _aboutMeController,
                    enabled: _isEditing,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      hintText: '...',
                    ),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final Widget child;

  const _InfoRow({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}