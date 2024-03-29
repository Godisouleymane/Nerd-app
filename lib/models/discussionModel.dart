class Discussion {
  String id;
  String sujet;
  String createurID; // identifiant de l'utilisateur qui a lancer la discussion
  String photoUrl;
  DateTime heureCreation;

  Discussion(
      {required this.id,
      required this.heureCreation,
      required this.photoUrl,
      required this.sujet,
      required this.createurID});
}
