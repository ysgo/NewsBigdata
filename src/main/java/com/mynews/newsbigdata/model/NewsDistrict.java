package com.mynews.newsbigdata.model;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "news_districts")
public class NewsDistrict {
	@Id
	private int id;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "news_id")
	private News news;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "province_id")
	private Province province;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "sigungu_id")
	private Sigungu sigungu;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public News getNews() {
		return news;
	}

	public void setNews(News news) {
		this.news = news;
	}

	public Province getProvince() {
		return province;
	}

	public void setProvince(Province province) {
		this.province = province;
	}

	public Sigungu getSigungu() {
		return sigungu;
	}

	public void setSigungu(Sigungu sigungu) {
		this.sigungu = sigungu;
	}

	@Override
	public String toString() {
		return "[id: " + id + ", news: " + news + "province: " + province + ", sigungu: " + sigungu + "]";
	}
}
