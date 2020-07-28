import 'package:credicxo_task/models/trackDetails.dart';
import 'package:credicxo_task/networking/repository.dart';
import 'package:rxdart/rxdart.dart';

//Bloc class for Track's Details.
class TrackDetailsBloc {
  final _repository =
      TrackDetailsRepository(); //This repository is a layer between networking and Track Details BLoC.
  final _detailsFetcher = PublishSubject<TrackDetails>();

  Stream<TrackDetails> get trackDetails => _detailsFetcher.stream;

  //This method fetch Track Details from REST API.
  fetchTrackDetails(String _trackId) async {
    TrackDetails trackDetails = await _repository.fetchTrackDetails(_trackId);
    _detailsFetcher.sink.add(trackDetails);
  }

  //This method is used to dispose BLoCStream.
  void dispose() {
    _detailsFetcher.close();
  }
} // BLoC class ends.

//Global object is defined for Track Detail BLoC;
final TrackDetailsBloc trackDetailsBloc = TrackDetailsBloc();
