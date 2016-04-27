
package org.scit.app.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.scit.app.persistence.UserDao;
import org.scit.app.vo.Project;
import org.scit.app.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {
	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping(value="joinView", method=RequestMethod.GET)
	public String joinView() {
		return "user/joinView";
	}
	
	@RequestMapping(value="idCheck", method=RequestMethod.POST)
	public @ResponseBody String idCheck(String id) {
		String message = "";
		return message;
	}
	
	@RequestMapping(value="insertUser", method=RequestMethod.POST)
	public String insertUser(User user) {

		return "index";
	}
	
	@RequestMapping(value="updateUser", method=RequestMethod.POST)
	public String updateUser(User user) {
		
		return "index";
	}
	
	@RequestMapping(value="loginView", method=RequestMethod.GET)
	public String loginView() {
		return "user/loginView";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
    public String greetingSubmit(User user,HttpSession session,Model model
    		//String id, String password
    		) {
		UserDao dao = sqlSession.getMapper(UserDao.class);
		User vo = dao.selectUser(user);
		
		List<Project> pList = selectProjectList(sqlSession,vo.getUserNum());
		session.setAttribute("user", vo);
		model.addAttribute("pList", pList);
		
		if(vo.getPassword().equals(user.getPassword())) {
			session.setAttribute("loginName", vo.getName());
			session.setAttribute("userNum", vo.getUserNum());
		}
		
		return "afterLogin";
	}
	
	@RequestMapping(value="afterLogin", method=RequestMethod.GET)
	public String afterLogin(HttpSession session,String userNum, Model model) {
		User vo = (User) session.getAttribute("user");
		List<Project>proResult =  new UserController().selectProjectList(sqlSession,vo.getUserNum());
		model.addAttribute("pList", proResult);
		return "afterLogin";
	}
	
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "index";
	}
	
	public List<Project> selectProjectList(SqlSession session , String userNum){
		UserDao dao = session.getMapper(UserDao.class);
		List<Project> result = dao.selectProjectList(userNum);
		return result;
	}
	@RequestMapping(value="gotoIndex", method=RequestMethod.GET)
	public String gotoIndex(){
		return "index";
	}
	
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String join(User user) {
		UserDao dao = sqlSession.getMapper(UserDao.class);		
		dao.insertUser(user);
		return "index";
	}
}
