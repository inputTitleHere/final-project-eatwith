package com.kh.eatwith.admin.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Transactional;

import com.kh.eatwith.notice.model.dao.NoticeDao;
import com.kh.eatwith.notice.model.dto.Notice;
import com.kh.eatwith.review.model.dto.Review;
import com.kh.eatwith.admin.model.dao.AdminDao;
import com.kh.eatwith.admin.model.dto.VisitantCount;
import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.TestMap;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.member.model.dao.MemberDao;
import com.kh.eatwith.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;
import oracle.security.o3logon.a;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDao adminDao;

	@Override
	public List<TestMap> selectRestaurant() {
		return adminDao.selectRestaurant();
	}

	@Override
	public List<TestMap> selectGather() {
		return adminDao.selectGather();
	}

	@Override
	public List<TestMap> selectMember() {
		return adminDao.selectMember();
	}

	@Override
	public int selectGatherYes() {
		return adminDao.selectGatherYes();
	}

	@Override
	public int selectGatherTo() {
		return adminDao.selectGatherTo();
	}

	@Override
	public int selectGatherNow() {
		return adminDao.selectGatherNow();
	}

	@Override
	public List<TestMap> selectGatherRatio() {
		return adminDao.selectGatherRatio();
	}
	

}
