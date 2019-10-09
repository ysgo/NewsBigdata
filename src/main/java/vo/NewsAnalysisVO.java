package vo;


public class NewsAnalysisVO {
	private String content;
	private String p_name;
	private String s_name;
	
	public NewsAnalysisVO(String content, String p_name, String s_name) {
		this.content = content;
		this.p_name = p_name;
		this.s_name = s_name;
	}

	public String getcontent() {
		return content;
	}

	public void setcontent(String content) {
		this.content = content;
	}

	public String getp_name() {
		return p_name;
	}

	public void setp_name(String p_name) {
		this.p_name = p_name;
	}

	public String gets_name() {
		return s_name;
	}

	public void sets_name(String s_name) {
		this.s_name = s_name;
	}
	
}
