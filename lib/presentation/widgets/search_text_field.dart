import 'package:appscrip_pract/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final Function(String) onChanged;

  const SearchTextField({super.key, required this.onChanged});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateClearIconVisibility);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateClearIconVisibility);
    _controller.dispose();
    super.dispose();
  }

  void _updateClearIconVisibility() {
    setState(() {});
    widget.onChanged(_controller.text);
  }

  void _clearText() {
    _controller.clear();
    _updateClearIconVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: AppTextStyles(context).display16W500,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
          borderSide: BorderSide.none,
        ),
        filled: true, // Enable background color
        fillColor: Colors.grey[200], // Background color
        prefixIcon: Icon(Icons.search, color: Colors.grey), // Icon color
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                    Icons.clear), // Clear button for additional functionality
                onPressed: _clearText,
              )
            : null,
      ),
    );
  }
}
