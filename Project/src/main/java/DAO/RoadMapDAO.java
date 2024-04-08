package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
			roadMapVO.setImgPath(rs.getString("img_path"));
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
	
	

}
