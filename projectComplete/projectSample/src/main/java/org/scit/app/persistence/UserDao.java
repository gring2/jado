package org.scit.app.persistence;

import java.util.List;

import org.scit.app.vo.Message;
import org.scit.app.vo.Project;
import org.scit.app.vo.Scrap;
import org.scit.app.vo.User;

public interface UserDao {
	public void insertUser(User user);	
	public int idCheck(String id);	
	public User selectUser(User user);	
	public void updateUser(User user);
	public List<Project> selectProjectList(String userNum);
	public void agreeProject(String memNum);	
	public void disagreeProject(String memNum);	
	public List<Scrap> selectScrapList(Object String);
	public User selectReceiver(String receiver);

}
