package VO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LectureVO {
	private int lectureId;
	private int courseId;
	private int lectureNumber; //강의 순서 (1강, 2강 )
	private String lectureTitle;
	private String lectureSummary;
	private String videoLink; // 강의 영상 링크
	private int duration; // 강의 총 길이
	private String imgPath;
}
