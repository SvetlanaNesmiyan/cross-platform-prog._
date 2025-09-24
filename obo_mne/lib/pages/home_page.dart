import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../repositories/person_repository.dart';
import '../models/person.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersonRepository _personRepository = PersonRepository();
  final TextEditingController _searchController = TextEditingController();
  List<Person> _displayedPersons = [];

  @override
  void initState() {
    super.initState();
    _displayedPersons = _personRepository.getAllPersons();
  }

  void _searchPersons(String query) {
    setState(() {
      _displayedPersons = _personRepository.searchPersons(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список осіб'),
        backgroundColor: Color.fromARGB(255, 55, 255, 188),
        foregroundColor: Color.fromARGB(255, 255, 238, 238),
      ),
      body: Column(
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _PersonListItem extends StatelessWidget {
  final Person person;
  final VoidCallback onTap;

  const _PersonListItem({
    required this.person,
    required this.onTap,
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ))
                  .toList(),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}