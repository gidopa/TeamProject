package VO;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CoursesVO {
	private int courseId;
	private String courseTitle;
	private String courseDescription;
	private int instrtuctorId;
	private int coursePrice;
	private Date registrtionDate;
	private int enrollCount;
	private int categoryId;
	private String imgPath;
}
