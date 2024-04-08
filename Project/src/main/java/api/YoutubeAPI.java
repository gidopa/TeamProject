package api;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;

public class YoutubeAPI {
	
	private final String path;
	private static final String apiKey = "AIzaSyAZrJrDJxa6mewUMUPpClpDJ_46pZ6T_1U";
	
	public YoutubeAPI(String path) {
		this.path = path;
	}
	
	public String getData(String path) {
		String videoPath = path;
		return null;
	}
	
	public String parseJson(String Json) {
		
		return null;
	}
	
	public String getDuration(String duration) {
		
		return null;
	}
}
