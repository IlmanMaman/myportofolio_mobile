import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _institution = "";
  String _degree = "Bachelor's (S1)";
  String _fieldOfStudy = "";
  String _gpa = "";
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _degrees = [
    "High School (SMA/SMK)",
    "Associate's (D3)",
    "Bachelor's (S1)",
    "Master's (S2)",
    "Doctorate (S3)",
  ];

  // Helper untuk format tanggal menjadi YYYY-MM-DD
  String _formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }

  // Helper untuk membuka DatePicker
  Future<void> _pickDate({required bool isStartDate}) async {
    final initialDate = isStartDate
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? _startDate ?? DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Education Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === 1. Institution Name ===
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Example: Universitas Indonesia",
                    labelText: "Institution Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _institution = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Institution name cannot be empty.";
                    }
                    if (value.trim().length < 3) {
                      return "Institution name must be at least 3 characters.";
                    }
                    return null;
                  },
                ),
              ),

              // === 2. Degree Level ===
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Degree Level",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  initialValue: _degree,
                  items: _degrees
                      .map((degree) => DropdownMenuItem(
                            value: degree,
                            child: Text(degree),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _degree = newValue;
                      });
                    }
                  },
                ),
              ),

              // === 3. Field of Study / Major ===
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Example: Information Systems",
                    labelText: "Field of Study / Major",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _fieldOfStudy = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Field of study cannot be empty.";
                    }
                    return null;
                  },
                ),
              ),

              // === 4. GPA / Score ===
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: "Example: 3.85 (optional)",
                    labelText: "GPA (0.00 - 4.00)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _gpa = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value != null && value.trim().isNotEmpty) {
                      final parsed = double.tryParse(value.trim());
                      if (parsed == null || parsed < 0.0 || parsed > 4.0) {
                        return "Enter a valid GPA between 0.00 and 4.00.";
                      }
                    }
                    return null;
                  },
                ),
              ),

              // === 5. Start Date (FormField + showDatePicker) ===
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: FormField<DateTime>(
                  validator: (_) {
                    if (_startDate == null) {
                      return "Please select a start date.";
                    }
                    return null;
                  },
                  builder: (FormFieldState<DateTime> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            await _pickDate(isStartDate: true);
                            state.didChange(_startDate);
                          },
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: "Start Date",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorText: state.errorText,
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                            child: Text(
                              _startDate == null
                                  ? "Select start date"
                                  : _formatDate(_startDate!),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // === 6. End Date / Expected Graduation ===
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FormField<DateTime>(
                  validator: (_) {
                    if (_endDate == null) {
                      return "Please select an end or expected graduation date.";
                    }
                    if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                      return "End date cannot be earlier than start date.";
                    }
                    return null;
                  },
                  builder: (FormFieldState<DateTime> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            await _pickDate(isStartDate: false);
                            state.didChange(_endDate);
                          },
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: "End Date (or Expected)",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorText: state.errorText,
                              suffixIcon: const Icon(Icons.event),
                            ),
                            child: Text(
                              _endDate == null
                                  ? "Select end date"
                                  : _formatDate(_endDate!),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // === Save Button ===
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 14.0,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Education Added Successfully!'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Institution: ${_institution.trim()}'),
                                  Text('Degree: $_degree'),
                                  Text(
                                      'Field of Study: ${_fieldOfStudy.trim()}'),
                                  Text(
                                      'GPA: ${_gpa.trim().isEmpty ? "-" : _gpa.trim()}'),
                                  Text('Start Date: ${_formatDate(_startDate!)}'),
                                  Text('End Date: ${_formatDate(_endDate!)}'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _formKey.currentState!.reset();
                                  setState(() {
                                    _institution = "";
                                    _degree = "Bachelor's (S1)";
                                    _fieldOfStudy = "";
                                    _gpa = "";
                                    _startDate = null;
                                    _endDate = null;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}