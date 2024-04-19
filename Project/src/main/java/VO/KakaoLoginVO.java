package VO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class KakaoLoginVO {
	private long userId;
	private String email;
	private String name;
	private String phoneNumber;
	private String address;
}
