// Example usage and model classes
import 'package:flutter/material.dart';
import 'package:provider_test1/utils/custom_search_bar.dart';

class SearchItem {
  final String title;
  final String subtitle;
  final IconData icon;

  SearchItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

// Example implementation
class SearchBarExample extends StatefulWidget {
  const SearchBarExample({Key? key}) : super(key: key);

  @override
  State<SearchBarExample> createState() => _SearchBarExampleState();
}

class _SearchBarExampleState extends State<SearchBarExample> {
  final List<SearchItem> _searchItems = [
    SearchItem(
      title: 'Flutter',
      subtitle: 'UI toolkit for building natively compiled applications',
      icon: Icons.flutter_dash,
    ),
    SearchItem(
      title: 'Dart',
      subtitle: 'Programming language optimized for building user interfaces',
      icon: Icons.code,
    ),
    SearchItem(
      title: 'Firebase',
      subtitle: 'Platform for building mobile and web applications',
      icon: Icons.cloud,
    ),
    SearchItem(
      title: 'Android',
      subtitle: 'Mobile operating system by Google',
      icon: Icons.android,
    ),
    SearchItem(
      title: 'iOS',
      subtitle: 'Mobile operating system by Apple',
      icon: Icons.phone_iphone,
    ),
  ];

  String _selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Search Bar Demo'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Search Bar
            const Text(
              'Basic Search Bar:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            CustomSearchBar<SearchItem>(
              suggestions: _searchItems,
              displayStringForSuggestion: (item) => item.title,
              onSuggestionSelected: (item) {
                setState(() {
                  _selectedItem = item.title;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${item.title}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              onChanged: (query) {
                // Handle text changes
              },
              onSubmitted: (query) {
                // Handle search submission
              },
            ),
            const SizedBox(height: 24),
            
            // Custom Styled Search Bar
            const Text(
              'Custom Styled Search Bar:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            CustomSearchBar<SearchItem>(
              suggestions: _searchItems,
              displayStringForSuggestion: (item) => item.title,
              hintText: 'Search technologies...',
              maxSuggestions: 3,
              suggestionHeight: 60,
              onSuggestionSelected: (item) {
                setState(() {
                  _selectedItem = item.title;
                });
              },
              onChanged: (query) {},
              onSubmitted: (query) {},
              customSuggestionBuilder: (item) => Container(
                height: 60,
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      size: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            item.subtitle,
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              decoration: InputDecoration(
                hintText: 'Search technologies...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 24),
            
            if (_selectedItem.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Last selected: $_selectedItem',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}