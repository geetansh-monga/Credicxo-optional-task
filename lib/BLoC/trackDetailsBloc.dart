import 'package:credicxo_task/models/trackDetails.dart';
import 'package:credicxo_task/networking/repository.dart';
import 'package:rxdart/rxdart.dart';

class TrackDetailsBloc {
  final _repository = TrackDetailsRepository();
  final _detailsFetcher = PublishSubject<TrackDetails>();

  Stream<TrackDetails> get trackDetails => _detailsFetcher.stream;

  fetchTrackDetails(String _trackId) async {
    TrackDetails trackDetails = await _repository.fetchTrackDetails(_trackId);
    _detailsFetcher.sink.add(trackDetails);
  }

  void dispose() {
    _detailsFetcher.close();
  }
}

final TrackDetailsBloc trackDetailsBloc = TrackDetailsBloc();
