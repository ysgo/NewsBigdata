package com.mynews.newsbigdata.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "news_lists")
public class News {
	public static final String MULTIPLE = "news";

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

	@Override
	public String toString() {
		return "NewsVO [id=" + id + ", name=" + name + ", title=" + title + ", category=" + category + ", date=" + date
				+ ", url=" + url + ", content=" + content + ", dataSize=" + dataSize + "]";
	}
}
