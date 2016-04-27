package org.scit.app.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.scit.app.persistence.ChatDao;
import org.scit.app.persistence.ProjectDao;
import org.scit.app.persistence.UserDao;
import org.scit.app.vo.Chat;
import org.scit.app.vo.Message;
import org.scit.app.vo.Notice;
import org.scit.app.vo.Scrap;
import org.scit.app.vo.Storage;
import org.scit.app.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller

public class AjaxController {
	@Autowired
	SqlSession sqlSession;
	@RequestMapping(value="record", method = RequestMethod.POST)
	public @ResponseBody void reCord(@RequestBody Map<String, Object> json, HttpSession session){
		String content =  (String) json.get("content");
		String proNum =  (String) json.get("proNum");
		String thmNum =  (String) json.get("thmNum");
		ChatDao dao = sqlSession.getMapper(ChatDao.class);
		Chat chat = new Chat();
		chat.setContent(content);
		User vo = (User) session.getAttribute("user");
		chat.setId(vo.getId());
		chat.setThmNum(thmNum);
		chat.setChatType("chat");
		System.out.println(chat.toString());
		dao.insertRecord(chat);
	}
	
	@RequestMapping(value="scrap", method = RequestMethod.POST)
	public @ResponseBody void scrap(@RequestBody Map<String, Object> json, Scrap scrap, HttpSession session){
		String content = (String) json.get("data");
		String title = (String) json.get("title");
		scrap.setContent(content);
		scrap.setTitle(title);
		User vo = (User) session.getAttribute("user");
		scrap.setThemeName(vo.getUserNum());
		ChatDao dao = sqlSession.getMapper(ChatDao.class);
		if(dao.getScrap(scrap)==null){
			dao.insertscrap(scrap);
		}else{
			dao.updateScrap(scrap);
		}
	}
	@RequestMapping(value="readScrapList", method = RequestMethod.POST)
	public @ResponseBody List<Scrap> readScrapList(@RequestBody Map<String, Object> json, Scrap scrap, HttpSession session){
		String userNum = (String) json.get("userNum");
		
		ChatDao dao = sqlSession.getMapper(ChatDao.class);
		List<Scrap> scrapList = dao.readScrapList(userNum);
		return scrapList;
	}
	
	@RequestMapping(value="getScrap", method = RequestMethod.POST)
	public @ResponseBody Scrap getScrap(@RequestBody Map<String, Object> json, Scrap scrap, HttpSession session){
		String userNum = (String) json.get("userNum");
		String title = (String) json.get("title");
		ChatDao dao = sqlSession.getMapper(ChatDao.class);
		scrap.setTitle(title);
		scrap.setThemeName(userNum);
		String scrapContent = dao.getScrap(scrap);
		scrap.setContent(scrapContent);
		return scrap;
	}
	
	@RequestMapping(value="viewMsgList", method = RequestMethod.POST)
	public@ResponseBody List<Message> viewMsgList(@RequestBody Map<String, Object> json){
		String receiver = (String) json.get("receiver");
		ChatDao dao = sqlSession.getMapper(ChatDao.class);
		List<Message>msgList = dao.selectMsgList(receiver);
		
		return msgList;
	}
	
	@RequestMapping(value="invite", method = RequestMethod.POST)
	public@ResponseBody void invite(@RequestBody Map<String, Object> json,Message msg){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		ChatDao chatDao = sqlSession.getMapper(ChatDao.class);
		
		String receiver = (String) json.get("receiver");
		String proNum = (String) json.get("group");
		String sender = (String) json.get("sender");
		User user = userDao.selectReceiver(receiver);
		String title = dao.selectProject(proNum);
		msg.setReceiver(receiver);
		msg.setSender(sender);
		msg.setIsinvate("wait");
		msg.setContent(proNum+title+"에서 초대하였습니다.");
		chatDao.insertMessage(msg);
	}
	
	@RequestMapping(value="joinGroup", method = RequestMethod.POST)
	public@ResponseBody void joinGroup(@RequestBody Map<String, Object> json,Message msg,HttpSession session){
		ProjectDao proDao = sqlSession.getMapper(ProjectDao.class);		
		ChatDao chatDao = sqlSession.getMapper(ChatDao.class);
		boolean isinvate = (Boolean) json.get("isinvate");
		String proNum = (String) json.get("proNum");
		User vo = (User) session.getAttribute("user");
		Map<String, String>keyword = new HashMap<String, String>();
		keyword.put("proNum",proNum);
		keyword.put("userNum", vo.getUserNum());
		System.out.println(keyword.toString()+"정보");
		if(isinvate==true){
			proDao.insertMember(keyword);
		}
		String receiver = vo.getId();
		keyword.put("receiver", receiver);
		chatDao.deleteInvite(keyword);
		
	}
	
	@RequestMapping(value="getStgList", method = RequestMethod.POST)
	public@ResponseBody List<Storage> getStgList(@RequestBody Map<String, Object> json,HttpSession session){
		ProjectDao prodao = sqlSession.getMapper(ProjectDao.class);
		List<Storage> stgList = prodao.selectStorageList((String) json.get("thmNum"));
		return stgList;
	}
	
	@RequestMapping(value="getBookList", method = RequestMethod.POST)
	public@ResponseBody List<Chat> getBookList(@RequestBody Map<String, Object> json,HttpSession session){
		ProjectDao prodao = sqlSession.getMapper(ProjectDao.class);
		List<Chat> bookList = prodao.selectBookList((String) json.get("thmNum"));
		return bookList;
	}
	
	@RequestMapping(value="fileupload", method = RequestMethod.POST)
	public @ResponseBody String fileUpload(MultipartHttpServletRequest request,HttpSession session) throws IOException{
		User vo = (User) session.getAttribute("user");
		String name = null;
		MultipartFile multiFile = null;
		Map<String, MultipartFile> xx = request.getFileMap();
		Set<String> keys = xx.keySet();
		for(String key:keys){
			multiFile= xx.get(key);
			name = vo.getUserNum()+multiFile.getOriginalFilename();
			String realPath = request.getServletContext().getRealPath("/transfer");
			String fPath = realPath+"\\"+name ;
			FileOutputStream f = new FileOutputStream(new File(fPath));
			f.write(multiFile.getBytes());
			System.out.println(multiFile.getBytes());
		}
		return name;
	}
	
	@RequestMapping(value="ajaxdownload", method=RequestMethod.GET)
	public void ajaxdownload(HttpServletRequest request,String filename,HttpServletResponse response) throws UnsupportedEncodingException, IOException{
			//response header ?섏젙
			String fname = new String(filename.getBytes("ISO8859-1"),"UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename="+new String(fname.getBytes(),"ISO8859-1"));
			String fullPath = request.getServletContext().getRealPath("\\transfer")+"\\"+fname;
			FileInputStream fin = new FileInputStream(fullPath );
			ServletOutputStream sout = response.getOutputStream();
			byte[] buffer = new byte[1024];
			int size=0;
			while((size = fin.read(buffer,0,buffer.length))!=-1){
				sout.write(buffer,0,size);
			}
			fin.close();sout.close();
	}
	@RequestMapping(value="noticeReg", method = RequestMethod.POST)
	public @ResponseBody List<Notice>noticeReg(@RequestBody Map<String, Object> json,HttpSession session){
		String proNum = (String) json.get("proNum");
		String content = (String)json.get("content");
		User vo = (User) session.getAttribute("user");
		String id = vo.getId();
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		Map<String,String> keyword = new HashMap<String, String>();
		keyword.put("proNum", proNum);
		keyword.put("content", content);
		keyword.put("id", id);
		dao.noticeReg(keyword);
		return dao.viewNotice(proNum);
	}
	
	@RequestMapping(value="deleteFile", method = RequestMethod.POST)
	public @ResponseBody List<Storage> deleteFile(@RequestBody Map<String, Object> json, Storage storage) throws IOException{
		String fileName = (String) json.get("fileName");
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		storage = dao.selectStorage(fileName);
		int result = dao.deleteStorage(fileName);
		if(result == 1) {
			File dFile = new File(storage.getRealPath() + "\\" + storage.getFileName());
			dFile.delete();
		}
		
		ProjectDao prodao = sqlSession.getMapper(ProjectDao.class);
		List<Storage> stgList = prodao.selectStorageList(storage.getThmNum());
		return stgList;
	}
	
	
}
