import '../models/person.dart';

class PersonRepository {
  final List<Person> _persons = [
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
}