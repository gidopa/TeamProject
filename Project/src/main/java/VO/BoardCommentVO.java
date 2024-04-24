package VO;

import java.sql.Date;

public class BoardCommentVO {
    
    private int comment_idx;
    private int board_idx;
    private String comment_id;
    private String comment_pw;
    private String comment_name;
    private String comment_email;
    private String comment_content;
    private Date comment_date;
    
    public BoardCommentVO() {}

    public BoardCommentVO(int comment_idx, int board_idx, String comment_id, String comment_pw, String comment_name,
                    String comment_email, String comment_content, Date comment_date) {
        this.comment_idx = comment_idx;
        this.board_idx = board_idx;
        this.comment_id = comment_id;
        this.comment_pw = comment_pw;
        this.comment_name = comment_name;
        this.comment_email = comment_email;
        this.comment_content = comment_content;
        this.comment_date = comment_date;
    }

    // Getters and setters
    public int getComment_idx() {
        return comment_idx;
    }

    public void setComment_idx(int comment_idx) {
        this.comment_idx = comment_idx;
    }

    public int getBoard_idx() {
        return board_idx;
    }

    public void setBoard_idx(int board_idx) {
        this.board_idx = board_idx;
    }

    public String getComment_id() {
        return comment_id;
    }

    public void setComment_id(String comment_id) {
        this.comment_id = comment_id;
    }

    public String getComment_pw() {
        return comment_pw;
    }

    public void setComment_pw(String comment_pw) {
        this.comment_pw = comment_pw;
    }

    public String getComment_name() {
        return comment_name;
    }

    public void setComment_name(String comment_name) {
        this.comment_name = comment_name;
    }

    public String getComment_email() {
        return comment_email;
    }

    public void setComment_email(String comment_email) {
        this.comment_email = comment_email;
    }

    public String getComment_content() {
        return comment_content;
    }

    public void setComment_content(String comment_content) {
        this.comment_content = comment_content;
    }

    public Date getComment_date() {
        return comment_date;
    }

    public void setComment_date(Date comment_date) {
        this.comment_date = comment_date;
    }
}

