import 'package:flutter/material.dart';
import 'search_model.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late SearchModel searchModel;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    searchModel = SearchModel()..addListener(_onSearchModelChanged);
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    searchModel.removeListener(_onSearchModelChanged);
    searchModel.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _onSearchModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _clearSearch() {
    searchModel.textController.clear();
    searchModel.searchUsers('');
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 1, 61), // Set the background color to #00013d
      body: GestureDetector(
        onTap: () => focusNode.unfocus(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // This will center the children vertically
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  16.0, 100.0, 16.0, 16.0), // Add top padding
              child: TextField(
                focusNode: focusNode,
                controller: searchModel.textController,
                style: const TextStyle(color: Colors.grey), // Text color
                decoration: InputDecoration(
                  hintText: 'Search for accounts...',
                  hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.5)), // Hint text color
                  fillColor: Colors.white, // White background
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close,
                        color: Colors.grey), // Icon color
                    onPressed: _clearSearch,
                  ),
                  prefixIcon: const Icon(Icons.search,
                      color: Colors.grey), // Icon color
                ),
                onChanged: (query) {
                  searchModel.searchUsers(query);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchModel.users.length,
                itemBuilder: (context, index) {
                  final user = searchModel.users[index];
                  return Card(
                    color: Colors.transparent, // Card color
                    elevation: 0, // No shadow
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius:
                            35.0, // Increase the radius to make the image larger
                        backgroundImage: NetworkImage(user.photoUrl),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text(
                        user.displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Title text color
                        ),
                      ),
                      subtitle: Text(
                        user.role,
                        style: const TextStyle(
                          color: Color.fromARGB(
                              255, 87, 99, 108), // Subtitle text color
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color.fromARGB(255, 237, 73, 188), // Icon color
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
