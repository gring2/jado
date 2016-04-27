package org.scit.app.controllers;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.type.IntegerTypeHandler;
import org.apache.log4j.Logger;
import org.scit.app.persistence.ProjectDao;
import org.scit.app.persistence.UserDao;
import org.scit.app.vo.Project;
import org.scit.app.vo.Theme;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ProjectController {
	@Autowired
	SqlSession sqlSession;
	
	private static final Logger logger = Logger.getLogger(UserController.class);
	
	@RequestMapping(value="insertProject", method=RequestMethod.GET)
	public String insertProject(String title, String userNum, Project project, Model model) {
		
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		int result = dao.insertProject(project);
		dao.insertLeader(userNum);
			
		return "redirect:afterLogin";
	}	
	
	
	@RequestMapping(value="gotoGroup", method=RequestMethod.GET)
	public String gotoGroup(String proNum,HttpSession session ,Model model) {
		model.addAttribute("theme", "open");
		model.addAttribute("proNum", proNum);
		session.setAttribute("proNum", proNum);//지민 모델에 넣는걸 세션에 넣는 걸로 바꿈
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<Project>proList = userDao.selectProjectList((String)session.getAttribute("userNum"));
		List<Theme> themeList = dao.selectThemeList(proNum);
		model.addAttribute("TList", themeList);
		model.addAttribute("proList", proList);
		return "index";
		
	}
	
	@RequestMapping(value="insertTheme", method=RequestMethod.POST)
	public @ResponseBody List<Theme> insertTheme(@RequestBody Map<String, Object>json, Theme theme) {
		String themeName = (String) json.get("themeName");
		String proNum = (String) json.get("proNum");
		theme.setThemeName(themeName);
		theme.setProNum(proNum);
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		dao.insertTheme(theme);
		List<Theme> themeList = dao.selectThemeList(proNum);
		return themeList;
	}	
	
	@RequestMapping(value="deleteGroup",method=RequestMethod.POST)
	public String deleteProject(String proNum){
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		int i = dao.deleteALLMember(proNum);
		int k = dao.deleteALLTheme(proNum);
		int y = dao.deleteProject(proNum);
		return "redirect:afterLogin";
	}
	@RequestMapping(value="deleteTheme",method=RequestMethod.POST)
	public @ResponseBody List<Theme> deleteTheme(@RequestBody Map<String, Object>json){
		String thmNum = (String) json.get("thmNum");
		String proNum = (String) json.get("proNum");
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		dao.deleteTheme(thmNum);
		List<Theme> themeList = dao.selectThemeList(proNum);
		return themeList;
	}	
	
}
