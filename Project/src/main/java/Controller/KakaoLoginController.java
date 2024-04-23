package Controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import Service.KakaoLoginService;
import VO.KakaoLoginVO;
import VO.TokenVO;

@WebServlet("/kakao/kakaoLogin")
public class KakaoLoginController extends HttpServlet {

	private KakaoLoginService kakaoLoginService;
	private KakaoLoginVO kakaoLoginVO;

	public void init(ServletConfig config) throws ServletException {
		kakaoLoginService = new KakaoLoginService();
		kakaoLoginVO = new KakaoLoginVO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = request.getParameter("code");
		System.out.println("OAuth Code : " + code);

		String contextPath = request.getContextPath();
		String nextPage = null;
		
		String action = request.getPathInfo();
		try {
			/* 얻어온 code로 토큰 발급 POST 요청 */
			URL url = new URL("https://kauth.kakao.com/oauth/token");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true); // 서버한테 전달할게 있는지 없는지

			String parameter = "grant_type=authorization_code" + "&client_id=7b619653ec29fa76d72250cd1d4fe5e1"
					+ "&redirect_uri=http://localhost:8083/Project/kakao/kakaoLogin" + "&code=" + code;

			BufferedWriter bw = null;
			try {
				bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				bw.write(parameter.toString());
			} catch (IOException e) {
				throw e;
			} finally {
				if (bw != null)
					bw.flush();
			}

			int resultInt = conn.getResponseCode();
			System.out.println("전송 결과 = " + resultInt);

			BufferedReader br = null;
			String line = "", result = "";
			try {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				while ((line = br.readLine()) != null) {
					result += line;
				}
			} catch (IOException e) {
				throw e;
			} finally {
				if (br != null)
					br.close();
			}

			// JSON 결과
			System.out.println("result : " + result);

			// JSON 데이터 객체로 변환 후 access 토큰 get
			Gson gson = new Gson();
			TokenVO tokenDTO = gson.fromJson(result, TokenVO.class);
			String access_token = tokenDTO.getAccess_token();

			// access_token 으로 다시 요청
			url = new URL("https://kapi.kakao.com/v2/user/me");
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setRequestProperty("Authorization", "Bearer " + access_token);
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			System.out.println(conn.getURL());

			line = "";
			result = "";
			try {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				while ((line = br.readLine()) != null) {
					result += line;
				}
			} catch (IOException e) {
				throw e;
			} finally {
				if (br != null)
					br.close();
			}
			System.out.println("result user : " + result);

			// Json 데이터 Vo 저장 후 반환
			
			try {
				JSONParser parser = new JSONParser();
				JSONObject jsonObject = (JSONObject)parser.parse(result);
				JSONObject jsonObject2 = (JSONObject)jsonObject.get("kakao_account");
				kakaoLoginVO.setUserId(Long.parseLong(jsonObject.get("id").toString()));
				kakaoLoginVO.setEmail(jsonObject2.get("email").toString());
				kakaoLoginVO.setName(jsonObject2.get("name").toString());
				kakaoLoginVO.setPhoneNumber(jsonObject2.get("phone_number").toString());
			
			
			
				// id 값이 테이블에 존재하는지 여부 확인
				int resultInt1 = kakaoLoginService.serviceCheckId(kakaoLoginVO, request);
				String id = "";
				System.out.println("resultInt1값 : " + resultInt1);
				if(resultInt1 == 0) {
					KakaoLoginVO KakaoLoginVO1 = kakaoLoginService.serviceLogin(kakaoLoginVO, request);
					request.setAttribute("center", "kakaoJoin.jsp");
					request.setAttribute("KakaoLoginVO", KakaoLoginVO1);
					
					
					
				} else {
					id = jsonObject.get("id").toString();
					HttpSession session = request.getSession();
					session.setAttribute("id", id);
					
					
				}
				nextPage = "/project1/main.jsp";
			
			} catch (Exception e) {
				System.out.println("JSON 파싱 에러 : " + e);
				e.printStackTrace();
			} 
			
			
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);		
		dispatch.forward(request, response);
	}

}
