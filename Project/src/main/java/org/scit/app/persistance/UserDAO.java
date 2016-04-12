package org.scit.app.persistance;

import java.util.List;

import org.scit.app.vo.Project;
import org.scit.app.vo.Scrap;
import org.scit.app.vo.User;


public interface UserDAO {
	public void insertUser(User user);	
	public int idCheck(String id);	
	public void selectUser(User user);	
	public void updateUser(User user);
	public List<Project> selectProjectList(String userNum);
	public void agreeProject(String memNum);	
	public void disagreeProject(String memNum);	
	public List<Scrap> selectScrapList(Object String);
}
