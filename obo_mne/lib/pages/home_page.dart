import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:obo_mne/models/user_info.dart';
import 'package:obo_mne/widgets/info_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  UserInfo get _userInfo => const UserInfo(
        name: 'Світлана',
        surname: 'Несміян',
        age: 20,
        email: 'Svitlana.Nesmiian@infiz.khpi.edu.ua',
        phone: '+380 97 984 35 20',
        position: 'Студентка третього курсу університету ХПІ',
        skills: ['C++', 'SQL', 'Python', 'Js', 'Git'],
        about: 'Навчаюся та розвиваюся в багатьох сферах. Малюю,слухаю музику, ходжу на курси, граю в гача-игри.',
        education: 'Бакалавриат',
        experience: 'Дипломи з курсів',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Про мене'),
        backgroundColor: const Color.fromARGB(255, 55, 255, 188),
        foregroundColor: const Color.fromARGB(255, 255, 238, 238),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Аватар и основная информация
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/avatar.jpg')
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${_userInfo.name} ${_userInfo.surname}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _userInfo.position,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInfoItem(Icons.email, _userInfo.email),
                        _buildInfoItem(Icons.phone, _userInfo.phone),
                        _buildInfoItem(Icons.cake, '${_userInfo.age} лет'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Кнопка перехода к деталям
            ElevatedButton(
              onPressed: () => context.go('/details'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 55, 255, 188),
                foregroundColor: const Color.fromARGB(255, 255, 238, 238),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Додатково :3',
                style: TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Быстрый просмотр навыков
            InfoCard(
              title: 'Вміння',
              titleColor: const Color.fromARGB(255, 143, 68, 255),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _userInfo.skills
                    .take(3)
                    .map((skill) => Chip(
                          label: Text(skill),
                          backgroundColor: const Color.fromARGB(255, 55, 255, 188),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color.fromARGB(255, 55, 255, 188)),
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