package org.scit.app.controllers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.scit.app.persistence.UserDao;
import org.scit.app.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {
	@Autowired
	SqlSession sqlSession;
	UserDao d =null;
	public void getit(List<Object> x){
		System.out.println(x.get(0).toString());
	try{d	= sqlSession.getMapper(UserDao.class);}
	catch(Exception e){
	};
		User xx = d.selectOne(x.get(0).toString());
		System.out.println("Dddd");
		System.out.println(x.toString());
	}
	
	
	@RequestMapping(value="joinView", method=RequestMethod.GET)
	public String join(){
		return "user/joinView";
	}
	@RequestMapping(value="join", method=RequestMethod.GET)
	public String join(User user){
		UserDao dao = sqlSession.getMapper(UserDao.class);
		int result = dao.insert(user);
		return "join/joinComplete";
	}
	@RequestMapping(value="idCheck", method=RequestMethod.POST)
	public @ResponseBody String idCheck(@RequestBody String id){
		System.out.println(id);
		System.out.println("ddd");
		UserDao dao = sqlSession.getMapper(UserDao.class);
		User usr = dao.selectOne(id);
		String message = null;
		if(usr !=null){
			message="fail";
		}else{
			message = "success";
		}
		return message;
	}
	@RequestMapping(value="doAjax", method = RequestMethod.POST)
	public @ResponseBody void doAjax(@RequestBody Map<String, Object> json){
		String x =  (String) json.get("id");
		System.out.println(x);
		UserDao dao = sqlSession.getMapper(UserDao.class);

		User member = 		dao.selectOne(x);
		System.out.println(member);
	}
}
