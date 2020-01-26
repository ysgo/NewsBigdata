package com.mynews.newsbigdata.mapper;

import java.util.List;

import com.mynews.newsbigdata.model.Province;
import com.mynews.newsbigdata.model.Sigungu;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewsZonesMapper {
  public List<Province> getAllProvinces();

  public List<Sigungu> getAllSigungus();
}