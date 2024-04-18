package VO;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
public class NaverLoginVO {
	
		private String id;
		private String email;
		private String name;
		private String mobile;
		
		public NaverLoginVO(String id,  String email, String name, String mobile) {
			super();
			this.id = id;
			this.email = email;
			this.name = name;
			this.mobile = mobile;
		}
		
		
}
