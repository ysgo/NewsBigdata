package vo;

public class NewsVO {
	private String title;
	private String date;
	private String contents;
	
	private String keyword;
	private String action;
	
	private int pageNo;
	private int startIndex;
	private int CntPerPage;
	
	
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	@Override
	public String toString() {
		return "[title:"+title+"\ndate:"+date+"\ncontents:"+contents+"]";
	}

	public void setStartIndex(int startIndex) {
		System.out.println("VO의 setStartIndex " + startIndex);
		this.startIndex=startIndex;
		
	}
	public void setCntPerPage(int pageSize) {		
		System.out.println("VO의 CntPerPage ");
		this.CntPerPage=pageSize;
	}
	
}
