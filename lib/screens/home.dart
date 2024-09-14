import 'package:character/screens/add_character.dart';
import 'package:character/screens/character_card.dart';
import 'package:character/services/character_store.dart';
import 'package:character/shared/styled_button.dart';
import 'package:character/shared/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    Provider.of<CharacterStore>(context, listen: false)
    .fetchCharactersOnce();
    super.initState();
  }
  
  //List characters = ['mario','luigi','peach', 'bowser', 'koopa'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Your Characters'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child:
                Consumer<CharacterStore>(
                  builder:(context, value, child) {
                    return ListView.builder(
                    itemCount: value.characters.length,
                    itemBuilder: (_,index){
                      return Dismissible(
                        key: ValueKey(value.characters[index].id),
                        onDismissed: (direction){
                          Provider.of<CharacterStore>(context,listen: false)
                          .deleteCharacter(value.characters[index]);
                        },
                        child: CharacterCard(
                          value.characters[index]
                        ),
                      );
                    },
                  );
                  },
                ),
            ),
            StyledButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (ctx) => const AddCharacter()
                ));
              }, 
              child: const StyledHeading('create new')
            )
          ],
        ),
      ),
    );
  }
}