import 'package:character/models/character.dart';
import 'package:character/models/vocation.dart';
import 'package:character/screens/vocation_card.dart';
import 'package:character/services/character_store.dart';
import 'package:character/shared/styled_button.dart';
import 'package:character/shared/styled_text.dart';
import 'package:character/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();
class AddCharacter extends StatefulWidget {
  const AddCharacter({super.key});

  @override
  State<AddCharacter> createState() => _AddCharacterState();
}

class _AddCharacterState extends State<AddCharacter> {
  
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose(){
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  Vocation selectedVocation = Vocation.junkie;

  void updateVocation(Vocation vocation){
    setState(() {
      selectedVocation = vocation;
    });
  }

  void handleSubmit(){
    if (_nameController.text.trim().isEmpty) {
      
      showDialog(context: context, builder: (ctx){
        return AlertDialog(
          title: const StyledHeading('Missing Character Name'),
          content: const StyledText('Every good RPG character needs a slogan name'),
          actions: [
            StyledButton(
              onPressed: (){
                Navigator.pop(ctx);
              }, 
              child: const StyledHeading('close')
            )
          ],
        );
      });

      return;
    }
    if (_sloganController.text.trim().isEmpty) {
      showDialog(context: context, builder: (ctx){
        return AlertDialog(
          title: const StyledHeading('Missing Characler Slogan'),
          content: const StyledText('Every good RPG character needs a slogan'),
          actions: [
            StyledButton(
              onPressed: (){
                Navigator.pop(ctx);
              }, 
              child: const StyledHeading('close')
            )
          ],
        );
      });
      return;
    }
    Provider.of<CharacterStore>(context, listen: false)
      .addCharacter(Character(
        vocation: selectedVocation, 
        name: _nameController.text.trim(), 
        slogan: _sloganController.text.trim(), 
        id: uuid.v4()
      )); 

    Navigator.pop(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Character Creation'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor,),
              ),
              const Center(
                child: StyledHeading('Welcome, new player'),
              ),
              const Center(
                child: StyledText('add a neme, slogan for your character'),
              ),
              const SizedBox(height: 30),
          
               TextField(
                controller: _nameController,
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium
                ),
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  label: StyledText('Character name')
                ),
              ),
              const SizedBox(height: 20),
               TextField(
                controller: _sloganController,
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium
                ),
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.chat),
                  label: StyledText('Character Slogan')
                ),
              ),

              const SizedBox(height: 30,),
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor,),
              ),
              const Center(
                child: StyledHeading('Choose a vocation'),
              ),
              const Center(
                child: StyledText('This determine your available skills'),
              ),
              
              const SizedBox(height: 30,),
              VocationCard(
                selected: selectedVocation==Vocation.junkie, 
                onTap: updateVocation, 
                vocation: Vocation.junkie
              ),
              VocationCard(
                selected: selectedVocation==Vocation.ninja, 
                onTap: updateVocation, 
                vocation: Vocation.ninja
              ),
              VocationCard(
                selected: selectedVocation==Vocation.raider, 
                onTap: updateVocation, 
                vocation: Vocation.raider
              ),
              VocationCard(
                selected: selectedVocation==Vocation.wizard, 
                onTap: updateVocation, 
                vocation: Vocation.wizard
              ),
              const SizedBox(height: 30,),
              Center(
                child: StyledButton(
                  onPressed: handleSubmit, 
                  child: const StyledHeading('Create Character')
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}