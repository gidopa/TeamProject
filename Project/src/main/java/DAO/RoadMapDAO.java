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
	
	

}
