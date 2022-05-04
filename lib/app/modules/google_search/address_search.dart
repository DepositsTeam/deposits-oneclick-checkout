

import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider? apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
           Navigator.pop(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon:const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null!;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //print("local languageCode is "+Localizations.localeOf(context).languageCode);
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient!.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context,AsyncSnapshot<List<Suggestion>?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
           return Container(
              padding: const EdgeInsets.all(16.0),
              child:const Text('Enter your address'),
            );
          case ConnectionState.active:
          case ConnectionState.waiting:
          return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                       AlwaysStoppedAnimation<Color>(AppColors.black),
                ),
              );
          case ConnectionState.done:
          if (snapshot.hasError) {
            return CustomText(
                text: snapshot.error.toString(),
                font: 20,
                txtColor: AppColors.black,
              );
          }else{
          return  query == '' ? Container(
              padding: const EdgeInsets.all(16.0),
              child:const Text('Enter your address'),
            ) : ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: 
                        Text((snapshot.data![index]).description),
                    onTap: () {
                      close(context, snapshot.data![index]);
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
          }
        }
      }
    );
  }
}

