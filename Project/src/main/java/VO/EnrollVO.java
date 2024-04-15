package VO;

import java.sql.Date;

import lombok.Data;

@Data
public class EnrollVO {
	
	private int  courseId;
	private String enrollMentId,studentId;
	private Date enrollmentDate;
}
