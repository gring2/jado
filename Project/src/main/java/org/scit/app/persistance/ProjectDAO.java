package org.scit.app.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import org.scit.app.vo.Chat;
import org.scit.app.vo.GantMember;
import org.scit.app.vo.Gantchart;
import org.scit.app.vo.Meeting;
import org.scit.app.vo.Project;
import org.scit.app.vo.Storage;
import org.scit.app.vo.Theme;
import org.scit.app.vo.User;
import org.scit.app.vo.Vote;



public interface ProjectDAO {
	public void insertProject(Project project);
	public void insertUser(Map<String,String> keyword);
	
	public void deleteUser(String memNum);
	public void deleteProject(String proNum);
	public void endProject(String proNum);
	public List<User> selectUserList(String proNum);
	
	public void insertTheme(Theme theme);
	
	public void deleteTheme(String thmNum);
	
	public void insertChat(Chat chat);
	public void insertVote(Vote vote);
	public List<Chat> selectChatList(Map<String,String> keyword);
	public void insertStorage(Storage storage);	
	public List<Storage> selectStorageList(String proNum);	
	
	public void insertGantchart(Gantchart gantchart);	
	public void insertGantMember(GantMember gantMember);
	
	public List<Gantchart> selectGantchart(String proNum);	
	public List<Meeting> selectMeetingList(String proNum);
	public void deleteGantchart(String proNum);
	public List<GantMember> selectGantMember(String gantNum);
	
}
