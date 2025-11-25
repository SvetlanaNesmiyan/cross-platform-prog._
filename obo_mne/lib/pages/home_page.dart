import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../repositories/person_repository.dart';
import '../models/person.dart';
import '../theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersonRepository _personRepository = PersonRepository();
  final TextEditingController _searchController = TextEditingController();
  List<Person> _displayedPersons = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await _personRepository.initialize();
      if (mounted) {
        setState(() {
          _displayedPersons = _personRepository.getAllPersons();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Помилка завантаження даних: $e';
          _isLoading = false;
        });
      }
    }
  }

  void _searchPersons(String query) {
    setState(() {
      _displayedPersons = _personRepository.searchPersons(query);
    });
  }

  Future<void> _refreshList() async {
    setState(() {
      _isLoading = true;
    });
    await _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список осіб'),
        backgroundColor: const Color.fromARGB(255, 55, 255, 188),
        foregroundColor: const Color.fromARGB(255, 255, 238, 238),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Перемкнути тему',
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => context.go('/github-stats'),
            tooltip: 'GitHub Statistics',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshList,
            tooltip: 'Оновити список',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Завантаження даних...'),
                ],
              ),
            )
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _refreshList,
                        child: const Text('Спробувати знову'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _searchPersons,
                        decoration: InputDecoration(
                          hintText: 'Пошук за іменем, посадою або навичками...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _displayedPersons.isEmpty
                          ? const Center(
                              child: Text(
                                'Нічого не знайдено',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _displayedPersons.length,
                              itemBuilder: (context, index) {
                                final person = _displayedPersons[index];
                                return _PersonListItem(
                                  person: person,
                                  onTap: () => context.go('/details/${person.id}'),
                                  onEdit: () => context.go('/add-edit', extra: {'person': person, 'isDuplicate': false}),
                                  onDuplicate: () => context.go('/add-edit', extra: {'person': person, 'isDuplicate': true}),
                                );
                              },
                            ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add-edit'),
        backgroundColor: const Color.fromARGB(255, 55, 255, 188),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _PersonListItem extends StatelessWidget {
  final Person person;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDuplicate;

  const _PersonListItem({
    required this.person,
    required this.onTap,
    required this.onEdit,
    required this.onDuplicate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(person.avatarUrl),
        ),
        title: Text(
          person.fullName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(person.position),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              children: person.skills
                  .take(2)
                  .map((skill) => Chip(
                        label: Text(
                          skill,
                          style: const TextStyle(fontSize: 10),
                        ),
                        backgroundColor: const Color.fromARGB(255, 55, 255, 188).withOpacity(0.2),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ))
                  .toList(),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: onEdit,
              tooltip: 'Редагувати',
            ),
            IconButton(
              icon: const Icon(Icons.copy, size: 20),
              onPressed: onDuplicate,
              tooltip: 'Дублювати',
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}