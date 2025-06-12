import 'package:flutter/material.dart';

class CycleSetupPage extends StatefulWidget {
  @override
  State<CycleSetupPage> createState() => _CycleSetupPageState();
}

class _CycleSetupPageState extends State<CycleSetupPage> {
  DateTime? lastPeriod;
  final periodController = TextEditingController();
  final cycleController = TextEditingController();
  String username = '';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    username = args['username'] ?? '';

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/yanchiqen_logo.png', width: 90)),
              SizedBox(height: 16),
              Text("Set Up Your Cycle",
                  style: TextStyle(fontSize: 22, color: Colors.pink[700], fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("We’ll use this data to help you stay on top of your cycle.",
                  style: TextStyle(color: Colors.grey[600])),
              SizedBox(height: 24),
              Text("When was your last period?"),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().subtract(Duration(days: 2)),
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      lastPeriod = picked;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lastPeriod != null
                            ? "${lastPeriod!.toLocal()}".split(' ')[0]
                            : "Select date",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Icon(Icons.calendar_today, size: 18, color: Colors.orange),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text("How long does your period last? (in days)"),
              SizedBox(height: 8),
              TextField(
                controller: periodController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "e.g. 5",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 18),
              Text("How long is your total cycle duration? (in days)"),
              SizedBox(height: 8),
              TextField(
                controller: cycleController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "e.g. 28",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[200],
                    shape: StadiumBorder(),
                    minimumSize: Size(180, 44),
                  ),
                  child: Text('Done', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/start', arguments: {'username': username});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}