package Service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import DAO.CourseDAO;
import VO.CourseVO;
import VO.LectureVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CourseService {
	
	private CourseDAO courseDAO;
	
	public CourseService() {
		courseDAO = new CourseDAO();
		
	} 
	
	
	// request에서 쿼라파라미터 추출 후 DAO에 DB작업 요청
	public List<CourseVO> getCourseList(HttpServletRequest request) {
		List<CourseVO> list = new ArrayList<>();
		// category가 1-백엔드 , 2- 프론트엔드, 3-AI 
		String category = request.getParameter("category");
		list = courseDAO.getCourseList(category);
		return list;
	}

	//상세페이지 뿌려주기 위해 강의데이터 조회 요청
	public CourseVO getDetail(HttpServletRequest request) {
		
		return courseDAO.getDetail(Integer.parseInt(request.getParameter("courseId")));
	}

// 로그인한 id를 매개변수로 받아서 구매한 강의 정보 받아오는 메소드
	public List<CourseVO> getCoursePurchased(String id) {
		List<CourseVO> list = new ArrayList<>();
		System.out.println(id);
		list = courseDAO.getCoursePurchased(id);
		return list;
	}


	public LectureVO getLectureInfo(String courseId) {
		
		return null;
	}
	
	public CourseVO registration(HttpServletRequest request, HttpSession session) {
		String userId = (String)session.getAttribute("id");
		int coursePrice =  Integer.parseInt(request.getParameter("price"));
		String courseCategory = request.getParameter("category");
		String courseTitle = request.getParameter("title");
		String courseDescription = request.getParameter("description");
		String imgPath = request.getParameter("img");
		
		return courseDAO.registration(userId,coursePrice,courseCategory,courseTitle,courseDescription,imgPath);
	}


	public String getInstructorNameById(String id) {
		return courseDAO.getInstructorNameById(id);
	}


	public CourseVO selectTitleAndCategory(int courseId) {
		CourseVO vo = new CourseVO();
		vo = courseDAO.getTitleAndCategory(courseId);
		return vo;
	}
	public List<CourseVO> modifyCourseList(HttpServletRequest request, HttpSession session) {
		String UserId = (String)session.getAttribute("id");
		
		List<CourseVO> list = courseDAO.modifyCourseList(UserId);
		return list;
	}


	public CourseVO modifyCourse(HttpServletRequest request, HttpSession session) {
		String UserId = (String)session.getAttribute("id");
		int courseId = Integer.parseInt(request.getParameter("courseId")) ;
//		System.out.println("CourseService에서 호출한 courseId : " + courseId);
		CourseVO courseVO = courseDAO.modifyCourse(UserId, courseId);
		return courseVO;
	}


	public int reqModCourse(HttpServletRequest request) {
		int courseId = Integer.parseInt(request.getParameter("courseId"));
		String courseTitle = request.getParameter("courseTitle");
		String courseDescription = request.getParameter("courseDescription");
		String imgPath = request.getParameter("imgPath");
		int coursePrice = Integer.parseInt(request.getParameter("coursePrice"));
		
		int update = courseDAO.reqModCourse(courseId, courseTitle, courseDescription, imgPath, coursePrice);
		return update;
	}


	public int delCourse(HttpServletRequest request) {
		
		
		int courseId = Integer.parseInt(request.getParameter("courseId"));
//		String courseTitle = request.getParameter("courseTitle");
//		int coursePrice = Integer.parseInt(request.getParameter("coursePrice"));

		
		int update = courseDAO.delCourse(courseId);
		
		return update;
	}


	public List<CourseVO> getEnrollCoursesListById(String id) {
		return courseDAO.getEnrollCoursesListById(id);
	}
	
	//강의 등록을 할때 강의제목열의 값이 DB에 중복되어있을경우 유효성검사
			public boolean coursesTitleCheck(HttpServletRequest request) {
				//입력한 제목 얻기
				String courseTitle = request.getParameter("title");
				
				//true -> 중복,  false-> 중복아님    둘중 하나를 반환받음 
				return courseDAO.coursesTitleCheck(courseTitle);
				
			}


			public List<CourseVO> getCourseListInRoadMap(String id) {
				return courseDAO.getCourseListInRoadMap(id);
			}


			public List<CourseVO> getCourseListToPurchase(int roadMapId,String user_id) {
				
				return courseDAO.getCourseListToPurchase(roadMapId,user_id);
			}
	


	
}
