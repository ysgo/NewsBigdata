package vo;

import java.util.HashSet;

public class AnalysisVO {
	private String strFirst;
	private String strSecond;
	private HashSet<Integer> province = new HashSet<>();
	private HashSet<Integer> sigungu = new HashSet<>();
	
	public int getP_cnt() {
		return province.size();
	}
	public int getS_cnt() {
		return sigungu.size();
	}
	public int getT_cnt() {
		return province.size()+sigungu.size();
	}
	public String getName() {
		return strFirst+strSecond;
	}
	public String getStrFirst() {
		return strFirst;
	}
	public void setStrFirst(String strFirst) {
		this.strFirst = strFirst;
	}
	public String getStrSecond() {
		return strSecond;
	}
	public void setStrSecond(String strSecond) {
		this.strSecond = strSecond;
	}
	public HashSet<Integer> getProvince() {
		return province;
	}
	public void setProvince(HashSet<Integer> province) {
		this.province = province;
	}
	public HashSet<Integer> getSigungu() {
		return sigungu;
	}
	public void setSigungu(HashSet<Integer> sigungu) {
		this.sigungu = sigungu;
	}
}
