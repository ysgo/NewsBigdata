package com.mynews.newsbigdata.service;

import java.util.List;

import com.mynews.newsbigdata.mapper.NewsZonesMapper;
import com.mynews.newsbigdata.model.Province;
import com.mynews.newsbigdata.model.Sigungu;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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