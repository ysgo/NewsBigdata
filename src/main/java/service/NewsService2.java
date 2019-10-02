package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.NewsDAO2;
import vo.TestVO;

@Service
public class NewsService2 {
	@Autowired
	private NewsDAO2 dao;
	
	public int insertNews(TestVO vo) {
		return dao.insertNews(vo);
	}
}
