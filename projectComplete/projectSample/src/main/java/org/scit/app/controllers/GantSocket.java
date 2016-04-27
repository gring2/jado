package org.scit.app.controllers;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;

import javax.websocket.OnOpen;

import javax.websocket.Session;

import javax.websocket.server.ServerEndpoint;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.scit.app.vo.GantMember;
import org.scit.app.vo.Gantchart;
import org.scit.app.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@ServerEndpoint("/gantSocket")
@Controller
public class GantSocket {
	static Set<Session> sessionUsers = Collections.synchronizedSet(new HashSet<Session>());
	// Session 객체를 컬렉션에 보관하여 두고 해당 클라이언트에게 데이터를 전송할 때마다 사용한다
	private Session session;
	private String nickname;
	private String ProNum;
	private String Protheme;
	private static final HashMap<String, HashMap> Service = new HashMap();
	private static final HashMap<String, Session> sessionMap = new HashMap();
	
	@OnOpen	
	public void handleOpen(Session userSession) {
		System.out.println("sadf;oashgohasf");
		System.out.println(userSession.toString());
		sessionUsers.add(userSession);
		this.session = userSession;
	    String[] params = session.getQueryString().split("&");
	    System.out.println(session.getQueryString());
	    String usr = params[0].split("=")[1];
	    this.nickname=usr;
	    try{
		    String pNum = params[2].split("=")[1];
		    String theme = params[4].split("=")[1];
		    System.out.println("간트 소켓"+usr+"/"+pNum+"/"+theme);
		    try{
		    	usr = URLDecoder.decode(usr,"UTF-8");//파라미터로 전달된 데이터는 URLDecoder를 사용하여 복원한다
		    }catch(Exception e){
		    }
		   
		    this.ProNum=pNum;
		    this.Protheme=theme;
		    HashMap<String, HashMap>proTemp = Service.get(pNum);
		    if(proTemp==null){
		    	HashMap<String, Session>Theme = new HashMap<String, Session>();
		    	HashMap<String, HashMap>project= new HashMap<String, HashMap>();
		    	Theme.put(this.nickname, this.session);
		    	project.put(theme, Theme);
		    	Service.put(pNum, project);
		    }else{
		    	HashMap<String, Session>themeTemp = proTemp.get(theme);
		    	if(themeTemp==null){
		        	HashMap<String, Session>Theme = new HashMap<String, Session>();
		           	Theme.put(this.nickname, this.session);
		        	proTemp.put(theme, Theme);
		        	Service.replace(pNum, proTemp);
		    	}else{
		    		themeTemp.put(this.nickname, session);
		    	}
		    }
		}
	    catch(ArrayIndexOutOfBoundsException e){
	    	e.printStackTrace();	    	
	    }finally {
	    	sessionMap .put(this.nickname, session);
		}		
	}
	@OnError
	public void onError(Session session, Throwable thr)  {
		System.out.println("dddd"+session.toString()+" : "+thr.toString());
		}
	
	@OnMessage	
	public void handleMessage(Session session, String message) throws IOException {
		JSONObject jobj = (JSONObject)JSONValue.parse(message);        
		HashMap<String, Session> targets= (HashMap<String, Session>) Service.get(this.ProNum).get(this.Protheme);
		Set<String> keyset = targets.keySet();
		for(String key:keyset){
			System.out.println(targets.get(key)+"보내기");
			targets.get(key).getBasicRemote().sendText(jobj.toString());
		}
	} 	
	@OnClose
	public void handleClose(Session session) {
		System.out.println("inCLose"+session);
		HashMap<String, Session> targets= (HashMap<String, Session>) Service.get(this.ProNum).get(this.Protheme);
		targets.remove(this.nickname);
		Service.get(this.ProNum).replace(this.Protheme, targets);
		Session sesion = sessionMap .remove(this.nickname);
	 	System.out.println(sesion.toString());
		sessionUsers.remove(session);
	}
}

