import 'package:flutter/material.dart';
import 'package:user_cards/common/constants/paddings.dart';
import 'package:user_cards/domain/models/hobby.dart';
import 'package:user_cards/ui/widgets/user/hobby_view.dart';

class HobbiesView extends StatelessWidget {
  final List<Hobby> hobbies;

  const HobbiesView({
    Key? key,
    required this.hobbies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(Paddings.tiny.value),
      child: Row(
        children: [
          for (final hobby in hobbies) _cell(hobby),
        ],
      ),
    );
  }

  Widget _cell(Hobby hobby) => Padding(
        padding: EdgeInsets.all(Paddings.tiny.value),
        child: HobbyView(hobby: hobby),
      );
}
