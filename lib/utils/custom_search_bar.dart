import 'package:flutter/material.dart';

class CustomSearchBar<T> extends StatefulWidget {
  final String hintText;
  final List<T> suggestions;
  final String Function(T) displayStringForSuggestion;
  final void Function(T) onSuggestionSelected;
  final void Function(String) onChanged;
  final void Function(String) onSubmitted;
  final Widget Function(T)? customSuggestionBuilder;
  final Duration debounceDuration;
  final int maxSuggestions;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final Color? suggestionBackgroundColor;
  final double suggestionHeight;
  final EdgeInsetsGeometry? suggestionPadding;
  final bool showClearButton;
  final IconData? searchIcon;
  final IconData? clearIcon;

  const CustomSearchBar({
    Key? key,
    required this.suggestions,
    required this.displayStringForSuggestion,
    required this.onSuggestionSelected,
    required this.onChanged,
    required this.onSubmitted,
    this.hintText = 'Search...',
    this.customSuggestionBuilder,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.maxSuggestions = 5,
    this.controller,
    this.focusNode,
    this.decoration,
    this.textStyle,
    this.suggestionBackgroundColor,
    this.suggestionHeight = 50.0,
    this.suggestionPadding,
    this.showClearButton = true,
    this.searchIcon = Icons.search,
    this.clearIcon = Icons.clear,
  }) : super(key: key);

  @override
  State<CustomSearchBar<T>> createState() => _CustomSearchBarState<T>();
}

class _CustomSearchBarState<T> extends State<CustomSearchBar<T>> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<T> _filteredSuggestions = [];
  bool _isShowingSuggestions = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    
    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _hideSuggestions();
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      // Add a small delay to allow suggestion tap to register
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          _hideSuggestions();
        }
      });
    }
  }

  void _onTextChanged() {
    final query = _controller.text.trim();
    
    if (query.isEmpty) {
      _hideSuggestions();
      return;
    }

    _filterSuggestions(query);
  }

  void _filterSuggestions(String query) {
    final filtered = widget.suggestions
        .where((item) => widget.displayStringForSuggestion(item)
            .toLowerCase()
            .contains(query.toLowerCase()))
        .take(widget.maxSuggestions)
        .toList();

    setState(() {
      _filteredSuggestions = filtered;
    });

    if (filtered.isNotEmpty && _focusNode.hasFocus) {
      _showSuggestions();
    } else {
      _hideSuggestions();
    }

    widget.onChanged(query);
  }

  void _showSuggestions() {
    if (_isShowingSuggestions) {
      _overlayEntry?.markNeedsBuild();
      return;
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _isShowingSuggestions = true;
  }

  void _hideSuggestions() {
    if (_isShowingSuggestions) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isShowingSuggestions = false;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 2.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8.0),
            color: widget.suggestionBackgroundColor ?? 
                   Theme.of(context).cardColor,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: widget.suggestionHeight * 
                          widget.maxSuggestions.toDouble(),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredSuggestions.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 0.5,
                ),
                itemBuilder: (context, index) {
                  final suggestion = _filteredSuggestions[index];
                  
                  if (widget.customSuggestionBuilder != null) {
                    return InkWell(
                      onTap: () => _onSuggestionTap(suggestion),
                      child: widget.customSuggestionBuilder!(suggestion),
                    );
                  }

                  return InkWell(
                    onTap: () => _onSuggestionTap(suggestion),
                    child: Container(
                      height: widget.suggestionHeight,
                      padding: widget.suggestionPadding ?? 
                               const EdgeInsets.symmetric(
                                 horizontal: 16.0, 
                                 vertical: 12.0
                               ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 20,
                            color: Theme.of(context).hintColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              widget.displayStringForSuggestion(suggestion),
                              style: widget.textStyle ?? 
                                     Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSuggestionTap(T suggestion) {
    _controller.text = widget.displayStringForSuggestion(suggestion);
    _hideSuggestions();
    _focusNode.unfocus();
    widget.onSuggestionSelected(suggestion);
  }

  void _clearSearch() {
    _controller.clear();
    _hideSuggestions();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: widget.textStyle,
        decoration: widget.decoration ?? InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(widget.searchIcon),
          suffixIcon: widget.showClearButton && _controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(widget.clearIcon),
                  onPressed: _clearSearch,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
        ),
        onSubmitted: (value) {
          _hideSuggestions();
          widget.onSubmitted(value);
        },
      ),
    );
  }
}
