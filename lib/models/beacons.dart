class Beacons {
  final String uid;
  final String beaconId;
  final String major;
  final String minor;
  final String beaconName;

  Beacons({this.uid, this.beaconId, this.major, this.minor, this.beaconName});
  String toString() {
    return '{ ${this.uid},${this.beaconId},${this.major}, ${this.minor}, ${this.beaconName} }';
  }
}
