package com.kh.eatwith.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.eatwith.notice.model.dto.Notice;

@Mapper
public interface NoticeDao {

	@Select("select * from notice where deleted_at is null")
	List<Notice> selectNoticeList(RowBounds rowBounds);

	@Select("select count(*) from notice where deleted_at is null")
	int getTotalContent();

	@Insert("insert into notice values(seq_notice_no.nextval, #{noticeTitle}, #{noticeContents}, default, default, default)")
	int insertNotice(Notice notice);
	
	@Select("select * from notice where notice_no = #{noticeNo}")
	Notice selectOneNotice(int noticeNo);

	@Select("select li.* from (select notice_no, notice_title, LAG(notice_title,1,-1) OVER(ORDER BY notice_no ASC) AS pre, LEAD(notice_title,1,-1) OVER(ORDER BY notice_no ASC) AS next FROM notice) li where li.notice_no = #{noticeNo}")
	List<Notice> selectNoticeDetail(Map<String, Integer> param);
	
	@Delete("update notice set deleted_at = sysdate where notice_no = #{noticeNo}")
	int deleteNotice (int noticeNo);

	@Update("update notice set notice_title = #{noticeTitle}, notice_contents = #{noticeContents}, updated_at = sysdate where notice_no = #{noticeNo}")
	int updateNotice(Notice notice);

}
