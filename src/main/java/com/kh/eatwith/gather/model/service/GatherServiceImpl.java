package com.kh.eatwith.gather.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.gather.model.dao.GatherDao;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.gather.model.dto.MemberGather;
import com.kh.eatwith.member.model.dto.Member;

@Service
@Transactional(rollbackFor = Exception.class)
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
	public List<CustomMap> getNearClosure() {
		return gatherDao.getNearClosure();
	}
	
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
	
	@Override
	public List<Gather> selectReviewByRestaurantNo(String restaurantNo) {
		return gatherDao.selectReviewByRestaurantNo(restaurantNo);
	}

	@Override
	public List<CustomMap> getNewestGatherings(Map<String, Object> params) {
		return gatherDao.getNewestGatherings(params);
	}
	@Override
	public List<Gather> checkFood(int checkFood) {
		return gatherDao.checkFood(checkFood);
	}
	
	@Override
	public List<Map<String, Object>> getGatherByLocation(CustomMap param) {
		return gatherDao.getGatherByLocation(param);
	}
	@Override
	public List<Map<String, Object>> gatherMore(int page) {
		return gatherDao.gatherMore(page);
	}
	@Override
	public List<Map<String, Object>> getLatestList() {
		return gatherDao.getLatestList();
	}
	
	@Override
	public List<CustomMap> getRestaurantGathering(Map<String, Object> no) {
		return gatherDao.getRestaurantGatherings(no);
	}
	@Override
	public List<CustomMap> getGatherByOwnerNo(int no) {
		return gatherDao.getGatherByOwnerNo(no);
	}
	@Override
	public List<CustomMap> getPastGatherByOwnerNo(Map<String, Integer> params) {
		int limit = params.get("limit");
		int offset = (params.get("cPage")-1)*limit;
		RowBounds rb = new RowBounds(offset, limit);
		return gatherDao.getPastGatherByOwnserNo(params, rb); 
		
	}
	
	
	@Override
	public List<CustomMap> getJoinedGather(int userNo) {
		return gatherDao.getJoinedGather(userNo);
	}
	
	@Override
	public List<CustomMap> getJoinedPastGather(Map<String, Integer> params) {
		int limit = params.get("limit");
		int offset = (params.get("cPage")-1)*limit;
		RowBounds rb = new RowBounds(offset, limit);
		return gatherDao.getJoinedPastGather(params, rb); 
	
	}
	
	
}
