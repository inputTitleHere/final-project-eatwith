package com.kh.eatwith.gather.model.service;

import java.time.LocalDateTime;
import java.util.HashMap;
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
	public List<Map<String,Object>> checkLeader(int gatherNo) {
		return gatherDao.checkLeader(gatherNo);
	}
	@Override
	public int checkLeaderIn(Map<String, Object> param) {
		return gatherDao.checkLeaderIn(param);
	}
	@Override
	public int checkLeaderOut(Map<String, Object> param) {
		return gatherDao.checkLeaderOut(param);
	}
	@Override
	public Integer checkAttendance(Map<String, Object> param) {
		return gatherDao.checkAttendance(param);
	}
	@Override
	public Integer gatherEnd(int no) {
		return gatherDao.gatherEnd(no);
	}
	@Override
	public List<Map<String, Object>> gatherAllList() {
		return gatherDao.gatherAllList();
	}
	@Override
	public List<Map<String, Object>> gatherMoreAll(int startNum) {
		return gatherDao.gatherMoreAll(startNum);
	}
	@Override
	public List<Map<String, Object>> gatherLatestMore(int startNum) {
		return gatherDao.gatherLatestMore(startNum);
	}
	@Override
	public Member getMemberInfo(String loginId) {
		return gatherDao.getMemberInfo(loginId);
	}
}
