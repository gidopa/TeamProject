package VO;

import java.sql.Date;

//조회한 하나의 글정보를 저장할 용도
//수정할 하나의 글정보를 조회한 후 저장할 용도
//DB에 추가할 새글정보를 임시로 저장할 용도 
public class BoardVO2 {
	
	private int board_idx, board_cnt;
	private String board_id, board_pw, board_name, board_email, board_title, board_content;
	private Date board_date;
	
	public BoardVO2() {}


	public BoardVO2(int board_idx, int board_cnt, String board_id, String board_pw, String board_name,
					String board_email, String board_title, String board_content) {
		this.board_idx = board_idx;
		this.board_cnt = board_cnt;
		this.board_id = board_id;
		this.board_pw = board_pw;
		this.board_name = board_name;
		this.board_email = board_email;
		this.board_title = board_title;
		this.board_content = board_content;
	}



	public BoardVO2(int board_idx, int board_cnt, String board_id, String board_pw, String board_name,
			String board_email, String board_title, String board_content, Date board_date) {
		this.board_idx = board_idx;
		this.board_cnt = board_cnt;
		this.board_id = board_id;
		this.board_pw = board_pw;
		this.board_name = board_name;
		this.board_email = board_email;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_date = board_date;
	}


	public int getBoard_idx() {
		return board_idx;
	}

	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}

	public int getBoard_cnt() {
		return board_cnt;
	}

	public void setBoard_cnt(int board_cnt) {
		this.board_cnt = board_cnt;
	}

	public String getBoard_id() {
		return board_id;
	}

	public void setBoard_id(String board_id) {
		this.board_id = board_id;
	}

	public String getBoard_pw() {
		return board_pw;
	}


	public void setBoard_pw(String board_pw) {
		this.board_pw = board_pw;
	}


	public String getBoard_name() {
		return board_name;
	}


	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}

	public String getBoard_title() {
		return board_title;
	}


	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}


	public String getBoard_content() {
		return board_content;
	}


	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}


	public Date getBoard_date() {
		return board_date;
	}


	public void setBoard_date(Date board_date) {
		this.board_date = board_date;
	}


	public String getBoard_email() {
		return board_email;
	}


	public void setBoard_email(String board_email) {
		this.board_email = board_email;
	}
	
	
}