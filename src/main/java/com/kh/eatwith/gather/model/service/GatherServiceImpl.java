package com.kh.eatwith.gather.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.eatwith.gather.model.dao.GatherDao;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.gather.model.dto.MemberGather;
import com.kh.eatwith.member.model.dto.Member;

@Service
public class GatherServiceImpl implements GatherService{
	@Autowired
	GatherDao gatherDao;
	
	@Override
	public int gatherEnroll(Gather gather) {
		return gatherDao.gatherEnroll(gather);
	}
	
	@Override
	public int getTotalContent() {
		return gatherDao.getTotalContent();
	}
	
	@Override
	public Gather selectOneGather(int no) {
		return gatherDao.selectOneGather(no);
	}
	
	@Override
	public List<Map<String, Object>> getGatherList() {
		return gatherDao.getGatherList();
	}
	
	@Override
	public Map<String, Object> getOneGather(int no) {
		return gatherDao.getOneGather(no);
	}
	
	@Override
	public Map<String, Object> selectOneGatherInfo(int no) {
		return gatherDao.selectOneGatherInfo(no);
	}
	
	@Override
	public int gatherUpdate(Gather gather) {
		return gatherDao.gatherUpdate(gather);
	}
	@Override
	public int gatherDelete(int no) {
		return gatherDao.gatherDelete(no);
	}
	
	@Override
	public int applyGather(Map<String,Object> param) {
		return gatherDao.applyGather(param);
	}
	
	@Override
	public int countGatherMem(int no) {
		return gatherDao.countGatherMem(no);
	}
	
	@Override
	public int cancelGather(Map<String, Object> param) {
		return gatherDao.cancelGather(param);
	}
	
	@Override
	public Integer chkGatherIn(Map<String, Object> param) {
		return gatherDao.chkGatherIn(param);
	}
	
	@Override
	public Member getMemberNo(String loginId) {
		return gatherDao.getMemberNo(loginId);
	}
}
