package api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.Duration;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

// 영상 주소로부터 YoutubeAPI 관련 로직 구현
public class YoutubeAPI {
	
	private final String path;
	private static final String apiKey = "Youtube DATA API v3 키 넣기";
	
	public YoutubeAPI(String path) {
		this.path = path;
	}
	// 영상 주소로부터 ID만 추출
	public String getVideoId() {
		String videoPath = path;
		videoPath = videoPath.replace("https://www.youtube.com/watch?v=","");
		return videoPath;
	}
	// ID로부터 필요한 json 데이터 받아옴
	public String getData(String videoId) {
		StringBuffer response = null;
		 try {
	             // YouTube 영상 ID
	            String url = "https://www.googleapis.com/youtube/v3/videos?id=" + videoId + "&part=contentDetails&key=" + apiKey;

	            URL obj = new URL(url);
	            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	            con.setRequestMethod("GET");

	            int responseCode = con.getResponseCode();
	            System.out.println("Response Code : " + responseCode);

	            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            String inputLine;
	            
	            response = new StringBuffer();

	            while ((inputLine = in.readLine()) != null) {
	                response.append(inputLine);
	            }
	            in.close();

	            // 여기에서 JSON 응답을 파싱하여 지속 시간을 추출하고 처리합니다.
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		return response.toString();
	}
	// json 데이터 받아서 Duration 부분 파싱
	public String getDuration(String Json) {
		String jsonStr = Json;
		JSONParser parser = new JSONParser();
		String duration = null;
        try {
            JSONObject rootObject = (JSONObject) parser.parse(jsonStr); // 전체 JSON 객체를 파싱합니다.
            JSONArray items = (JSONArray) rootObject.get("items"); // "items" 배열을 가져옵니다.
            if (items != null && !items.isEmpty()) {
                JSONObject firstItem = (JSONObject) items.get(0); // "items" 배열의 첫 번째 객체를 가져옵니다.
                JSONObject contentDetails = (JSONObject) firstItem.get("contentDetails"); // "contentDetails" 객체를 가져옵니다.
                duration = (String) contentDetails.get("duration"); // "duration" 값을 가져옵니다.
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
		return duration;
	}
	//  ISO 8601 형식으로 표현되어 있는 Duration을 mm:ss 형식으로 포맷팅
	public String formatDuration(String duration) {
		    String isoDuration = duration; // YouTube API에서 가져온 지속 시간
	        Duration durationed = Duration.parse(isoDuration);
	        
	        long minutes = durationed.toMinutes();
	        long seconds = durationed.getSeconds() % 60;
	        
	        String formattedDuration = String.format("%02d:%02d", minutes, seconds);
		return formattedDuration;
	}
}
