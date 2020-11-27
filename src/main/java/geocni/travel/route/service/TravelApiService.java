package geocni.travel.route.service;

import java.util.List;

public interface TravelApiService {

	List<?>selectTravelDestinationApi() throws Exception;

	List<?>selectTravelrouteApi() throws Exception;

	List<?>selectTravelroutedailyApi() throws Exception;
	
	List<?>selectTravelcontentApi() throws Exception;

	List<?>selectTravelareacodeApi() throws Exception;
	
	List<?>selectTravelbanfiltersApi() throws Exception;
	
	List<?>selectTravelclipboardApi() throws Exception;
	
	List<?>selectTravelfamehistoryApi() throws Exception;
	
	List<?>selectTravelfamepointApi() throws Exception;

	List<?>selectTravelimgfilesApi() throws Exception;
	
	List<?>selectTravelreactionApi() throws Exception;
}
