package geocni.travel.common.banfilter.domain;

import java.util.ArrayList;
import java.util.List;

import geocni.travel.common.TravelDefaultVO;

public class TravelBanFilters extends TravelDefaultVO {

    private static final long serialVersionUID = 1L;

    /*금칙어 단어*/
    private String banWord;

    /*단어 생성일시*/
    private String createdAt;
    
    private List<String> banWordList;
    
    private List<TravelBanFilters> filterList;
    
	public String getBanWord() {
		return banWord;
	}

	public void setBanWord(String banWord) {
		this.banWord = banWord;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public List<String> getBanWordList() {
		return banWordList;
	}

	public void setBanWordList(String wordList) {
		String[] wordArr = wordList.split(",");
		
		List<String> list = new ArrayList<String>();
		for(int i=0;wordArr.length > i ;i++){
			list.add(wordArr[i].trim().toLowerCase());
		}
		
		this.banWordList = list;
	}

	public List<TravelBanFilters> getFilterList() {
		return filterList;
	}
	
	public void setFilterList(List<TravelBanFilters> filterList) {
		this.filterList = filterList;
	}
	
}
