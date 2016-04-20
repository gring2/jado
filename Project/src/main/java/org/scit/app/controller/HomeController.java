package org.scit.app.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.scit.app.persistance.ProjectDAO;
import org.scit.app.vo.GantMember;
import org.scit.app.vo.Gantchart;
import org.scit.app.vo.GantchartWarpper;
import org.scit.app.vo.User;
import org.scit.app.vo.Vote;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@Autowired 
	SqlSession sqlSession;
	
	@RequestMapping(value="gantchartView",method=RequestMethod.GET)
	public String gantchartView(Model model, HttpSession session){
		ProjectDAO dao=sqlSession.getMapper(ProjectDAO.class);
		session.setAttribute("proNum", "P000000001");
		List<User> userList=dao.selectUserList((String)session.getAttribute("proNum"));
		List<Gantchart> gantchartlist=dao.selectGantchart((String)session.getAttribute("proNum"));
		for (int i=0;i<gantchartlist.size();i++){
			gantchartlist.get(i).setGantMemberList(dao.selectGantMember(gantchartlist.get(i).getGantNum()));
			System.out.println(gantchartlist.get(i));
		}
		model.addAttribute("gantchartlist", gantchartlist);
		model.addAttribute("userList", userList);
		return "gantchartView";			
	}
	
	@RequestMapping(value="insertGantchart",method=RequestMethod.POST)
	@ResponseBody
	public String insertGantchart(Gantchart gantchart, HttpSession session){
		ProjectDAO dao=sqlSession.getMapper(ProjectDAO.class);
		dao.deleteGantchart((String)session.getAttribute("proNum"));
		dao.insertGantchart(gantchart);		
		return "success";
	}
	@RequestMapping(value="deleteGantchart",method=RequestMethod.POST)
	@ResponseBody
	public String deleteGantchart(String gantNum){
		ProjectDAO dao=sqlSession.getMapper(ProjectDAO.class);
		dao.deleteGantchart(gantNum);
		return "success";
	}
	
	@RequestMapping(value="insertGantMember",method=RequestMethod.POST)
	@ResponseBody
	public String insertGantMember(GantMember gantMember){
		System.out.println(gantMember);
		ProjectDAO dao=sqlSession.getMapper(ProjectDAO.class);
		dao.insertGantMember(gantMember);
		return "success";
	}
	@RequestMapping(value="updateGantMember",method=RequestMethod.POST)
	@ResponseBody
	public String updateGantMember(GantMember gantMember){
		ProjectDAO dao=sqlSession.getMapper(ProjectDAO.class);
		dao.updateGantMember(gantMember);
		return "success";
	}
	@RequestMapping(value="deleteGantMember",method=RequestMethod.POST)
	@ResponseBody
	public String deleteGantMember(GantMember gantMember){
		ProjectDAO dao=sqlSession.getMapper(ProjectDAO.class);
		dao.deleteGantMember(gantMember);
		return "success";
	}
	@RequestMapping(value="gantchartShowView",method=RequestMethod.GET)
	public String gantchartShowView(HttpSession session, Model model){
		ProjectDAO dao=sqlSession.getMapper(ProjectDAO.class);
		session.setAttribute("proNum", "P000000001");
		List<Gantchart> gantchartlist=dao.selectGantchart((String)session.getAttribute("proNum"));
		for (int i=0;i<gantchartlist.size();i++){
			gantchartlist.get(i).setGantMemberList(dao.selectGantMember(gantchartlist.get(i).getGantNum()));
			System.out.println(gantchartlist.get(i));
		}
		model.addAttribute("gantchartlist", gantchartlist);
		return "gantchartShow";			
	}
}
