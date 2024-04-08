package VO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RoadMapVO {
	private int roadMapId;
	private String roadMapTitle;
	private String roadMapDescription;
	private String imgPath;
	private String userId;
}
