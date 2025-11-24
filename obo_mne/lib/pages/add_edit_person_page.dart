import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/person.dart';
import '../repositories/person_repository.dart';

class AddEditPersonPage extends StatefulWidget {
  final Person? person;
  final bool isDuplicate;

  const AddEditPersonPage({
    super.key,
    this.person,
    this.isDuplicate = false,
  });

  @override
  State<AddEditPersonPage> createState() => _AddEditPersonPageState();
}

class _AddEditPersonPageState extends State<AddEditPersonPage> {
  final _formKey = GlobalKey<FormState>();
  final PersonRepository _personRepository = PersonRepository();

  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _positionController;
  late TextEditingController _skillsController;
  late TextEditingController _aboutController;
  late TextEditingController _educationController;
  late TextEditingController _experienceController;
  late TextEditingController _avatarUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.person?.name ?? '');
    _surnameController = TextEditingController(text: widget.person?.surname ?? '');
    _ageController = TextEditingController(text: widget.person?.age.toString() ?? '');
    _emailController = TextEditingController(text: widget.person?.email ?? '');
    _phoneController = TextEditingController(text: widget.person?.phone ?? '');
    _positionController = TextEditingController(text: widget.person?.position ?? '');
    _skillsController = TextEditingController(text: widget.person?.skills.join(', ') ?? '');
    _aboutController = TextEditingController(text: widget.person?.about ?? '');
    _educationController = TextEditingController(text: widget.person?.education ?? '');
    _experienceController = TextEditingController(text: widget.person?.experience ?? '');
    _avatarUrlController = TextEditingController(text: widget.person?.avatarUrl ?? 'assets/avatar.jpg');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    _skillsController.dispose();
    _aboutController.dispose();
    _educationController.dispose();
    _experienceController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  void _savePerson() {
    if (_formKey.currentState!.validate()) {
      final skillsList = _skillsController.text.split(',').map((skill) => skill.trim()).where((skill) => skill.isNotEmpty).toList();

      final person = Person(
        id: widget.isDuplicate ? _personRepository.getNextId() : (widget.person?.id ?? _personRepository.getNextId()),
        name: _nameController.text,
        surname: _surnameController.text,
        age: int.tryParse(_ageController.text) ?? 0,
        email: _emailController.text,
        phone: _phoneController.text,
        position: _positionController.text,
        skills: skillsList,
        about: _aboutController.text,
        education: _educationController.text,
        experience: _experienceController.text,
        avatarUrl: _avatarUrlController.text,
      );

      if (widget.person == null || widget.isDuplicate) {
        _personRepository.addPerson(person);
      } else {
        _personRepository.updatePerson(person);
      }

      if (mounted) {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.person == null 
          ? 'Додати резюме' 
          : (widget.isDuplicate ? 'Дублювати резюме' : 'Редагувати резюме')),
        backgroundColor: const Color.fromARGB(255, 55, 255, 188),
        foregroundColor: const Color.fromARGB(255, 255, 238, 238),
        actions: [
          if (widget.person != null && !widget.isDuplicate)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _personRepository.deletePerson(widget.person!.id);
                context.go('/');
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Ім\'я *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть ім\'я';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(
                  labelText: 'Прізвище *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть прізвище';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Вік *',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть вік';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Будь ласка, введіть коректний вік';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть email';
                  }
                  if (!value.contains('@')) {
                    return 'Будь ласка, введіть коректний email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Телефон *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть телефон';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(
                  labelText: 'Позиція *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть позицію';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _skillsController,
                decoration: const InputDecoration(
                  labelText: 'Навички (через кому) *',
                  border: OutlineInputBorder(),
                  hintText: 'Наприклад: Flutter, Dart, Git',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть навички';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _aboutController,
                decoration: const InputDecoration(
                  labelText: 'Про мене *',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть інформацію про себе';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _educationController,
                decoration: const InputDecoration(
                  labelText: 'Освіта *',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть освіту';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _experienceController,
                decoration: const InputDecoration(
                  labelText: 'Досвід роботи *',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть досвід роботи';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _avatarUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL аватара',
                  border: OutlineInputBorder(),
                  hintText: 'assets/avatar.jpg',
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _savePerson,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 55, 255, 188),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(widget.person == null ? 'Додати' : 'Зберегти'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.go('/'),
                      child: const Text('Скасувати'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}