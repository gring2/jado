package org.scit.app.controllers;


import java.util.Locale;
import java.util.Map;

import org.scit.app.vo.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AjaxController {
	
	private static final Logger logger = LoggerFactory.getLogger(AjaxController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/")
	public String index() {
		
		
		return "index";
	}
/*	@RequestMapping(value="doAjax", method = RequestMethod.POST)
	public @ResponseBody User doAjax(@RequestBody Map<String, Object> json){
		String x =  (String) json.get("id");
		System.out.println(x);
		logger.info("ajax Data =>"+json);
		User member = null;
		
		return member;
	}*/
}