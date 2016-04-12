package org.scit.app.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.scit.app.persistance.ProjectDAO;
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
	public String movieList(Model model, HttpSession session){
		ProjectDAO dao=sqlSession.getMapper(ProjectDAO.class);
		session.setAttribute("proNum", "P000000001");
		List<User> userList=dao.selectUserList((String)session.getAttribute("proNum"));
		System.out.println(userList);
		model.addAttribute("userList", userList);
		return "gantchart";			
	}
	
	@RequestMapping(value="insertGantchart",method=RequestMethod.POST)
	public String movieList(GantchartWarpper warpper, HttpSession session){
		for(int i=0;i<warpper.getList().size();i++){
			System.out.println(warpper.getList().get(i));
		}
		return "gantchart";			
	}
}
