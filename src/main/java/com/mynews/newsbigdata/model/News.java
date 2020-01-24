package com.mynews.newsbigdata.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "news_lists")
public class News {
	@Id
	private int id;

	@Column(length = 50, nullable = false)
	private String name;

	@Column(length = 255, nullable = false)
	private String title;

	@Column(length = 50, nullable = false)
	private String category;

	@Column(length = 50, nullable = false)
	private String date;

	@Column(length = 255)
	private String url;

	@Column(columnDefinition = "longtext", nullable = false)
	private String content;

	@Column(nullable = false)
	private int dataSize;

	private String keyword;
	private String action;

	private int pageNo;
	private int startIndex;
	private int CntPerPage;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public int getDataSize() {
		return dataSize;
	}

	public void setDataSize(int dataSize) {
		this.dataSize = dataSize;
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
		this.startIndex = startIndex;
	}

	public void setCntPerPage(int pageSize) {
		System.out.println("VO의 CntPerPage ");
		this.CntPerPage = pageSize;
	}

	@Override
	public String toString() {
		return "NewsVO [id=" + id + ", name=" + name + ", title=" + title + ", category=" + category + ", date=" + date
				+ ", url=" + url + ", content=" + content + ", dataSize=" + dataSize + ", keyword=" + keyword + ", action="
				+ action + ", pageNo=" + pageNo + ", startIndex=" + startIndex + ", CntPerPage=" + CntPerPage + "]";
	}
}
