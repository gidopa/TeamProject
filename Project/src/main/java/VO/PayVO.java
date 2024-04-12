package VO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class PayVO {
	String paymentId, userId, courseId, paymentDate, paymentAmount, address, paymentStatus,courseTitle, email;
}
