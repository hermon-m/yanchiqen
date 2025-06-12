import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool _notificationsOn = true;
  bool _isEditing = false;
  String _language = "English";

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    setState(() {
      _isEditing = false;
      // Save logic here for preferences
    });
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
                // AppBar row
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
                        'My Preferences',
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
                // Main content
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
                          // Notifications
                          Row(
                            children: [
                              Text(
                                'Notification: ',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                _notificationsOn ? 'On' : 'Off',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Switch(
                                value: _notificationsOn,
                                onChanged: _isEditing
                                    ? (val) {
                                  setState(() {
                                    _notificationsOn = val;
                                  });
                                }
                                    : null,
                                activeColor: Colors.pink[300],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Data Privacy Setting
                          GestureDetector(
                            onTap: _isEditing
                                ? () {
                              // Navigate to privacy settings
                            }
                                : null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Data Privacy Setting',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: Colors.grey[700]),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Application Language
                          Row(
                            children: [
                              Text(
                                'Application Language: ',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                _language,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.language, size: 18, color: Colors.grey[600]),
                            ],
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