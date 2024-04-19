package Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import DAO.KakaoLoginDAO;
import VO.KakaoLoginVO;

public class KakaoLoginService {
	private KakaoLoginDAO kakaoLoginDAO;

	public KakaoLoginService() {
		kakaoLoginDAO = new KakaoLoginDAO();
	}

	public int serviceCheckId(KakaoLoginVO kakaoLoginVO, HttpServletRequest request) {
		int resultInt = kakaoLoginDAO.checkId(kakaoLoginVO.getUserId());
		String resultStr = String.valueOf(resultInt);
		
		if(resultInt != 0) {
			HttpSession session = request.getSession();
			session.setAttribute("m_id", String.valueOf(kakaoLoginVO.getUserId()));
			session.setAttribute("m_admin", resultStr);
		}
		
		return resultInt;
	}

	public KakaoLoginVO serviceLogin(KakaoLoginVO kakaoLoginVO, HttpServletRequest request) {
		KakaoLoginVO result = kakaoLoginDAO.kakaoLogin(kakaoLoginVO);

		HttpSession session = request.getSession();
		session.setAttribute("id", String.valueOf(result.getUserId()));
		session.setAttribute("m_admin", "1");

		return result;
	}

}
