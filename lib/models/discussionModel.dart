class Discussion {
  String id;
  String sujet;
  String createurID; // identifiant de l'utilisateur qui a lancer la discussion
  DateTime heureCreation;

  Discussion(
      {required this.id,
      required this.heureCreation,
      required this.sujet,
      required this.createurID});
}
