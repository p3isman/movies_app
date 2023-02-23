import 'package:flutter/material.dart';
import 'package:movies/src/models/cast_model.dart';

class ActorsList extends StatelessWidget {
  final List<Actor>? cast;

  ActorsList({required this.cast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: PageView.builder(
        itemCount: cast!.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemBuilder: (context, i) {
          return _ActorCard(actor: cast![i]);
        },
      ),
    );
  }
}

class _ActorCard extends StatelessWidget {
  const _ActorCard({
    Key? key,
    required this.actor,
  }) : super(key: key);

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              height: 150.0,
              width: 100.0,
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getImageUrl()),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5.0),
          Text(actor.name!),
        ],
      ),
    );
  }
}
