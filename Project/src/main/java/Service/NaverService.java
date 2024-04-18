package Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import DAO.NaverDAO;
import VO.NaverLoginVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class NaverService {
	
	private NaverDAO naverDAO;
	
	public NaverService() {
		naverDAO = new NaverDAO();
	}


	  public static String get(String apiUrl, Map<String, String> requestHeaders){
	        HttpURLConnection con = connect(apiUrl);
	        try {
	            con.setRequestMethod("GET");
	            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	                con.setRequestProperty(header.getKey(), header.getValue());
	                con.setRequestProperty("Content-Type", "text/json;charset=utf-8");
	            }


	            int responseCode = con.getResponseCode();
	            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	                return readBody(con.getInputStream());
	            } else { // 에러 발생
	                return readBody(con.getErrorStream());
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("API 요청과 응답 실패", e);
	        } finally {
	            con.disconnect();
	        }
	    }
	  
	  
	  public static HttpURLConnection connect(String apiUrl){
	        try {
	            URL url = new URL(apiUrl);
	            return (HttpURLConnection)url.openConnection();
	        } catch (MalformedURLException e) {
	            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	        } catch (IOException e) {
	            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	        }
	    }
	  

	    public static String readBody(InputStream body){
	        InputStreamReader streamReader = new InputStreamReader(body);


	        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	            StringBuilder responseBody = new StringBuilder();


	            String line;
	            while ((line = lineReader.readLine()) != null) {
	                responseBody.append(line);
	            }


	            return responseBody.toString();
	        } catch (IOException e) {
	            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
	        }
	    }
	
	
	
	public void NaverLogin(String m_id, HttpServletRequest request) {
		
		log.debug("로그인할 아이디 : {}", m_id);
		HttpSession session = request.getSession();
		session.setAttribute("id", m_id);
		
	}	
	
	// id 값이 테이블에 존재하는지 여부 확인
	public NaverLoginVO serviceCheckId(String id, HttpServletRequest request) {
			
		NaverLoginVO naverUserVo1 = naverDAO.checkId(id);

	
		return naverUserVo1;
	
	
}
	}
