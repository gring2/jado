package org.scit.app.controllers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
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
import org.scit.app.persistence.UserDao;
import org.scit.app.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@ServerEndpoint("/echo")
public class SocketServer {
static Set<Session> sessionUsers = Collections.synchronizedSet(new HashSet<Session>());
// 클라이언트가 새로 접속할 때마다 한개의 Session 객체가 생성된다.
// Session 객체를 컬렉션에 보관하여 두고 해당 클라이언트에게 데이터를 전송할 때마다 사용한다
private Session session;
private String nickname;
private String ProNum;
private String Protheme;
static FileOutputStream fos = null;
private static final HashMap<String, HashMap> Service = new HashMap();
private static final HashMap<String, Session> sessionMap = new HashMap();
	

/**

 * When the client try to connection to websocket server,

 * open session and add information to the collection.

 *

 * @author GOEDOKID

 * @since 2015. 3. 18. 

 * @param Session userSession

 * @return

 */

@OnOpen

public void handleOpen(Session userSession) {
	System.out.println(userSession.toString());
	sessionUsers.add(userSession);
    this.session = userSession;
    String[] params = session.getQueryString().split("&");
    String usr = params[0].split("=")[1];
    this.nickname=usr;
    try{
    String pNum = params[1].split("=")[1];
    String theme = params[2].split("=")[1];
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
    	
    }finally {
    	sessionMap .put(this.nickname, session);
	}
}



/**

 * Send to message designated client by "websocket.send()" command.

 *

 * @author GOEDOKID

 * @since 2015. 3. 18. 

 * @param String message

 * @return
 * @throws Throwable 

 */

@OnError
public void onError(Session session, Throwable thr)  {
	System.out.println("dddd"+session.toString()+" : "+thr.toString());
	}
@OnMessage

public void handleMessage(Session session, String message) throws IOException {
	JSONObject jobj = (JSONObject)JSONValue.parse(message);
	String usrName = (String)jobj.get("usrName");
	String way = (String)jobj.get("way");
	String content = (String)jobj.get("content");
		if(way==null){
			System.out.println("way is null");
			System.out.println(sessionMap.get(this.nickname+"zombie"));
			sendToOne(usrName, sessionMap.get(this.nickname+"zombie"));
		}else if(way.equals("chat")||way.equals("cal")||way.equals("gant")){/////지민 ||way.equals("gant")추가
			HashMap<String, Session> targets= (HashMap<String, Session>) Service.get(this.ProNum).get(this.Protheme);
			Set<String> keyset = targets.keySet();
			for(String key:keyset){
				System.out.println(targets.get(key)+"보내기");
				targets.get(key).getBasicRemote().
                sendText(JSONConverter('#'+way+":"+content, usrName));
			}
		}else if(way.equals("download")){
			HashMap<String, Session> targets= (HashMap<String, Session>) Service.get(this.ProNum).get(this.Protheme);
			Set<String> keyset = targets.keySet();
			for(String key:keyset){
				targets.get(key).getBasicRemote().sendText(JSONConverter("#hihioha"+":"+content, usrName));
			}
		}
		

}


private void sendToOne(String msg, Session ses) {
  	try {
  		String[] params = session.getQueryString().split("&");
  		String usr = params[0].split("=")[1];
    	try{
    		usr = URLDecoder.decode(usr,"UTF-8");//파라미터로 전달된 데이터는 URLDecoder를 사용하여 복원한다
    	}catch(Exception e){
    		
    	}
  		JSONObject jsonObject = new JSONObject();
  		jsonObject.put("message", msg);
  		ses.getBasicRemote().sendText(jsonObject.toString());}
	 catch (IOException e) {
		e.printStackTrace();
	}
  }

/**

 * Session remove When browser down or close by client control

 * 

 * @author GOEDOKID

 * @since 2015. 3. 18. 

 * @param 

 * @return

 */

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

	

public String JSONConverter(String message,  String type) {

	JSONObject jsonObject = new JSONObject();

	jsonObject.put("type", type);

	jsonObject.put("message", message);

	return jsonObject.toString();

}

}

