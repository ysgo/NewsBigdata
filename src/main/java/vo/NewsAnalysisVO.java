package vo;


public class NewsAnalysisVO {
	private String text;
	private String p_name;
	private String s_name;
	
	public NewsAnalysisVO(String text, String p_name, String s_name) {
		this.text = text;
		this.p_name = p_name;
		this.s_name = s_name;
	}
	public NewsAnalysisVO(String text, String p_name) {
		this.text = text;
		this.p_name = p_name;
		this.s_name = "0";
	}
	public NewsAnalysisVO(String text) {
		this.text = text;
		this.p_name = "0";
		this.s_name = "0";
	}

	public String gettext() {
		return text;
	}

	public void settext(String text) {
		this.text = text;
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
