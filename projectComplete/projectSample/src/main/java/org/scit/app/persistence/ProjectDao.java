package org.scit.app.persistence;

import java.util.List;
import java.util.Map;

import org.scit.app.vo.Chat;
import org.scit.app.vo.GantMember;
import org.scit.app.vo.Gantchart;
import org.scit.app.vo.Meeting;
import org.scit.app.vo.Notice;
import org.scit.app.vo.Project;
import org.scit.app.vo.Storage;
import org.scit.app.vo.Theme;
import org.scit.app.vo.User;
import org.scit.app.vo.Vote;


public interface ProjectDao {
	public int insertProject(Project project);
	public void insertMember(Map<String,String> keyword);
	public int deleteALLTheme(String proNum);
	public int deleteALLMember(String proNum);
	public void deleteUser(String memNum);
	public int deleteProject(String proNum);
	public void endProject(String proNum);
	public List<User> selectUserList(String proNum);
	
	public void insertTheme(Theme theme);
	
	public int deleteTheme(String thmNum);
	
	public void insertChat(Chat chat);
	public void insertVote(Vote vote);
	public List<Theme> selectThemeList(String proNum);
	public List<Chat> selectChatList(Map<String,String> keyword);
	public void insertStorage(Storage storage);	
	public List<Storage> selectStorageList(String proNum);	
	
	public List<Meeting> selectMeetingList(String proNum);
	public void insertLeader(String userNum);
	public String selectProject(String group);
	public List<Chat> selectBookList(String string);
	public List<Chat> viewBook(Map<String, String> keyword);
	public void noticeReg(Map<String, String> keyword);
	public List<Notice> viewNotice(String proNum);
	public int deleteNotice(Notice notice);
	public Storage selectStorage(String fileName);
	public int deleteStorage(String fileName);
	
	public void insertGantchart(Gantchart gantchart);	
	public void deleteGantchart(String gantNum);	
	public List<Gantchart> selectGantchart(String proNum);	
	
	public void insertGantMember(GantMember gantMember);
	public void deleteGantMember(GantMember gantMember);
	public void updateGantMember(GantMember gantMember);
	public void updategantPercent(GantMember gantMember);//지민: 추가됨
	public List<GantMember> selectGantMember(String gantNum);
	
}