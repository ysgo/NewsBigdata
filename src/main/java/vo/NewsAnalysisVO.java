package vo;


public class NewsAnalysisVO {
	private int idx;
	private int p_code;
	private int s_code;
	
	public NewsAnalysisVO(int idx, int p_code, int s_code) {
		this.idx = idx;
		this.p_code = p_code;
		this.s_code = s_code;
	}
	public NewsAnalysisVO(int idx, int p_code) {
		this.idx = idx;
		this.p_code = p_code;
		this.s_code = 1;
	}
	public NewsAnalysisVO(int idx) {
		this.idx = idx;
		this.p_code = 1;
		this.s_code = 1;
	}
	public NewsAnalysisVO() { }
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getP_code() {
		return p_code;
	}
	public void setP_code(int p_code) {
		this.p_code = p_code;
	}
	public int getS_code() {
		return s_code;
	}
	public void setS_code(int s_code) {
		this.s_code = s_code;
	}
	@Override
	public String toString() {
		return "[idx: " + idx + "p_code: "+p_code+", s_code: "+s_code+"]";
	}
}
