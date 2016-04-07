package org.scit.app.persistence;

import java.util.List;

import org.scit.app.vo.User;

public interface UserDao {
	public List<User> select();

	public int insert(User user);

	public User selectOne(String id);
}
