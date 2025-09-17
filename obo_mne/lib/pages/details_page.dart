import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:obo_mne/models/user_info.dart';
import 'package:obo_mne/widgets/info_card.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  UserInfo get _userInfo => const UserInfo(
     name: 'Світлана',
        surname: 'Несміян',
        age: 20,
        email: 'Svitlana.Nesmiian@infiz.khpi.edu.ua',
        phone: '+380 97 984 35 20',
        position: 'Студентка третього курсу університету ХПІ',
        skills: ['C++', 'SQL', 'Python', 'Js', 'Git'],
        about: 'Навчаюся та розвиваюся в багатьох сферах. Малюю,слухаю музику, ходжу на курси, граю в гача-игри.',
        education: 'Національний технічний університет «Харківський політехнічний iнститут» України"\nКафедра «Комп’ютерне моделювання процесів і систем»',
        experience: 'Створення веб сайтів, трошки створення веб додатків\nпрограмуваня на різних мовах',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Додатково :3'),
        backgroundColor: const Color.fromARGB(255, 55, 255, 188),
        foregroundColor: const Color.fromARGB(255, 255, 238, 238),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // О себе
            InfoCard(
              title: 'Про мене',
              titleColor: const Color.fromARGB(255, 143, 68, 255),
              child: Text(
                _userInfo.about,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Образование
            InfoCard(
              title: 'Освіта',
              titleColor: const Color.fromARGB(255, 143, 68, 255),
              child: Text(
                _userInfo.education,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Опыт работы
            InfoCard(
              title: 'Досвід',
              titleColor: const Color.fromARGB(255, 143, 68, 255),
              child: Text(
                _userInfo.experience,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Навыки
            InfoCard(
              title: 'Вміння',
              titleColor: const Color.fromARGB(255, 143, 68, 255),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _userInfo.skills
                    .map((skill) => Chip(
                          label: Text(skill),
                          backgroundColor: const Color.fromARGB(255, 55, 255, 188),
                        ))
                    .toList(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Контактная информация
            InfoCard(
              title: 'Зв/язок зі мною',
              titleColor: const Color.fromARGB(255, 143, 68, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactItem(Icons.email, 'Email', _userInfo.email),
                  _buildContactItem(Icons.phone, 'Телефон', _userInfo.phone),
                  _buildContactItem(Icons.cake, 'Возраст', '${_userInfo.age} лет'),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Кнопка возврата
            ElevatedButton(
              onPressed: () => context.go('/'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 55, 255, 188),
                foregroundColor: const Color.fromARGB(255, 255, 238, 238),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('На головну(;3)'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color.fromARGB(255, 55, 255, 188)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}