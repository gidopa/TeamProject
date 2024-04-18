package Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import Service.NaverService;
import VO.NaverLoginVO;
import VO.PayVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/Naver/*")
public class NaverLoginController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String main = "/project1/main.jsp";
		String code = request.getParameter("code");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/json;charset=utf-8");
		NaverService naverService = new NaverService();
		String nextPage = null;
		String apiURL;
	    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
	    apiURL += "client_id=" + "RXYk8HbDBVuINgLo77fM";
	    apiURL += "&client_secret=" + "wpeuPli7vJ";
	    apiURL += "&redirect_uri=" + "http://localhost:8083/Project/project1/naverJoin.jsp";
	    apiURL += "&code=" + code;
	    try {
	        URL url = new URL(apiURL);
	        HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setRequestMethod("GET");
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        log.debug("responseCode = {}", responseCode);
	        if(responseCode==200) { // 정상 호출
	          br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        } else {  // 에러 발생
	          br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	        }
	        String inputLine;
	        StringBuffer res = new StringBuffer();
	        while ((inputLine = br.readLine()) != null) {
	          res.append(inputLine);
	        }
	        br.close();
	        if(responseCode==200) {
	        	log.debug("access token data : {}" , res.toString());
	        }
	        
	        Gson gson = new Gson();
	        
	        //액세스 토큰정보가 포함된 문자열을 json데이터로 변환
	        JsonObject jo = gson.fromJson(res.toString(), JsonObject.class);
	        
	        //액세스 토큰을 얻어옴
	        String accessToken = jo.get("access_token").getAsString();
	        
	        String token = accessToken; // 네이버 로그인 접근 토큰;
		    String header = "Bearer " + token; // Bearer 다음에 공백 추가
		
		
		    apiURL = "https://openapi.naver.com/v1/nid/me";
		
		
		    Map<String, String> requestHeaders = new HashMap<>();
		    requestHeaders.put("Authorization", header);
		    requestHeaders.put("Accept-Charset", "UTF-8");
		    //이름 값을 한글로 받아오기 위해서 설정해주어야 함
		    
		    //회원 프로필 정보(id, gender 등)가 저장되어 있는 json데이터 형식의 문자열
		    String responseBody = naverService.get(apiURL,requestHeaders);
		    
		
		    request.setAttribute("JSONDATA", responseBody);
		
		    log.debug("API 반환 데이터 : {}",responseBody);
		    //VO에 Json데이터 저장(삭제해야 하는데 일단 참고용으로 남겨둠)
		    //NaverUserVo naverUserVo = gson.fromJson(responseBody, NaverUserVo.class);
	        
		  
	        
	        
	        JsonObject jsonObject = gson.fromJson(responseBody, JsonObject.class);
	        
	        //JSON데이터의 "response" 객체 내부의 데이터 추출
	        JsonObject responseData = jsonObject.getAsJsonObject("response");
	        //필요한 데이터 추출
	        String id = responseData.get("id").getAsString();
	        String email = responseData.get("email").getAsString();
	        String mobile = responseData.get("mobile").getAsString().replace("-", "");
	        String name = responseData.get("name").getAsString();
	        
	        NaverLoginVO naverUserVo = new NaverLoginVO(id,  email, name, mobile);
	        // 추출한 데이터 출력
	        log.debug("ID : {}" , id );
	        log.debug("Email : {}" , email );
	        log.debug("Mobile : {}" , mobile );
	        log.debug("Name : {}" , name );
	    

//			 id 값이 테이블에 존재하는지 여부 확인(존재시 1, 비존재시 0)
	        NaverLoginVO searchNvo = naverService.serviceCheckId(naverUserVo.getId(), request);
			
			String m_id = searchNvo.getId();
			
			log.debug("로그인 요청한 아이디 : {}",m_id);
			
				//id가 테이블에 없는 경우(회원가입 되지 않은 경우 naverJoin페이지로 이동한다.
			if(m_id == null) {
				
				request.setAttribute("center", "naverJoin.jsp");
				request.setAttribute("NaverUserVo", naverUserVo);		
				
				//id가 조회되는 경우 그냥 로그인 시킨다.			
			}else if(m_id != null){
				
				
				naverService.NaverLogin(m_id,  request);
			}
		
			nextPage = main;
		    
	      } catch (Exception e) {
	        log.error("naver Login Error : {}",e );
	      }
	    
	    RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);		
		dispatch.forward(request, response);
	    
		}
		
	}

