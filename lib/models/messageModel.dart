class Message {
  String id;
  String
      discussionId; // Identifiant de la discussion a laquelle ce message appartient
  String contenu;
  String auteurId; // identifiant de l'utilisateur qui a envoyer ce message
  DateTime heureEnvoi;

  Message(
      {required this.id,
      required this.discussionId,
      required this.contenu,
      required this.auteurId,
      required this.heureEnvoi});
}

