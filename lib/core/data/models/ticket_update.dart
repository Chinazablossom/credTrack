class TicketUpdateModel {
  final String updateId;
  final String ticketId;
  final String message;
  final String sender;
  final int timestamp;

  TicketUpdateModel({
    required this.updateId,
    required this.ticketId,
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() =>
      {
        'update_id': updateId,
        'ticket_id': ticketId,
        'message': message,
        'sender': sender,
        'timestamp': timestamp,
      };

  factory TicketUpdateModel.fromMap(Map<String, dynamic> map) =>
      TicketUpdateModel(
        updateId: map['update_id'] as String,
        ticketId: map['ticket_id'] as String,
        message: map['message'] as String,
        sender: map['sender'] as String,
        timestamp: map['timestamp'] as int,
      );
}
