package org.scit.app.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.scit.app.persistence.ChatDao;
import org.scit.app.persistence.ProjectDao;
import org.scit.app.persistence.UserDao;
import org.scit.app.vo.Chat;
import org.scit.app.vo.Gantchart;
import org.scit.app.vo.GantchartWarpper;
import org.scit.app.vo.Message;
import org.scit.app.vo.Scrap;
import org.scit.app.vo.Storage;
import org.scit.app.vo.Theme;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String main() {
		return "index";
	}
	
	@RequestMapping(value = "chat", method = RequestMethod.GET)
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
	@RequestMapping(value = "chatbox", method = RequestMethod.GET)
	public String chatbox(Locale locale, Model model) {
		
		return "chatbox";
	}
/*	@RequestMapping(value="doAjax", method = RequestMethod.POST)
	public @ResponseBody void doAjax(@RequestBody Map<String, Object> json){
	
		
		String content =  (String) json.get("data");
		System.out.println("inAjaxMEthod"+json);
		Chat xx = new Chat();
		xx.setContent(content);
		ChatDao dao = sqlSession.getMapper(ChatDao.class);
		dao.insertRecord(xx);

	}*/
	@RequestMapping(value="record", method = RequestMethod.POST)
	public @ResponseBody void reCord(@RequestBody Map<String, Object> json, HttpSession session){
		String sender =  (String) json.get("sender");
		String content =  (String) json.get("content");
		String proNum =  (String) json.get("proNum");
		String thmNum =  (String) json.get("thmNum");
		ChatDao dao = sqlSession.getMapper(ChatDao.class);
		Chat chat = new Chat();
		chat.setContent(content);
		User vo = (User) session.getAttribute("user");
		System.out.println(session.toString());
		System.out.println(vo.toString());
		chat.setUserNum(vo.getUserNum());
		chat.setProNum(proNum);
		chat.setThmNum(thmNum);
		chat.setChatType("chat");
		System.out.println(chat.toString());
		
				dao.insertRecord(chat);
	}
	
	@RequestMapping(value="gantchartView",method=RequestMethod.GET)
	public String gantchartView(Model model, HttpSession session){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		session.setAttribute("proNum", "P000000001");
		List<User> userList=dao.selectUserList((String)session.getAttribute("proNum"));
		model.addAttribute("userList", userList);
		return "gantchartView";			
	}
	
	@RequestMapping(value="insertGantchart",method=RequestMethod.POST)
	public String insertGantchart(GantchartWarpper warpper, HttpSession session){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		dao.deleteGantchart((String)session.getAttribute("proNum"));
		for(int i=0;i<warpper.getList().size();i++){
			dao.insertGantchart(warpper.getList().get(i));
			for (int j=0;j<warpper.getList().get(i).getGantMemberList().size();j++){
				dao.insertGantMember(warpper.getList().get(i).getGantMemberList().get(j));
			}
		}		
		return "redirect:gantchartShowView";	
	}
	@RequestMapping(value="gantchartShowView",method=RequestMethod.GET)
	public String gantchart(HttpSession session, Model model){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		List<Gantchart> list=dao.selectGantchart((String)session.getAttribute("proNum"));
		for (int i=0;i<list.size();i++){
			list.get(i).setGantMemberList(dao.selectGantMember(list.get(i).getGantNum()));
		}
		model.addAttribute("list", list);
		return "gantchartShow";			
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
	@RequestMapping(value="openMessanger", method = RequestMethod.GET)
	public String openMessanger(HttpSession session, Model model){
		User vo = (User) session.getAttribute("user");
		model.addAttribute("userId", vo.getId());
		System.out.println(vo.toString());
		return "openMessanger";
	}
	@RequestMapping(value="sendMsg", method = RequestMethod.POST)
	public String sendMsg(Model model, Message msg){
		System.out.println(msg);
		ChatDao dao = sqlSession.getMapper(ChatDao.class);
		dao.insertMessage(msg);
		model.addAttribute("success", "suceess");
		return "openMessanger";
	}
	@RequestMapping(value="viewMsgList", method = RequestMethod.POST)
	public@ResponseBody List<Message> viewMsgList(@RequestBody Map<String, Object> json){
		String receiver = (String) json.get("receiver");
		ChatDao dao = sqlSession.getMapper(ChatDao.class);
		List<Message>msgList = dao.selectMsgList(receiver);
		
		return msgList;
	}
	@RequestMapping(value="reply", method = RequestMethod.GET)
	public String reply(String sender, String receiver, Model model){
		System.out.println(sender+" : "+receiver);
		model.addAttribute("sender", sender);
		model.addAttribute("receiver", receiver);
		return "reply";
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
		msg.setContent(proNum+title+"�뿉�꽌 珥덈��븯���뒿�땲�떎.");
		chatDao.insertMessage(msg);
		//Map<String, String>keyword = new HashMap<String, String>();
//		keyword.put("userNum", user.getUserNum());
//		keyword.put("proNum",group);
//		dao.insertMember(keyword);
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
		System.out.println(keyword.toString());
		if(isinvate==true){
			proDao.insertMember(keyword);
		}
		String receiver = vo.getId();
		System.out.println(vo.toString());
		keyword.put("receiver", receiver);
		chatDao.deleteInvite(keyword);
		
	}
	@RequestMapping(value="hangout", method=RequestMethod.GET)
	public String hangout(){
		return "hangout";
	}
	@RequestMapping(value="storage", method=RequestMethod.GET)
	public String storage(String proNum, Model model){
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		List<Theme> themeList = dao.selectThemeList(proNum);
		model.addAttribute("themeList", themeList);
		return "storage";
	}
	@RequestMapping(value="saveFile", method=RequestMethod.POST)
	public String moveReg(Storage storage,String proNum, HttpServletRequest request) throws IOException{
		MultipartFile file = storage.getFile();
		if(!file.isEmpty()){
			String originalFile = file.getOriginalFilename();
			storage.setFileName(originalFile);
			//UUID uuid = UUID.randomUUID();
			String savedFile=storage.getThmNum()+
					"_"+originalFile;
			//deployed 寃쎈줈 �븣�븘�삤湲�
			String realPath = request.getServletContext().getRealPath("/upload");
			String fPath = realPath+"\\"+savedFile;
			System.out.println(savedFile);
			System.out.println(originalFile);
			FileOutputStream fs = new FileOutputStream(fPath);
			fs.write(storage.getFile().getBytes());
			fs.close();
		}
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		dao.insertStorage(storage);
		String redirect = "redirect:storage?proNum="+proNum;
		//MovieDao dao = sqlSession.getMapper(MovieDao.class);
	//	dao.insert(storage);
		return redirect;
		
	}
	
	
	@RequestMapping(value="getStgList", method = RequestMethod.POST)
	public@ResponseBody List<Storage> getStgList(@RequestBody Map<String, Object> json,HttpSession session){
		System.out.println(json.get("thmNum").toString());
		ProjectDao prodao = sqlSession.getMapper(ProjectDao.class);
		List<Storage> stgList = prodao.selectStorageList((String) json.get("thmNum"));
		System.out.println(stgList.toString());
		return stgList;
	}
	
	@RequestMapping(value="download", method=RequestMethod.GET)
	public void download(HttpServletRequest request,String fileName,HttpServletResponse response) throws UnsupportedEncodingException, IOException{
			System.out.println(fileName);
			//response header �닔�젙
			String fname = new String(fileName.getBytes("ISO8859-1"),"UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename="+new String(fname.getBytes(),"ISO8859-1"));
			String fullPath = request.getServletContext().getRealPath("\\upload")+"\\"+fname;
			System.out.println(fullPath);
			FileInputStream fin = new FileInputStream(fullPath );
			ServletOutputStream sout = response.getOutputStream();
			byte[] buffer = new byte[1024];
			
			int size=0;
			
			while((size = fin.read(buffer,0,buffer.length))!=-1){
				sout.write(buffer,0,size);
			}
			fin.close();sout.close();
	}
	
	@RequestMapping(value="getBookList", method = RequestMethod.POST)
	public@ResponseBody List<Chat> getBookList(@RequestBody Map<String, Object> json,HttpSession session){
		ProjectDao prodao = sqlSession.getMapper(ProjectDao.class);
		List<Chat> bookList = prodao.selectBookList((String) json.get("thmNum"));
		return bookList;
	}
	@RequestMapping(value="viewBook", method = RequestMethod.GET)
	public String viewBook(String thmNum,String chatDate,HttpSession session,Model model){
		ProjectDao prodao = sqlSession.getMapper(ProjectDao.class);
		Map<String,String> keyword = new HashMap<String, String>();
		keyword.put("thmNum", thmNum); keyword.put("chatDate", chatDate);
		System.out.println(keyword.toString());
		List<Chat> book = prodao.viewBook(keyword);
		System.out.println(book.toString());
		model.addAttribute("meetingBook", book);
		return "viewBook";
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
			name = multiFile.getOriginalFilename()+vo.getUserNum();
			String realPath = request.getServletContext().getRealPath("/upload");
			String fPath = realPath+"\\"+name ;
			FileOutputStream f = new FileOutputStream(new File(fPath));
			f.write(multiFile.getBytes());
		}
		return name;
	}
	
	@RequestMapping(value="deleteFile", method = RequestMethod.GET)
	public String deleteFile(HttpSession session) throws IOException{
		
		return "Redirect:storage";
	}
	
/*	@RequestMapping(value="ajaxdownload", method=RequestMethod.GET)
	public void ajaxdownload(HttpServletRequest request,String filename,HttpServletResponse response) throws UnsupportedEncodingException, IOException{
			//response header ?�꼷�젟
			String fname = new String(filename.getBytes("ISO8859-1"),"UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename="+new String(fname.getBytes(),"ISO8859-1"));
			String fullPath = request.getServletContext().getRealPath("\\upload")+"\\"+fname;
			FileInputStream fin = new FileInputStream(fullPath );
			ServletOutputStream sout = response.getOutputStream();
			byte[] buffer = new byte[1024];
			
			int size=0;
			
			while((size = fin.read(buffer,0,buffer.length))!=-1){
				sout.write(buffer,0,size);
			}
			fin.close();sout.close();
	}
*/}
