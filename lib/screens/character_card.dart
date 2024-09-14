import 'package:character/models/character.dart';
import 'package:character/screens/profile.dart';
import 'package:character/services/character_store.dart';
import 'package:character/shared/styled_text.dart';
import 'package:character/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character,{super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Hero(
              tag: character.id.toString(),
              child: Image.asset('assets/img/vocations/${character.vocation.image}', width: 80,)),
            const SizedBox(width: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledHeading(character.name),
                StyledText(character.vocation.title),

              ],
            ),

            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (ctx)=>  Profile(character: character,)
                  ));
              }, 
              icon: Icon(Icons.arrow_forward, color: AppColors.textColor),
            ),
            IconButton(
              onPressed: (){
                Provider.of<CharacterStore>(context, listen: false).deleteCharacter(character);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const StyledText('Character deleted by success!'),
                  showCloseIcon: true,
                  duration: const Duration(seconds: 2),
                  backgroundColor: AppColors.secondaryColor,
                ));
              }, 
              icon: Icon(Icons.delete, color: AppColors.textColor),
            )
          ],
        ),
      ),
    );
  }
}