package org.scit.app.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.scit.app.controllers.UserController;
import org.scit.app.persistence.UserDao;
import org.scit.app.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
@Controller
public class Deliverer {
	@Autowired
	static SqlSession sqlSession;
	private static final List<Object> deliver = new ArrayList<Object>();
	public static void putDeliver(Object object){
		deliver.add(object);
	//UserDao dao = sqlSession.getMapper(UserDao.class);
	//	User u = dao.selectOne(String.valueOf(object));
	//	System.out.println(u.toString());
	}
	public static void cleanDeliver(){
		deliver.clear();
	}
	public static List<Object> getDeliver(){
		return deliver;
	}
	private Deliverer(){}
}
