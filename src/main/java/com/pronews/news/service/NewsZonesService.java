package com.pronews.news.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pronews.news.mapper.NewsZonesMapper;
import com.pronews.news.model.Province;
import com.pronews.news.model.Sigungu;

@Service
public class NewsZonesService {
  @Autowired
  private NewsZonesMapper newsZonesMapper;

  public List<Province> getAllProvinces() {
    return newsZonesMapper.getAllProvinces();
  }

  public List<Sigungu> getAllSigungus() {
    return newsZonesMapper.getAllSigungus();
  }
}