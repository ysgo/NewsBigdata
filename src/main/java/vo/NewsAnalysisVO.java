package vo;


public class NewsAnalysisVO {
	private String name;
	private String p_name;
	private String s_name;
	
	public NewsAnalysisVO(String name, String p_name, String s_name) {
		this.name = name;
		this.p_name = p_name;
		this.s_name = s_name;
	}
	public NewsAnalysisVO(String name,String s_name) {
		this.name = name;
		this.s_name = s_name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getS_name() {
		return s_name;
	}

	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	
}
