package vo;


public class NewsAnalysisVO {
	private String text;
	private String type;
	int count;

	public NewsAnalysisVO(String text, String type, Integer count) {
		this.text = text;
		this.type = type;
		this.count = count;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
}
