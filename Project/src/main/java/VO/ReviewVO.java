package VO;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewVO {
	private int reviewId, courseId;
	private String userId, reviewContent, courseTitle;
	private Date reviewDate;
	private double reviewScore;
}
