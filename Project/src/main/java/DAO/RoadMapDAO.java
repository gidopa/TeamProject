package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import VO.CourseVO;
import VO.LectureVO;
import VO.RoadMapVO;
import VO.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RoadMapDAO {

	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource dataSource;
	private CourseVO courseVO = null;
	private LectureVO lectureVO = null;

	public RoadMapDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void resourceRelease() {

		try {
			if (rs != null) {
				rs.close();
			}
			if (con != null) {
				con.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 전체 로드맵 조회를 위해 List로 받아오는 메소드
	public List<RoadMapVO> getRoadMapList() {
		List<RoadMapVO> list = new ArrayList<RoadMapVO>();
		try {
		con = dataSource.getConnection(); 
		String sql = "select * from roadmap";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			RoadMapVO roadMapVO = new RoadMapVO();
			roadMapVO.setRoadMapId(rs.getInt("roadmap_id"));
			roadMapVO.setRoadMapTitle(rs.getString("roadmap_title"));
			roadMapVO.setRoadMapDescription(rs.getString("roadmap_description"));
			roadMapVO.setImgPath(rs.getString("roadmap_img"));
			roadMapVO.setUserId(rs.getString("user_id"));
			list.add(roadMapVO);
		}
		}catch (Exception e) {
			log.debug("getRoadMapList error : {}", e);
		}finally {
			resourceRelease();
		}
		return list;
	}

	// roadMapId로 로드맵 하나의 대한 정보를 vo로 받아오는 메소드
	public Map<String, Object> getRoadMapDetail(int roadMapId) {
		Map<String, Object> map  = new HashMap<String, Object>();
		RoadMapVO roadMapVO = null;
		CourseVO courseVO = null;
		List<CourseVO> list = new ArrayList<>();
		try {
			con = dataSource.getConnection(); 
			// roadmap_id가 1인 행에 대해 join 해서 select , roadmap 테이블과 courses 테이블의 값을 모두 불러옴 
			String sql = "select * from roadmap inner join courses on roadmap.roadmap_id = courses.roadmap_id where roadmap.roadmap_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, roadMapId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				// map을 반환하는데 key 값으로는 String value로는 roadMapVO와 courseVO를 담은 list를 바인딩 
				roadMapVO = new RoadMapVO();
				courseVO = new CourseVO();
				roadMapVO.setRoadMapTitle(rs.getString("roadmap_title"));
				roadMapVO.setRoadMapDescription(rs.getString("roadmap_description")); // roadMapVO 값 세팅
				roadMapVO.setRoadMapId(roadMapId);
				courseVO.setCourseId(rs.getInt("course_id"));
				courseVO.setCourseDescription(rs.getString("course_description"));
				courseVO.setCourseTitle(rs.getString("course_title"));
				courseVO.setCoursePrice(rs.getInt("course_price"));
				courseVO.setImgPath(rs.getString("img_path")); // courseVO 값 세팅
				list.add(courseVO); // courseVO는 list에 담아 map에 바인딩
				map.put("roadMapVO", roadMapVO); // roadMapVO는 두번 바인딩 되지만 같은 키 값으로 put 되므로 덮어쓰기 된다.
			}
			map.put("courseVO", list);
		}catch (Exception e) {
			log.debug("getRoadMapDetail error : {}",e);
		}finally {
			resourceRelease();
		}
		
		
		return map;
	}
	
	//로드맵을 DB에 등록 하면서roadMapId가져오는 작업  
		public int registerRoadMap(String userId, String roadMapTitle, String roadMapDescription, String imgPath) {
			int roadMapId=0;
		
			try {
				con = dataSource.getConnection(); 
				String sql = "insert into ROADMAP(roadMap_Id,roadMap_Title,roadMap_Description,RoadMap_IMG,user_Id) "
							+ "values(RoadMap_roadmap_id.nextVal,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,roadMapTitle);
				pstmt.setString(2,roadMapDescription);
				pstmt.setString(3,imgPath);
				pstmt.setString(4,userId);
				pstmt.executeUpdate();
				
				sql = "select roadMap_id from RoadMap where roadMap_title = ? and user_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,roadMapTitle);
				pstmt.setString(2,userId);
				rs = pstmt.executeQuery();
					if(rs.next()) {
						roadMapId = rs.getInt("roadMap_Id");
					}
			}catch (Exception e) {
				log.debug("RoadMapDAO registerRoadMap error : {}", e);
			}finally {
				resourceRelease();
			}
			return roadMapId;
		}
		//RoadMap등록시 userId를 받아서 내가 등록한 강의들의 리스트를 받아오는 메소드
		public List<CourseVO> registerRoadMapList(String userId) {
				List list = new ArrayList<>();
				try {
					con = dataSource.getConnection(); 
					String sql = "select * from Courses where (user_id=? and roadmap_id IS NULL)";//
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, userId);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						courseVO = new CourseVO();
						courseVO.setCourseId(rs.getInt("course_id"));
						courseVO.setCourseTitle(rs.getString("course_title"));
						courseVO.setCourseDescription(rs.getString("course_description"));
						courseVO.setUserId(rs.getString("user_id"));
						courseVO.setCoursePrice(rs.getInt("course_price"));
						list.add(courseVO);
					}
				}catch (Exception e) {
					log.debug("RoadMapDAO registerRoadMapList error : {}", e);
				}finally {
					resourceRelease();
				}
				return list;
		}
		//체크박스에 체크된 강의만 모아서 로드맵에 등록하는 메소드
		public void postRoadMap(HttpServletRequest request) {
			try {
			int roadMapId = Integer.parseInt(request.getParameter("roadMapId"));
			int couserId = 0;
			List<Integer> selectedCourseIds = new ArrayList<>();
			String[] courseIds = request.getParameterValues("course_id");
			if(courseIds != null) {
				con = dataSource.getConnection(); 
				    for(String courseId : courseIds) {
				         couserId = Integer.parseInt(courseId);
				 			String sql = "update courses set roadmap_id = ? where course_id=?";
				 			pstmt = con.prepareStatement(sql);
				 			pstmt.setInt(1, roadMapId);
				 			pstmt.setInt(2, couserId);
				 			pstmt.executeUpdate();
				    }
			}
			}catch (Exception e) {
	 			log.debug("RoadMapDAO postRoadMap error : {}", e);
	 		}finally {
	 			resourceRelease();
			}	
		}
		//로드맵 수정/삭제 버튼을 눌렀을때 내 로드맵을 가져와서 보여주는 메소드
		public List<RoadMapVO> MyRoadMapList(String id) {
			List list = new ArrayList<>();
			try {
				con = dataSource.getConnection(); 
				String sql = "select * from roadMap where user_id=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					RoadMapVO roadMapVO = new RoadMapVO();
					roadMapVO.setRoadMapId(rs.getInt("roadmap_id"));
					roadMapVO.setRoadMapTitle(rs.getString("roadMap_title"));
					roadMapVO.setUserId(rs.getString("user_id"));
					
					list.add(roadMapVO);
				}
			}catch (Exception e) {
				log.debug("RoadMapDAO MyRoadMapList error : {}", e);
			}finally {
				resourceRelease();
			}
			return list;
		}
		//로드맵 리스트 화면에서 수정 버튼을 눌렀을때 내가 등록한 강의들을 가져와서 보여주는 메소드 
		//  +내가 등록한 강의중 수정을 누른 로드맵 강의와 courses테이블의 roadmap_id가 null인값만 보여주기 
		public ArrayList<CourseVO> updateRoadMap(String userId, int roadMapId) {
			List list = new ArrayList<>();
			try {	
				con = dataSource.getConnection(); 
				String sql = "SELECT * FROM Courses WHERE (user_id = ? AND roadmap_id = ?) "
								+ "OR (user_id = ? AND roadmap_id IS NULL)";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, userId);
				pstmt.setInt(2, roadMapId);
				pstmt.setString(3, userId);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					courseVO = new CourseVO();
					courseVO.setCourseId(rs.getInt("course_id"));
					courseVO.setCourseTitle(rs.getString("course_title"));
					courseVO.setCourseDescription(rs.getString("course_description"));
					courseVO.setUserId(rs.getString("user_id"));
					courseVO.setCoursePrice(rs.getInt("course_price"));
					courseVO.setRoadMapId(rs.getInt("roadMap_Id"));
					list.add(courseVO);
				}
			}catch (Exception e) {
				log.debug("RoadMapDAO registerRoadMapList error : {}", e);
			}finally {
				resourceRelease();
			}
			return (ArrayList<CourseVO>) list;
		}
		//로드맵의 내 강의리스트에서 체크한 강의들만 다시 DB에 저장하는 메소드(수정)
		public void updateRoadMapInsert(HttpServletRequest request) {
			try {
				int roadMapId = Integer.parseInt(request.getParameter("roadMapId"));
				int couserId = 0;
				List<Integer> selectedCourseIds = new ArrayList<>();
				String[] courseIds = request.getParameterValues("course_id");
				if(courseIds != null) {
					con = dataSource.getConnection(); 
					String sql = "update courses set roadmap_id = null where roadmap_id =?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, roadMapId);
					pstmt.executeUpdate();
					    for(String courseId : courseIds) {
					    		couserId = Integer.parseInt(courseId);
					 			sql = "update courses set roadmap_id = ? where course_id=?";
					 			pstmt = con.prepareStatement(sql);
					 			pstmt.setInt(1, roadMapId);
					 			pstmt.setInt(2, couserId);
					 			pstmt.executeUpdate();
					    }
				}
			}catch (Exception e) {
	 			log.debug("RoadMapDAO updateRoadMapInsert error : {}", e);
	 		}finally {
	 			resourceRelease();
			}				
		}
		//로드맵 리스트 화면에서 삭제 버튼을 눌러 DB에서 로드맵을 삭제하는 메소드
		public void deleteRoadMap(int roadMapId) {
			String sql= null;
			try {	
				con = dataSource.getConnection(); 
				sql = "update courses set roadmap_id = null where roadmap_id =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, roadMapId);
				pstmt.executeUpdate();
				sql = "delete from roadMap where roadMap_id =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, roadMapId);
				pstmt.executeUpdate();
			}catch (Exception e) {
				log.debug("RoadMapDAO deleteRoadMap error : {}", e);
			}finally {
				resourceRelease();
			}
		}
		//로드맵 제목 등록시 DB에 존재하는지 유효성검사
		public boolean checkRoadMapTitle(String roadMapTitle) {
			boolean result = false;
			try {
				 con = dataSource.getConnection();

				 String sql = "select  decode(count(*), 1, 'true', 'false') as result from roadMap where ROADMAP_TITLE=?";
				 
				 pstmt = con.prepareStatement(sql);
				 pstmt.setString(1, roadMapTitle); 
				 rs = pstmt.executeQuery();
				 rs.next();
				 String value = rs.getString("result");
				 result = Boolean.parseBoolean(value); 
				 
				 System.out.println("result : " + result);
				 
			} catch (Exception e) {
				log.debug("checkRoadMapTitle error : {}", e);
			} finally {
				resourceRelease();
			}
			
			return result;
		}
		
		public UsersVO getPayDetail(String user_id){
			UsersVO list=new UsersVO();
			try {
				con = dataSource.getConnection(); 
				String sql = "select * from users where user_id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, user_id);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					UsersVO userVO=new UsersVO();
					list.setUser_name(rs.getString("user_name"));
					list.setEmail(rs.getString("email"));
					list.setPhone_number(rs.getString("phone_number"));
					list.setAddress(rs.getString("address"));
				}
			} catch (Exception e) {
				log.debug("getPayDetail error : {}",e);
			}finally {
				resourceRelease();
			}
			return list;
		}
	
	

}
