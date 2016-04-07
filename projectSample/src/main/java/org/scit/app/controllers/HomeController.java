package org.scit.app.controllers;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.scit.app.persistence.UserDao;
import org.scit.app.vo.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	SqlSession sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		return "ChatRoom";
	}
	@RequestMapping(value = "zombie", method = RequestMethod.GET)
	public String zombie(Locale locale, Model model) {
		return "ZombieChat";
	}
	@RequestMapping(value = "sticky", method = RequestMethod.GET)
	public String sticky(Locale locale, Model model) {
		
		return "Sticky";
	}
	@RequestMapping(value = "cal", method = RequestMethod.GET)
	public String cal(Locale locale, Model model) {
		
		return "calendar";
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
