class TicketModel {
  final String ticketId;
  final String userId;
  final String category;
  final String title;
  final String description;
  final String status;
  final int createdAt;
  final String? transactionRef;
  final String? evidencePath;

  TicketModel({
    required this.ticketId,
    required this.userId,
    required this.category,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    this.transactionRef,
    this.evidencePath,
  });

  Map<String, dynamic> toMap() =>
      {
        'ticket_id': ticketId,
        'user_id': userId,
        'category': category,
        'title': title,
        'description': description,
        'status': status,
        'created_at': createdAt,
    'tx_ref': transactionRef,
    'evidence_path': evidencePath,
  };

  factory TicketModel.fromMap(Map<String, dynamic> map) =>
      TicketModel(
        ticketId: map['ticket_id'] as String,
        userId: map['user_id'] as String,
        category: map['category'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        status: map['status'] as String,
        createdAt: map['created_at'] as int,
    transactionRef: map['tx_ref'] as String?,
    evidencePath: map['evidence_path'] as String?,
  );
}
