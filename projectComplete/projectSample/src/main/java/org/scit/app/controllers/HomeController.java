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
import org.scit.app.vo.GantMember;
import org.scit.app.vo.Gantchart;
import org.scit.app.vo.Message;
import org.scit.app.vo.Notice;
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

	//////////////지민:간트 관련된 메소드 모두 교체
	@RequestMapping(value="gantchartView",method=RequestMethod.GET)
	public String gantchartView(Model model, HttpSession session){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
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
	public @ResponseBody void insertGantchart(Gantchart gantchart, HttpSession session){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		dao.deleteGantchart((String)session.getAttribute("proNum"));
		dao.insertGantchart(gantchart);		
		return;
	}
	@RequestMapping(value="deleteGantchart",method=RequestMethod.POST)
	
	public @ResponseBody void deleteGantchart(String gantNum){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		dao.deleteGantchart(gantNum);
	}
	
	
	@RequestMapping(value="insertGantMember",method=RequestMethod.POST)
	
	public @ResponseBody void insertGantMember(GantMember gantMember){
		System.out.println(gantMember);
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		dao.insertGantMember(gantMember);
	}
	@RequestMapping(value="updateGantMember",method=RequestMethod.POST)	
	public @ResponseBody void updateGantMember(GantMember gantMember){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		System.out.println(gantMember);
		dao.updateGantMember(gantMember);
	}
	@RequestMapping(value="deleteGantMember",method=RequestMethod.POST)
	public @ResponseBody void deleteGantMember(GantMember gantMember){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		dao.deleteGantMember(gantMember);
	}
	@RequestMapping(value="updategantPercent",method=RequestMethod.POST)
	
	public @ResponseBody void updategantPercent(GantMember gantMember){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		dao.updategantPercent(gantMember);
	}
	@RequestMapping(value="gantchartShowView",method=RequestMethod.GET)
	public String gantchartShowView(HttpSession session, Model model){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		List<Gantchart> gantchartlist=dao.selectGantchart((String)session.getAttribute("proNum"));
		for (int i=0;i<gantchartlist.size();i++){
			gantchartlist.get(i).setGantMemberList(dao.selectGantMember(gantchartlist.get(i).getGantNum()));
			System.out.println(gantchartlist.get(i));
		}
		model.addAttribute("gantchartlist", gantchartlist);
		return "gantchartShow";			
	}
	@RequestMapping(value="gantchartViewMember",method=RequestMethod.GET)
	public String gantchartViewMember(Model model, HttpSession session){
		ProjectDao dao=sqlSession.getMapper(ProjectDao.class);
		List<User> userList=dao.selectUserList((String)session.getAttribute("proNum"));
		List<Gantchart> gantchartlist=dao.selectGantchart((String)session.getAttribute("proNum"));
		for (int i=0;i<gantchartlist.size();i++){
			gantchartlist.get(i).setGantMemberList(dao.selectGantMember(gantchartlist.get(i).getGantNum()));
			System.out.println(gantchartlist.get(i));
		}
		model.addAttribute("gantchartlist", gantchartlist);
		model.addAttribute("userList", userList);
		return "gantchartViewMember";			
	}
	
	////////////여기까지

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

	@RequestMapping(value="reply", method = RequestMethod.GET)
	public String reply(String sender, String receiver, Model model){
		System.out.println(sender+" : "+receiver);
		model.addAttribute("sender", sender);
		model.addAttribute("receiver", receiver);
		return "reply";
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
			String savedFile=storage.getThmNum()+
					"_"+originalFile;
			//deployed 경로 알아오기
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
		return redirect;
		
	}
	
	
	
	
	@RequestMapping(value="download", method=RequestMethod.GET)
	public void download(HttpServletRequest request,String fileName,HttpServletResponse response) throws UnsupportedEncodingException, IOException{
			System.out.println(fileName);
			//response header 수정
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
	@RequestMapping(value="notice", method=RequestMethod.GET)
	public String notice(Model model, String proNum){
		int x=0;
		ProjectDao dao = sqlSession.getMapper(ProjectDao.class);
		
		List<Notice>noticeList=dao.viewNotice(proNum);
		model.addAttribute("noticeList", noticeList);
		return "notify";
	}
}
