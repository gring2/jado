package org.scit.app.persistence;

import java.util.List;
import java.util.Map;

import org.scit.app.vo.Chat;
import org.scit.app.vo.Message;
import org.scit.app.vo.Scrap;

public interface ChatDao {
	public void insertRecord(Chat chat);
	public void insertscrap(Scrap chat);
	public List<Scrap> readScrapList(String userNum);
	public String getScrap(Scrap scrap);
	public void updateScrap(Scrap scrap);
	public void insertMessage(Message msg);
	public List<Message> selectMsgList(String receiver);
	public void deleteInvite(Map<String, String> keyword);
}
