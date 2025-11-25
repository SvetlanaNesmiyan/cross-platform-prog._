import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../repositories/person_repository.dart';
import '../models/person.dart';
import '../widgets/info_card.dart';
import '../theme_provider.dart';

class DetailsPage extends StatelessWidget {
  final int personId;

  const DetailsPage({
    super.key,
    required this.personId,
  });

  Person get _person {
    final repository = PersonRepository();
    return repository.getPersonById(personId);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_person.fullName),
        backgroundColor: Color.fromARGB(255, 55, 255, 188),
        foregroundColor: Color.fromARGB(255, 255, 238, 238),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(_person.avatarUrl),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _person.fullName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _person.position,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInfoItem(Icons.email, _person.email),
                        _buildInfoItem(Icons.phone, _person.phone),
                        _buildInfoItem(Icons.cake, '${_person.age} років'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            InfoCard(
              title: 'Про мене',
              child: Text(
                _person.about,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            
            const SizedBox(height: 16),
            
            InfoCard(
              title: 'Навички',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _person.skills
                    .map((skill) => Chip(
                          label: Text(skill),
                          backgroundColor: Color.fromARGB(255, 55, 255, 188),
                        ))
                    .toList(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            InfoCard(
              title: 'Освіта',
              child: Text(
                _person.education,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            
            const SizedBox(height: 16),
            
            InfoCard(
              title: 'Досвід роботи',
              child: Text(
                _person.experience,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Color.fromARGB(255, 55, 255, 188)),
        const SizedBox(height: 4),
        SizedBox(
          width: 80,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}