class DonationDto {
  final String ngoGuid;
  final String userId;
  final List<String> foodStockGuids;
  
  DonationDto({
    required this.ngoGuid,
    required this.userId,
    required this.foodStockGuids,
  });


  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      'ngoGuid': ngoGuid,
      'userId': userId,
      'foodStockGuids': foodStockGuids
    };
  }
}
