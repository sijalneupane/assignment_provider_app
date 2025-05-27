import 'package:flutter/material.dart';

class CustomDateTimeInput extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final String pickerType; // "date" or "time"
  
  const CustomDateTimeInput({
    super.key,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    this.validator,
    required this.pickerType,
    this.readOnly = true,
  });

  @override
  State<CustomDateTimeInput> createState() => _CustomDateTimeInputState();
}

class _CustomDateTimeInputState extends State<CustomDateTimeInput> {
  final FocusNode _focusNode = FocusNode();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
        // Format date as DD/MM/YYYY or use your preferred format
        widget.controller.text =
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
        widget.controller.text = time.format(context);
      });
    }
  }

  void _handlePicker() {
    // Make the comparison case-insensitive and more flexible
    final pickerType = widget.pickerType.toLowerCase();
    if (pickerType == "date") {
      _pickDate();
    } else if (pickerType == "time") {
      _pickTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onTap: widget.readOnly ? _handlePicker : null,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        errorMaxLines: 3,
        contentPadding: const EdgeInsets.all(10),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.orange),
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        alignLabelWithHint: true,
        suffixIcon: widget.suffixIcon ?? 
          Icon(
            widget.pickerType.toLowerCase() == "date" 
              ? Icons.calendar_today 
              : Icons.access_time,
            color: Colors.grey,
          ),
        prefixIcon: widget.prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}