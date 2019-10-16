package vo;

public class NewsVO {
	private String newsname;
	private String title;
	private String category;
	private String date;
	private String url;
	private String content;
	
	private String keyword;
	private String action;
	
	private int pageNo;
	private int startIndex;
	private int CntPerPage;
	
	public String getNewsname() {
		return newsname;
	}
	
	public void setNewsname(String newsname) {
		this.newsname = newsname;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
	public String getDate() {
		return date;
	}
	
	public void setDate(String date) {
		this.date = date;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getKeyword() {
		return keyword;
	}
	
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

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

	public int getStartIndex() {
		return startIndex;
	}

	public int getCntPerPage() {
		return CntPerPage;
	}

	public void setStartIndex(int startIndex) {
		System.out.println("VO의 setStartIndex " + startIndex);
		this.startIndex=startIndex;
	}
	public void setCntPerPage(int pageSize) {		
		System.out.println("VO의 CntPerPage ");
		this.CntPerPage=pageSize;
	}

	@Override
	public String toString() {
		return "NewsVO [newsname=" + newsname + ", title=" + title + ", category=" + category + ", date=" + date
				+ ", url=" + url + ", content=" + content + ", keyword=" + keyword + ", action=" + action + ", pageNo="
				+ pageNo + ", startIndex=" + startIndex + ", CntPerPage=" + CntPerPage + "]";
	}
}
