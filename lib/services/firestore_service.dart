import 'package:character/models/character.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  
  static final ref = FirebaseFirestore.instance
  .collection('characters')
  .withConverter(
    fromFirestore: Character.fromFirestore, 
    toFirestore: (Character c, _) => c.toFirestore()
  );

  static Future<void> addCharacter(Character character) async{
    await ref.doc(character.id).set(character);
  }

  static Future<QuerySnapshot<Character>> getCharactersOnce(){
    return ref.get();
  }

  static Future<void> updateCharacter(Character character) async{
    await ref.doc(character.id).update({
      'stats': character.statsMap,
      'points': character.points,
      'skills': character.skills.map((s) => s.id).toList(),
      'isFav':character.isFav
    });
  }

  static Future<void> deleteCharacter(Character character) async{
    await ref.doc(character.id).delete();
  }
}