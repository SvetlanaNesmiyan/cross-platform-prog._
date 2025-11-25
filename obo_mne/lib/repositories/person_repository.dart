import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/person.dart';

class PersonRepository {
  static final PersonRepository _instance = PersonRepository._internal();
  factory PersonRepository() => _instance;
  PersonRepository._internal();

  List<Person> _persons = [];
  bool _initialized = false;
  static const String _storageKey = 'persons_data';

  Future<void> initialize() async {
    if (_initialized) return;
    
    final prefs = await SharedPreferences.getInstance();
    final String? personsJson = prefs.getString(_storageKey);
    
    if (personsJson != null) {
      final List<dynamic> jsonList = jsonDecode(personsJson);
      _persons = jsonList.map((json) => Person.fromJson(json)).toList();
    } else {
      _persons = _getDefaultPersons();
      await _saveToStorage();
    }
    _initialized = true;
  }

  List<Person> _getDefaultPersons() {
    return [
      Person(
        id: 1,
        name: 'Світлана',
        surname: 'Несміян',
        age: 20,
        email: 'Svitlana.Nesmiian@infiz.khpi.edu.ua',
        phone: '+380 97 984 35 20',
        position: 'Студентка третього курсу університету ХПІ',
        skills: ['C++', 'Python', 'SQL', 'Js', 'Git'],
        about: 'Навчаюся та розвиваюся в багатьох сферах. Малюю,слухаю музику, ходжу на курси, граю в гача-игри.',
        education: 'Національний технічний університет «Харківський політехнічний iнститут» України"\nКафедра «Комп’ютерне моделювання процесів і систем»',
        experience: 'Створення веб сайтів, трошки створення веб додатків\nпрограмуваня на різних мовах',
        avatarUrl: 'assets/avatar.jpg',
      ),
      Person(
        id: 2,
        name: 'Котик',
        surname: 'Смішкевич',
        age: 2,
        email: 'cat_smishkevich@gmail.com',
        phone: '+380 (99) 987 65 43',
        position: 'Домашній тусовщик',
        skills: ['Спати', 'Їсти', 'Няукати', 'Заважати працювати', 'Гратися'],
        about: 'Мама каже, що я хороший, я вірю мамі.',
        education: 'Няу',
        experience: 'Няяяу',
        avatarUrl: 'assets/avatar2.jpg',
      ),
      Person(
        id: 3,
        name: 'Киця',
        surname: 'Милашка',
        age: 1,
        email: 'kitty.milashka@gmail.com',
        phone: '+380 (99) 555 44 33',
        position: 'Позитивчик',
        skills: ['Мурчати', 'Пеститися', 'Кусатися', 'Тертися', 'Вилизуватися'],
        about: 'Коли мама мене бачить, вона вмикає звук з тік току та каже що я:"Wi-wi-wi, uwawa".- та посміхається ',
        education: '🐱🎀',
        experience: 'Meow~',
        avatarUrl: 'assets/avatar3.jpg',
      ),
    ];
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String personsJson = jsonEncode(_persons.map((person) => person.toJson()).toList());
    await prefs.setString(_storageKey, personsJson);
  }

  List<Person> getAllPersons() => List.unmodifiable(_persons);

  Person getPersonById(int id) {
    return _persons.firstWhere((person) => person.id == id);
  }

  List<Person> searchPersons(String query) {
    if (query.isEmpty) return getAllPersons();
    
    final lowercaseQuery = query.toLowerCase();
    return _persons.where((person) =>
      person.fullName.toLowerCase().contains(lowercaseQuery) ||
      person.position.toLowerCase().contains(lowercaseQuery) ||
      person.skills.any((skill) => skill.toLowerCase().contains(lowercaseQuery))
    ).toList();
  }

  int getNextId() {
    if (_persons.isEmpty) return 1;
    return _persons.map((person) => person.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  Future<void> addPerson(Person person) async {
    _persons.add(person);
    await _saveToStorage();
  }

  Future<void> updatePerson(Person updatedPerson) async {
    final index = _persons.indexWhere((person) => person.id == updatedPerson.id);
    if (index != -1) {
      _persons[index] = updatedPerson;
      await _saveToStorage();
    }
  }

  Future<void> deletePerson(int id) async {
    _persons.removeWhere((person) => person.id == id);
    await _saveToStorage();
  }

  bool get isInitialized => _initialized;
}