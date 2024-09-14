import 'package:character/animation/heart.dart';
import 'package:character/models/character.dart';
import 'package:character/screens/skill_list.dart';
import 'package:character/screens/stats_table.dart';
import 'package:character/services/character_store.dart';
import 'package:character/shared/styled_button.dart';
import 'package:character/shared/styled_text.dart';
import 'package:character/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({
    required this.character,
    super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTitle(character.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.secondaryColor.withOpacity(0.3),
                  child: Row(
                    children: [
                      Hero(
                        tag: character.id.toString(),
                        child: Image.asset('assets/img/vocations/${character.vocation.image}',
                          width: 140,
                          height: 140,
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StyledHeading(character.vocation.title),
                            StyledText(character.vocation.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Heart(character: character)),
              ],
            ),
            const SizedBox(height: 20,),
            Center(
              child: Icon(Icons.code, color: AppColors.primaryColor,),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                color: AppColors.secondaryColor.withOpacity(0.5),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StyledHeading('Slogan'),
                    StyledText(character.slogan),
                    const SizedBox(height: 10,),
                    const StyledHeading('Weapon of Choice'),
                    StyledText(character.vocation.weapon),
                    const SizedBox(height: 10,),
                    const StyledHeading('Unique Ability'),
                    StyledText(character.vocation.ability),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  StatsTable(character),
                  SkillList(character),
                ],
              ),
            ),
            StyledButton(
              onPressed: (){
                Provider.of<CharacterStore>(context,listen: false)
                .saveCharacter(character);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const StyledHeading('Character was saves'),
                  showCloseIcon: true,
                  duration: const Duration(seconds: 2),
                  backgroundColor: AppColors.secondaryColor,
                ));
              }, 
              child: const StyledHeading('Save Character'),
            )
          ],
        ),
      ),
    );
  }
}