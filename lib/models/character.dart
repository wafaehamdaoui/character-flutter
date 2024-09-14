import 'package:character/models/skill.dart';
import 'package:character/models/stats.dart';
import 'package:character/models/vocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Character with Stats{
  
  Character({
    required this.vocation,
    required this.name,
    required this.slogan,
    required this.id
  });
  
  final Set<Skill> skills = {};
  final Vocation  vocation;
  final String name;
  final String slogan;
  final String id;
  bool _isFav = false;

  bool get isFav => _isFav;

  void toggleiIsFav(){
    _isFav = !_isFav;
  }

  void updateSkill(Skill skill){
    skills.clear();
    skills.add(skill);
  }

  Map<String, dynamic> toFirestore(){
    return {
      'name': name,
      'slogan': slogan,
      'isFav': _isFav,
      'vocation': vocation.toString(),
      'skills': skills.map((s) => s.id).toList(),
      'stats': statsMap,
      'points': points,
    };
  }

  factory Character.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,){
      final data = snapshot.data()!;
      Character character = Character(
        vocation: Vocation.values.firstWhere((v) => v.toString() ==data['vocation']), 
        name: data['name'], 
        slogan: data['slogan'], 
        id: snapshot.id,
      );
      for (String id in data['skills']) {
        Skill skill = allSkills.firstWhere((s) => s.id == id);
        character.updateSkill(skill);
      }
      if (data['isFav'] == true) {
        character.toggleiIsFav();
      }
      character.setStats(points: data['points'], stats: data['stats']);
      return character;
  }
}

List<Character> characters = [
  Character(id: '1', name: 'Klara', vocation: Vocation.wizard, slogan: 'Kapumf!'),
  Character(id: '2', name: 'Jonny', vocation: Vocation.junkie, slogan: 'Light me up...'),
  Character(id: '3', name: 'Crimson', vocation: Vocation.raider, slogan: 'Fire in the hole!'),
  Character(id: '4', name: 'Shaun', vocation: Vocation.ninja, slogan: 'Alright then gang.'),
];
