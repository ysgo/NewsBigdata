package com.pronews.news.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pronews.news.model.Province;
import com.pronews.news.model.Sigungu;

@Mapper
public interface NewsZonesMapper {
  public List<Province> getAllProvinces();

  public List<Sigungu> getAllSigungus();
}