import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/custom_image_network.dart';
import '../models/pokemon_detail.dart';
import '../utils.dart'; // berisi fetchPokemonById()

class PokemonScreen extends StatelessWidget {
  final String localId; // contoh: "1" atau "002"

  const PokemonScreen({super.key, required this.localId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonDetail>(
      future: fetchPokemonById(localId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('No data found')),
          );
        }

        final pokemon = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text(pokemon.name),
          ),
          body: Animate(
            effects: const [FadeEffect()],
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar utama
                  Center(
                    child: CustomImageNetwork(imageUrl: pokemon.imageHigh),
                  ),
                  const SizedBox(height: 24),

                  // Nama
                  Text(
                    pokemon.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Rarity dan HP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rarity: ${pokemon.rarity}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'HP: ${pokemon.hp}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.redAccent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Stage
                  Text(
                    'Stage: ${pokemon.stage}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),

                  // Deskripsi
                  Text(
                    pokemon.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          color: Colors.grey[700],
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
